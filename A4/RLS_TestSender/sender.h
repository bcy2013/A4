#ifndef SENDER_H
#define SENDER_H

#include <QObject>
#include<QTimer>
#include<QUrl>
#include<QtNetwork/QUdpSocket>
#include<QByteArray>
#include<QFile>
#include<QFileInfo>
#include <QFileSelector>
#include <QQmlFile>
#include <QQmlFileSelector>
#include<QList>
#include<QDateTime>

#define DATAGRAM_LENGTH 300
class sender : public QObject
{
    Q_OBJECT
public:
    explicit sender(QObject *parent = 0);

      Q_INVOKABLE  void startBroadcastsender(const QUrl &url, QString earliestTime, QString lastestTime);
      Q_INVOKABLE void stopBroadcastsender();
      Q_INVOKABLE void sendInitConnectionCMD();
      Q_INVOKABLE QList<QString> getTimeList();
    Q_INVOKABLE quint16 getTimeListLength();
signals:

public slots:
    void SendDataGram(QByteArray datagram,quint16 port);
    void broadcastdataGram();
    QString paraseTimeStamps(QByteArray buf);
    QString  contraryByteArray(const QString &buf);

private:
    QList<QString> timeList;
    QByteArray buf;
    QTimer* timer;
    QUdpSocket *udpSocket;
};

#endif // SENDER_H
