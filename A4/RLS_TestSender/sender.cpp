#include "sender.h"
#include<QDebug>
sender::sender(QObject *parent) :
    QObject(parent)
{
    udpSocket=new QUdpSocket(this);
    timer=new QTimer(this);
   connect(timer, SIGNAL(timeout()), this, SLOT(broadcastdataGram()));
}
void sender::sendInitConnectionCMD (){
    QByteArray pCmdBuf(40,0);
    pCmdBuf[ 0 ] = 0xFF;
    pCmdBuf[ 1 ] = 0xFF;
    pCmdBuf[ 2 ] = 0xFF;
    pCmdBuf[ 3 ] = 0xFF;
    pCmdBuf[ 4 ] = 0x40;
    pCmdBuf[ 5 ] = 0x48;//pc->探头传输方向 4-7
    pCmdBuf[8]=0x7F;//主控PC ID 暂定为0  4-11
    pCmdBuf[12]=0x7F;//DevID  预留   4-15
    pCmdBuf[16]=0x0081;//查询状态 4-19
                                          //Cmd为0x0001,data 全为0    16-35
    pCmdBuf[36]=0xDD;
    pCmdBuf[37]=0xCC;
    pCmdBuf[38]=0xBB;
    pCmdBuf[39]=0xAA;//校验位   算法未定，不为0xFFFF即可，全设为0   4-39
   this->SendDataGram (pCmdBuf,9999);
}
void sender::startBroadcastsender (const QUrl &url, QString earliestTime, QString lastestTime){
       if(!url.isValid ())
        return;
       const QString filePath = QQmlFile::urlToLocalFileOrQrc(url);
       QFile file(filePath);
       if(!file.exists ())
           return;
       if (file.open(QFile::ReadOnly)) {
             buf= file.readAll();
             quint32 bufSize=buf.size ()/DATAGRAM_LENGTH;
             for(int i=0;i<bufSize;i++)
             {
                 timeList<<paraseTimeStamps (buf.mid (i*DATAGRAM_LENGTH+8,8).toHex ());
             }
             quint16 index1=timeList.indexOf (earliestTime);
             quint16 index2=timeList.indexOf (lastestTime);
             buf=buf.mid (index1*DATAGRAM_LENGTH,(index2-index1+1)*DATAGRAM_LENGTH);
           }
    timer->start (1000);
}
void sender::SendDataGram (QByteArray datagram, quint16 port){
   udpSocket->writeDatagram(datagram.data(), datagram.size(),
                            QHostAddress::Broadcast, port);
}
void sender::broadcastdataGram (){
    qDebug()<<"Strat Sender";
    QByteArray datagram(DATAGRAM_LENGTH,0);
    datagram=buf.mid (0,DATAGRAM_LENGTH);//296长度+4
    this->SendDataGram (datagram,9999);
   qDebug()<<datagram.toHex ();
    buf.remove (0,DATAGRAM_LENGTH);
    buf.append (datagram);
    datagram.clear ();
}
void sender::stopBroadcastsender (){
    timer->stop ();
      qDebug()<<"Stop Sender";
}
QString sender::paraseTimeStamps (QByteArray buf){
    char* chatArray=buf.data ();
    QString str,temp;
    qint64 timeSec;
    qint64 timeMec;
    while (*chatArray) {
        str.append (*chatArray);
        chatArray++;
    }
    temp=contraryByteArray (buf);
    bool ok;
      timeSec=temp.left(8).toInt(&ok,16); //dec=255 ; ok=rue
      timeMec=  temp.right(8).toInt(&ok,16);
      if(ok)
      return QDateTime::fromMSecsSinceEpoch (timeSec*1000+timeMec).toString ( "yyyyMMdd:hhmmsszzz");
}
QString sender::contraryByteArray (const QString &buf){
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
QList<QString> sender::getTimeList (){
    return timeList;
}
quint16 sender::getTimeListLength (){
    return timeList.length ();
}
