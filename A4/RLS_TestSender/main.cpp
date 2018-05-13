#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"documenthandler.h"
#include"sender.h"
#include<QtQml>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
     qmlRegisterType<DocumentHandler>("io.qt.examples.texteditor", 1, 0, "DocumentHandler");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
     engine.rootContext ()->setContextProperty ("Sender",new sender());

    return app.exec();
}
