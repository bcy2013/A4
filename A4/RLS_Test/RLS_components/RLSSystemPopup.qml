import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"


Rectangle{
    id:root
    implicitWidth: 520
    implicitHeight: 320
    property alias  contentText:label.text
    property alias   buttonText:button.text
    signal closePop()
    signal handlePop()

    property real leftM: 5
    property real topM: 66
    property real bottomM: 20
    property real rightM: 5

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



    Rectangle{
        id:content
        anchors.left: parent.left
        anchors.leftMargin: leftM
        width:parent.width-leftM-rightM
        anchors.top: parent.top
        anchors.topMargin: topM
        height:parent.height-topM-bottomM
        color:RLSTheme.backgroundColor.C6
     Label{
         id:label
         font.family: RLSTheme.fontFamily
         font.pixelSize: RLSTheme.fontSize.F1
         color:RLSTheme.textColor.C8
         font.bold: true
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.top: parent.top
         anchors.topMargin: (parent.height-15-button.height-label.contentHeight)/2
        }



        RLSButton{
             id:button
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 15
             anchors.horizontalCenter: parent.horizontalCenter
             onClicked: root.handlePop()

        }
    }
}

