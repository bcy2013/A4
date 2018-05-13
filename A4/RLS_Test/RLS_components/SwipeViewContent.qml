import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "../RLSTheme"

Item {
    id:root
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset:-180
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -100
    property string title: "Title"
    property string contentText1: ""
    property string contentText2: ""
    property string contentText3: ""
    property string contentText4: ""
    property string buttonText: "Next"
    property int currentPage: 0
    signal nextPage()

    ColumnLayout{
        spacing: 20
         anchors.horizontalCenter: parent.horizontalCenter
        Label{
            id:tittle
            anchors.horizontalCenter: parent.horizontalCenter
            text:"[ "+root.title+" ]"
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F2
            font.bold: true
            color:RLSTheme.backgroundColor.C2
        }
        Label{
            id:content1
            text:root.contentText1
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F3
            color:RLSTheme.textColor.C9
        }
        Label{
            id:content2
            text:root.contentText2
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F3
            color:RLSTheme.textColor.C9
        }
        Label{
            id:content3
            text:root.contentText3
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F3
            color:RLSTheme.textColor.C9
        }
        Label{
            id:content4
            text:root.contentText4
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F3
            color:RLSTheme.textColor.C9
        }
        Button{
            id:control
            anchors.horizontalCenter: parent.horizontalCenter
            text:root.buttonText
            font.family: RLSTheme.fontFamily
            font.pixelSize:RLSTheme.fontSize.F3
            onClicked:root.nextPage()
            contentItem: Text {
                      text: control.text
                      font: control.font
                      opacity: enabled ? 1.0 : 0.3
                      color: RLSTheme.textColor.C9
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                  }
            background: Rectangle {
                     implicitWidth: 120
                     implicitHeight: 48
                     opacity: enabled ? 1 : 0.3
                     color:control.pressed?"#55928c":"#68b5ae"
                     radius: RLSTheme.buttonRadius
                 }

        }

    }



}
