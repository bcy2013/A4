import QtQuick 2.7
import QtQuick.Controls 2.0
Rectangle {
    id:root
    property alias text: labelText.text
    implicitWidth:94
    height:logoImage.height+6+labelText.height
    color:"transparent"
    FontLoader { id: webFont; source: "lan.TTF" }
    Image{
        id:logoImage
        fillMode: Image.PreserveAspectFit
        source: "../icons/Logo.png"
    }
    Label{
        id:labelText
        text: qsTr("放射性位置定位系统")
        color:"#ffffff" 
        anchors.top: logoImage.bottom
        anchors.topMargin: 6
        font.family: webFont.name
        font.pixelSize: 12
    }
}
