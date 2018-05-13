//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
#include"./reciver.h"
#include<QQmlEngine>
#include <QApplication>
#include <QQuickView>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QGuiApplication app(argc, argv);
    qmlRegisterType<reciver>("Reciver", 1, 0, "Reciver");
    //QQmlApplicationEngine engine;
    //engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    QApplication app(argc, argv);
    QQuickView viewer;
    viewer.setSource(QUrl("qrc:///loadMainWindow.qml"));
    viewer.setColor ("transparent");
     viewer.setFlags( Qt::FramelessWindowHint );
    if (viewer.status() == QQuickView::Error)
        return -1;
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);
    viewer.show();
    return app.exec();
}
