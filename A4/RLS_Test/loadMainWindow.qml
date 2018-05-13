import QtQuick 2.7
Item {
    id:root
    Loader{
        id:loader
        width:1
        height:1
        asynchronous: true
        onLoaded: Qt.quit()
    }
    Component.onCompleted: {
      // loader.sourceComponent= Qt.createComponent("RLS_components/RlsTest.qml");
        loader.sourceComponent= Qt.createComponent("main.qml");
    }

}
