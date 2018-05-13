import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../RLSTheme"
Item {
    anchors.fill: parent
    //property int number: 100
    property int leftMargin: 20
    property int rightMargin: 20
    property var componentModel: [

        {name:qsTr("帮助"),icon:"Image",component:helpView},
    ]
    Loader{
        id:componentloader
        //anchors.centerIn: parent
        visible: status == Loader.Ready
        sourceComponent: componentModel[controlData.componentIndex].component

    }
    Loader{
        id:helpSwipeView
        visible: status == Loader.Ready


    }
    Component{
        id:helpView
        Rectangle{
           id:helpViewConent
           width:1920
           height:1014
           color: RLSTheme.backgroundColor.C3

            ColumnLayout{
                spacing: 40
                anchors.centerIn: parent
                Label{
                    id:label
                    text:qsTr("欢迎进入RLS-1000A放射性物质定位系统软件操作指南")
                    font.family: RLSTheme.fontFamily
                    font.pixelSize: RLSTheme.fontSize.F1
                    color:RLSTheme.textColor.C9
                }
                Button{
                    id:control
                    text:qsTr("了解详情")
                    Layout.preferredWidth:120
                    Layout.preferredHeight: 48
                    anchors.horizontalCenter: label.horizontalCenter
                    font.family: RLSTheme.fontFamily
                    font.pixelSize:RLSTheme.fontSize.F3
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
                    onClicked:{

                        helpSwipeView.setSource("RLSHelpSwipeView.qml")

                    }
                }

            }

        }


    }
}
