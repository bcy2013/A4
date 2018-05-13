import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"


Rectangle{
    id:root
    implicitWidth: 742
    implicitHeight: 788
    signal closePop()

    property real leftM: 5
    property real topM: 66
    property real bottomM: 20
    property real rightM: 5
    property string imageSource: imagesPath+"/images/18112016154125601.jpg"

    color:RLSTheme.backgroundColor.C1
    radius:RLSTheme.buttonRadius

    Image{
        id:closeButton
        width: 32
        height:32
        fillMode: Image.PreserveAspectFit
        source: "../icons/close.png"
        anchors.top: parent.top
        anchors.topMargin: (topM-closeButton.height)/2
        anchors.right: parent.right
        anchors.rightMargin: bottomM
        smooth: true
        MouseArea{
            anchors.fill: parent
            onClicked: root.closePop()
        }

    }

    RLSLogo{
        anchors.left: parent.left
        anchors.leftMargin:bottomM
        anchors.top: parent.top
        anchors.topMargin: 10


    }
    Label{
        id:title
        text:qsTr("敏感图片")
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter

        font.family:RLSTheme.fontFamily
        font.pixelSize: RLSTheme.fontSize.F2
        horizontalAlignment: Text.AlignHCenter
        color:RLSTheme.textColor.C9
    }



    Rectangle{
        id:content
        anchors.left: parent.left
        anchors.leftMargin: leftM
        width:parent.width-leftM-rightM
        anchors.top: parent.top
        anchors.topMargin: topM
        height:parent.height-topM-bottomM
        color:"black"
        Image{
             height:parent.height
             fillMode: Image.PreserveAspectFit
             source: imageSource
             anchors.horizontalCenter: parent.horizontalCenter

        }
    }
}

