#include "reciver.h"
#include"RlsCommonFunction.h"
#include"QCoreApplication"
#include<QDebug>
reciver::reciver(QObject *parent) : QObject(parent)
{
     m_bIsConnected=false;
     m_strDeviceName="";
     m_nDeviceSendPort=0000;
     m_nDeviceRecivePort=9999;
    m_dDataVector=QVector<int>(LIVE_DATAGRAM_ENERGYDATA_LENGTH/2);
    m_nHighVoltage=0;
    m_nThreshold=0;
     m_nRawDataLen      = 0;
     pBuf_Save=new char[RAWDATA_BUF_LEN];
     memset (pBuf_Save,0,RAWDATA_BUF_LEN);//初始化全置零
     m_pTimer=new QTimer(this);
     connect(m_pTimer, SIGNAL(timeout()), this, SLOT(WriteRawDataFile()));
    // initConnectinon ();
    //groupAddress = QHostAddress("239.255.43.21");
     udpSocket = new QUdpSocket(this);
    // udpSocket->connectToHost (QHostAddress::LocalHost,9999);
   udpSocket->bind (9999,QUdpSocket::ShareAddress);
//            if(!udpSocket->waitForReadyRead ()){
//                qDebug()<<"EEEEE";
//            }
     //udpSocket->bind(QHostAddress::AnyIPv4, 9999, QUdpSocket::ShareAddress| QUdpSocket::ReuseAddressHint);
     //if(udpSocket->joinMulticastGroup(groupAddress) ){

     connect(udpSocket, SIGNAL(readyRead()),
                 this, SLOT(processPendingDatagrams()));

    // }
}
bool reciver::isConnected ()const{
    return m_bIsConnected;
}
void reciver::setIsConnected (const bool &isConnected){
    m_bIsConnected=isConnected;
    emit isConnectedChanged ();
}

QString reciver::deviceName ()const{
    return m_strDeviceName;
}
void reciver::setDeviceName (const QString &deviceName){
    if(m_strDeviceName!=deviceName)
    {m_strDeviceName=deviceName;
    emit deviceNameChanged ();}
}
quint16 reciver::deviceSendPort ()const{
    return m_nDeviceSendPort;
}
void reciver::setDeviceSendPort (const quint16 &deviceSendPort){
    m_nDeviceSendPort=deviceSendPort;
    emit deviceSendPortChanged ();
}
quint16 reciver::deviceRecivePort ()const{
    return m_nDeviceRecivePort;
}
void reciver::setDeviceRecivePort (const quint16 &deviceRecivePort){
    if(m_nDeviceRecivePort!=deviceRecivePort)
        m_nDeviceRecivePort=deviceRecivePort;
    emit deviceRecivePortChanged ();\
}
QVector<int> reciver::dataVector ()const{
    return m_dDataVector;
}
void reciver::setDataVector (const QVector<int> &dataVector){
  //  if(m_dDataVector!=dataVector)
        m_dDataVector=dataVector;
    emit dataVectorChanged ();
}
quint16 reciver::highVoltage ()const{
        return m_nHighVoltage;
}
void reciver::setHighVoltage (const quint16 &highVoltage){
    if(m_nHighVoltage!=highVoltage)
        m_nHighVoltage=highVoltage;
    emit highVoltageChanged ();
}
quint16 reciver::threshold ()const{
    return m_nThreshold;
}
void reciver::setThreshold (const quint16 &threshold){
    if(m_nThreshold!=threshold)
        m_nThreshold=threshold;
    emit thresholdChanged ();
}

int reciver::ConvertHexToInt (int a){
    return QByteArray::number (a,16).toInt ();
}
int reciver::getY (const int &index){
    return m_dDataVector[index];
}
void reciver::closeClientConnection (){
    setDeviceName ("");
    setIsConnected (false);
    setDeviceSendPort (0000);
    sendStopSendDataCmd();
}
void reciver::SendCmdDataGram (QByteArray buf, qint16 port){
//   QByteArray datagram;
//   for(int i=0;i<len;++i){
//       datagram.insert (i,buf[i]);
//   }
//   //datagram.append ((const char*)buf,len);
   udpSocket->writeDatagram (buf.data (),buf.size (), QHostAddress("192.168.10.203"),port);
   // qint64 i=udpSocket->writeDatagram (buf.data (),buf.size (), QHostAddress::Broadcast,port);
   // qDebug()<<i;
}
void reciver::initConnectinon (){
        QByteArray pCmdBuf(40,0);
        pCmdBuf[ 0 ] = 0xFF;
        pCmdBuf[ 1 ] = 0xFF;
        pCmdBuf[ 2 ] = 0xFF;
        pCmdBuf[ 3 ] = 0xFF;
        pCmdBuf[ 4 ] = 0x48;
        pCmdBuf[ 5 ] = 0x40;//pc->探头传输方向 4-7
        pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
        pCmdBuf[12]=0x7F;//DevID  预留   4-15
        pCmdBuf[16]=QueryStatus&0x000F;//查询状态 4-19
                                              //Cmd为0x0001,data 全为0    16-35
        pCmdBuf[36]=0xDD;
        pCmdBuf[37]=0xCC;
        pCmdBuf[38]=0xBB;
        pCmdBuf[39]=0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
       this->SendCmdDataGram (pCmdBuf,9999);
        qDebug()<<pCmdBuf.toHex ();
}
void reciver::sendParameterSettingCmd (){
         QByteArray pCmdBuf(40,0);
         pCmdBuf[ 0 ] = 0xFF;
         pCmdBuf[ 1 ] = 0xFF;
         pCmdBuf[ 2 ] = 0xFF;
         pCmdBuf[ 3 ] = 0xFF;
         pCmdBuf[ 4 ] = 0x48;
         pCmdBuf[ 5 ] = 0x40;//pc->探头传输方向 4-7
         pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
         pCmdBuf[12]=0x7F;//DevID  预留   4-15
         pCmdBuf[16]=ParameterSetting&0x000F;//查询状态 4-19
                                               //Cmd为0x0002,data为设置的参数   16-35
      qDebug()<<QDateTime::currentDateTime ();
      qint64 currentSec=QDateTime::currentSecsSinceEpoch ();
      qint64  currentMSec=QDateTime::currentMSecsSinceEpoch ()-QDateTime::currentSecsSinceEpoch ()*1000;
     // qDebug()<<QDateTime::currentMSecsSinceEpoch ();
      QByteArray temp= QByteArray::number (currentMSec,16);
      qDebug()<<QDateTime::currentMSecsSinceEpoch ();
      // qDebug()<<temp;
       pCmdBuf[20]=currentSec&0xFF;
       pCmdBuf[21]=(currentSec>>8)&0xFF;
       pCmdBuf[22]=(currentSec>>16)&0xFF;
       pCmdBuf[23]=(currentSec>>24)&0xFF;

       pCmdBuf[24]=currentMSec&0xFF;
       pCmdBuf[25]=(currentMSec>>8)&0xFF;
       pCmdBuf[26]=(currentMSec>>16)&0xFF;
       pCmdBuf[27]=(currentMSec>>24)&0xFF;

       //参数配置
       temp.clear ();
       temp=QByteArray::number (m_nHighVoltage,16);

       pCmdBuf[28]=m_nHighVoltage&0xFF;
       pCmdBuf[29]=(m_nHighVoltage>>8)&0xFF;
       pCmdBuf[32]=m_nThreshold&0xFF;
       pCmdBuf[33]=(m_nThreshold>>8)&0xFF;

       pCmdBuf[36]=0xDD;
       pCmdBuf[37]=0xCC;
       pCmdBuf[38]=0xBB;
       pCmdBuf[39] =0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
        this->SendCmdDataGram (pCmdBuf,9999);
      // qDebug()<<temp;
        qDebug()<<pCmdBuf.toHex ();
}
void reciver::sendGetCurrenParameterCmd (){
    QByteArray pCmdBuf(40,0);
    pCmdBuf[ 0 ] = 0xFF;
    pCmdBuf[ 1 ] = 0xFF;
    pCmdBuf[ 2 ] = 0xFF;
    pCmdBuf[ 3 ] = 0xFF;
    pCmdBuf[ 4 ] = 0x48;
    pCmdBuf[ 5 ] = 0x40;//pc->探头传输方向 4-7
    pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
    pCmdBuf[12]=0x7F;//DevID  预留   4-15
    pCmdBuf[16]=GetCurrenParameter&0x000F;//查询状态 4-19
                                          //Cmd为0x0002,data为设置的参数   16-35
    pCmdBuf[36]=0xDD;
    pCmdBuf[37]=0xCC;
    pCmdBuf[38]=0xBB;
    pCmdBuf[39] =0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
   this->SendCmdDataGram (pCmdBuf,9999);
    qDebug()<<pCmdBuf.toHex ();
}
void reciver::sendStartSendDataCmd (){
    QByteArray pCmdBuf(40,0);
    pCmdBuf[ 0 ] = 0xFF;
    pCmdBuf[ 1 ] = 0xFF;
    pCmdBuf[ 2 ] = 0xFF;
    pCmdBuf[ 3 ] = 0xFF;
    pCmdBuf[ 4 ] = 0x48;
    pCmdBuf[ 5 ] = 0x40;//pc->探头传输方向 4-7
    pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
    pCmdBuf[12]=0x7F;//DevID  预留   4-15
    pCmdBuf[16]=StartSendData&0x000F;//查询状态 4-19
                                          //Cmd为0x0002,data为设置的参数   16-35
    pCmdBuf[36]=0xDD;
    pCmdBuf[37]=0xCC;
    pCmdBuf[38]=0xBB;
    pCmdBuf[39] =0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
   this->SendCmdDataGram (pCmdBuf,9999);
    m_pTimer->start (1000*60);
    qDebug()<<pCmdBuf.toHex ();
}
void reciver::sendStopSendDataCmd (){
    QByteArray pCmdBuf(40,0);
    pCmdBuf[ 0 ] = 0xFF;
    pCmdBuf[ 1 ] = 0xFF;
    pCmdBuf[ 2 ] = 0xFF;
    pCmdBuf[ 3 ] = 0xFF;
    pCmdBuf[ 4 ] = 0x48;
    pCmdBuf[ 5 ] = 0x40;//pc->探头传输方向 4-7
    pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
    pCmdBuf[12]=0x7F;//DevID  预留   4-15
    pCmdBuf[16]=StopSendData&0x000F;//查询状态 4-19
                                          //Cmd为0x0002,data为设置的参数   16-35
    pCmdBuf[36]=0xDD;
    pCmdBuf[37]=0xCC;
    pCmdBuf[38]=0xBB;
    pCmdBuf[39] =0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
   this->SendCmdDataGram (pCmdBuf,9999);
    qDebug()<<pCmdBuf.toHex ();
    StopWriteRawDataFile ();
}
bool reciver::IsDataGramValid (QByteArray buf){                  //判断报是否有效（包头，传输方向，校验等 ）  探头-->PC
    bool isValid_DataSize=buf.size ()==CMD_DATAGRAM_LENGTH||buf.size ()==LIVE_DATAGRAM_LENGTH;
    bool isValid_DataHeader=buf.mid (0,1).toHex ().toInt ()==ConvertHexToInt (0xFF)&&
            buf.mid (1.1).toHex ().toInt ()==ConvertHexToInt (0xFF)&&
            buf.mid (2.1).toHex ().toInt ()==ConvertHexToInt (0xFF)&&
            buf.mid (3.1).toHex ().toInt ()==ConvertHexToInt (0xFF);
    bool isValid_DataVerify=true;//校验位

    if(isValid_DataSize&&isValid_DataHeader&&isValid_DataVerify)
        return true;
    else
        return false;
}
void reciver::CmdParseDataGram (QByteArray buf){
    //判断数据报类型（控制数据/采集数据）
    if(buf.size ()==40){
    switch(buf.mid(16,1).toHex ().toInt ()  )
    {
      case 81:qDebug()<<"ReadyGo!"; setIsConnected (true);break;
      case 82:qDebug()<<"ParaSettingsReady!";break;
      case 83:qDebug()<<"GetSettingsReady!";SettingsParseDataGram(buf.mid (28,8).toHex ());break;
      case 84:qDebug()<<"StartNow!";break;
      case 85:qDebug()<<"StopNow!";break;
      default: qDebug()<<"error!";
    }
    }else{
        //开始解析原始数据
    LiveDataParseDataGram(buf);
    }
}
QString reciver::ParseTime (QByteArray buf){

    char* chatArray=buf.data ();
    QString str,temp;
    qint64 timeSec;
    qint64 timeMec;
    while (*chatArray) {
        str.append (*chatArray);
        chatArray++;
    }
    //keyi做个函数
  temp=contraryByteArray (buf);
    bool ok;
      timeSec=temp.left(8).toInt(&ok,16); //dec=255 ; ok=rue
      timeMec=  temp.right(8).toInt(&ok,16);
    //  qDebug()<<  str;
      //qDebug()<<QDateTime::fromMSecsSinceEpoch (timeSec*1000+timeMec).toString ( "yyyyMMdd:hhmmsszzz");
      return QDateTime::fromMSecsSinceEpoch (timeSec*1000+timeMec).toString ( "yyyyMMdd:hhmmsszzz");
}
void reciver::LiveDataParseDataGram (QByteArray buf){
    //0,4 数据头，4，4  设备ID，8，8 时间戳  16，24 预留  40，256  能谱数据  296,4  校验
   m_strDeviceID=buf.mid (4,4).toHex ();
   m_strTimeStamp=ParseTime(buf.mid (8,8).toHex ());
   for(int i=0, k=0;i<LIVE_DATAGRAM_ENERGYDATA_LENGTH;){
       int j=0;
       memcpy (&j,buf.mid (40+i,2),2);
       m_dDataVector[k]=j;
       i+=2;
       k++;
    }
   emit dataVectorChanged ();
   //写入缓冲区，准备保存为文件
   char * pBuf_LiveData=new char[LIVE_DATAGRAM_ENERGYDATA_LENGTH];
    pBuf_LiveData=buf.data ();
//    memcpy(pBuf_Save+m_nRawDataLen,m_strDeviceID.toLatin1(),m_strDeviceID.size ());
//    m_nRawDataLen+=m_strDeviceID.size ();
//    memcpy (pBuf_Save+m_nRawDataLen,m_strTimeStamp.toLatin1(),m_strTimeStamp.size ());
//    m_nRawDataLen+=m_strTimeStamp.size ();
    memcpy (pBuf_Save+m_nRawDataLen,pBuf_LiveData,LIVE_DATAGRAM_LENGTH);
    m_nRawDataLen+=LIVE_DATAGRAM_LENGTH;

}
void reciver::WriteRawDataFile (){
 //一些个判定
    QString strFilePath = PrepareFilePath();
    QString strRawFilePath =
        strFilePath + QDateTime::currentDateTime().toString( "/" + QString( "hhmmsszzz" ) ) + ".raw";
    m_pRawFile = new QFile( strRawFilePath );
     int nWriteLen=0;
     if(!m_pRawFile->exists ()){
         QDir strDir(strFilePath);
         if(!strDir.exists ())
               DIR_FUN:: CreateSubDir("",strFilePath);
         m_pRawFile = new QFile( strRawFilePath );
     }

     m_pRawFile->open (QIODevice::ReadWrite);
    if(m_pRawFile->isOpen()){
   nWriteLen = m_pRawFile->write( pBuf_Save, m_nRawDataLen );
    m_pRawFile->close();
    }
    if( nWriteLen == m_nRawDataLen ){
    memset (pBuf_Save,0,RAWDATA_BUF_LEN);//初始化全置零
    m_nRawDataLen=0;
    }
}
void reciver::StopWriteRawDataFile (){
    m_pTimer->stop ();
    if(m_nRawDataLen!=0)
        WriteRawDataFile();
}
void reciver::processPendingDatagrams (){
      QHostAddress address;
      quint16 port;
       while (udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
              udpSocket->readDatagram(datagram.data(), datagram.size(),&address,&port);
              if(IsDataGramValid(datagram)){
                              CmdParseDataGram(datagram);
                     }
              setDeviceSendPort (port);
              setDeviceName (address.toString ());
              qDebug()<<address.toString ();
              qDebug()<<"CmdReplay:"<<datagram.toHex ();
    }
}
QString reciver::PrepareFilePath(){
   QString strRawFilePath = QCoreApplication::applicationDirPath ();
    QString currentPath = strRawFilePath+"/"+m_strDeviceID
            + QDate::currentDate().toString( "/yyyy-MM" )
            + QDate::currentDate().toString( "/yyyy-MM-dd" );
    return currentPath;
}
void reciver::SettingsParseDataGram (QByteArray buf){
    char* chatArray=buf.data ();
    QString str,temp1;
    while (*chatArray) {
        str.append (*chatArray);
        chatArray++;
    }
   qDebug()<<buf.data();
   qDebug()<<str;
     bool ok;
     temp1=contraryByteArray (buf);
    setHighVoltage (temp1.left (8).toInt (&ok,16));
    setThreshold      (temp1.right(8).toInt (&ok,16));
}
QString reciver::contraryByteArray (const QString &buf){
    QString temp;
    temp.append (buf.mid (6,2));
    temp.append (buf.mid (4,2));
    temp.append (buf.mid (2,2));
    temp.append (buf.mid (0,2));
    temp.append (buf.mid (14,2));
    temp.append (buf.mid (12,2));
    temp.append (buf.mid (10,2));
    temp.append (buf.mid (8,2));
    return temp;

}
