#ifndef RECIVER_H
#define RECIVER_H

#include <QObject>
#include<QtNetwork/QHostAddress>
#include<QtNetwork/QUdpSocket>
#include<QDateTime>
#include <QVector>
#include<QFile>
#include<QDir>
#include<QTimer>
#define CMD_DATAGRAM_LENGTH 40
#define LIVE_DATAGRAM_LENGTH 300
#define ENABLE_CONNECTED_DEVICE 1
#define LIVE_DATAGRAM_ENERGYDATA_LENGTH 256
#define RAWDATA_BUF_LEN 2*1024*1024
class reciver : public QObject
{
    Q_OBJECT
    Q_ENUMS(CmdTypes)
    Q_PROPERTY(bool isConnected READ isConnected WRITE setIsConnected NOTIFY isConnectedChanged)
    Q_PROPERTY(QString deviceName READ deviceName WRITE setDeviceName NOTIFY deviceNameChanged)
    Q_PROPERTY(quint16 deviceSendPort READ deviceSendPort WRITE setDeviceSendPort NOTIFY deviceSendPortChanged)
    Q_PROPERTY(quint16 deviceRecivePort READ deviceRecivePort WRITE setDeviceRecivePort NOTIFY deviceRecivePortChanged)
    Q_PROPERTY(QVector<int>  dataVector READ dataVector WRITE setDataVector NOTIFY dataVectorChanged)
    Q_PROPERTY(quint16 highVoltage READ highVoltage WRITE setHighVoltage NOTIFY highVoltageChanged)
    Q_PROPERTY(quint16 threshold READ threshold WRITE setThreshold NOTIFY thresholdChanged)
public:
    explicit reciver(QObject *parent = 0);
   //属性注册
    bool isConnected()const;
    void setIsConnected(const bool& isConnected);
    QString deviceName()const;
    void setDeviceName(const QString& deviceName);
    quint16 deviceSendPort()const;
    void setDeviceSendPort(const quint16&deviceSendPort );
    quint16 deviceRecivePort()const;
    void setDeviceRecivePort(const quint16&deviceRecivePort );
    QVector<int> dataVector()const;
    void setDataVector(const QVector<int>& dataVector);

    quint16 highVoltage()const;
    void setHighVoltage(const quint16& highVoltage);
    quint16 threshold()const;
    void setThreshold(const quint16& threshold);



     //函数注册
     Q_INVOKABLE void closeClientConnection();//test用
     Q_INVOKABLE void  initConnectinon();//广播状态查询，由返回的数据报解析可连接的设备列表（目前只做1对1）
     Q_INVOKABLE  void sendStartSendDataCmd();                                                //向设备发送开始采集命令
     Q_INVOKABLE void  sendParameterSettingCmd();                                   //向设备发送参数配置命令
     Q_INVOKABLE  void sendGetCurrenParameterCmd();                                //向设备发送获取当前参数配置命令
     Q_INVOKABLE void  sendStopSendDataCmd();                                                 //向设备发送终止采集命令
    Q_INVOKABLE int getY(const int& index);//可废弃
    //类内函数

     void  SendCmdDataGram(QByteArray buf,qint16 port);
     void CmdParseDataGram(QByteArray buf);                         //解析数据包（数据/控制）命令数据绑定处理函数
     void LiveDataParseDataGram(QByteArray buf);                 //解析实时数据包
     int    ConvertHexToInt(int a);                                                  //已废弃
     bool IsDataGramValid(QByteArray buf);                              //过滤无效数据包,尺寸，包头，校验
     QString  ParseTime(QByteArray buf);                                  //解析时间戳
     void StopWriteRawDataFile();                                               //停止写入原始数据
     QString PrepareFilePath();                                                     //设置原始数据保存路径
     void SettingsParseDataGram(QByteArray buf);                       //解析设置参数
     QString  contraryByteArray(const QString &buf);              //使用的是小尾端，按字节倒叙,8字节长度

   //枚举类型注册
    enum CmdTypes{
        QueryStatus=0x0001,//设备通讯状态查询
        ParameterSetting=0x0002,//参数设置
        GetCurrenParameter=0x0003,//获取当前参数配置
        StartSendData=0x0004,//开始发送数据
        StopSendData=0x0005//停止发送数据
    };


 signals:
    void isConnectedChanged();
    void deviceNameChanged();
    void deviceSendPortChanged();
    void deviceRecivePortChanged();
    void highVoltageChanged();
    void thresholdChanged();
    void dataVectorChanged();
    void  upDataNow();

private slots:
     void processPendingDatagrams();
     void WriteRawDataFile();
    // void hasconnected();
   //  void disconnected();
protected:
        QVector<int> m_dDataVector;
private:
    bool m_bIsConnected;
    QString m_strDeviceName;
    quint16 m_nDeviceSendPort;
    quint16 m_nDeviceRecivePort;
    quint16 m_nHighVoltage;
    quint16 m_nThreshold;
    QUdpSocket *udpSocket;
    QHostAddress groupAddress;
    //实时数据包参数
    QString m_strDeviceID;
    QString m_strTimeStamp;

    //存储缓冲区
    char* pBuf_Save;
    qint32 m_nRawDataLen ;
    QFile* m_pRawFile;
    QTimer* m_pTimer;

};
//class reciverType:public reciver{
//    Q_OBJECT
//public:
//    reciverType(QObject *parent =0);
//    Q_INVOKABLE int getY(const int& index);

//};
#endif // RECIVER_H
