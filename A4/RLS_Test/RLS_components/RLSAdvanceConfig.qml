import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import AdvanceConfig 1.0
import "../RLSTheme"
ApplicationWindow {
     id:mainWindow
     width:1920
     height:1080
     modality: Qt.ApplicationModal
     color:RLSTheme.backgroundColor.C3
     flags: Qt.Window
     //内部属性列表
      readonly property bool contentLoaded: contentLoader.item
      property int currentMenu: -1
      readonly property alias anchorItem: controlsMenu
      readonly property int menuWidth: 120
      readonly property int menuMargins: 13
      readonly property int textMargins: 32
      onCurrentMenuChanged: {
          xBehavior.enabled = true;
          anchorCurrentMenu();
      }

      onMenuWidthChanged: anchorCurrentMenu()

      function anchorCurrentMenu() {
          switch (currentMenu) {
          case -1:
              anchorItem.x = -menuWidth;
              break;
          case 0:
              anchorItem.x = 0;
              break;
          case 1:
              anchorItem.x = -menuWidth * 2;
              break;
          }
      }

     Item{
         id:container//主容器
         anchors.fill: parent


//         InputPanel{
//             id:inputPanel
//             z:10
//             width:720
//             opacity:0
//            // visible: account.activeFocusOnPress||password.activeFocusOnPress
//             anchors.top: parent.bottom
//             anchors.topMargin: 10
//             anchors.horizontalCenter: parent.horizontalCenter
//             states: State {
//                 name: "visible"
//                 /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
//                     but then the handwriting input panel and the keyboard input panel can be visible
//                     at the same time. Here the visibility is bound to InputPanel.active property instead,
//                     which allows the handwriting panel to control the visibility when necessary.
//                 */
//                 when:inputPanel.active
//                 PropertyChanges {
//                     target: inputPanel
//                     opacity: 1
//                 }
//             }
//             transitions: Transition {
//                 from: ""
//                 to: "visible"
//                 reversible: true
//                 ParallelAnimation {
//                     NumberAnimation {
//                         properties: "opacity"
//                         duration: 400
//                         easing.type: Easing.InOutQuad
//                     }
//                 }
//             }
//          }


     //侧边的选项列表
     Rectangle{
         id:controlsMenu
         x:container.x-width
         width:menuWidth
         height:parent.height
         color:RLSTheme.backgroundColor.C3
            //x方向的弹出动画
         Binding{
             target: controlsMenu
             property: "x"
             value: container.x-controlsMenu.width
             when:!xBehavior.enabled&&!xNumberAnimation.running&&currentMenu==-1

         }
         Behavior on x{
             id:xBehavior
             enabled: true
             NumberAnimation{
                 id:xNumberAnimation
                 duration: 500
                 easing.type: Easing.OutExpo
                 onRunningChanged: xBehavior.enabled=false
             }
         }
         Rectangle{
             id:controlsTitleBar
             width:parent.width
             height:toolBar.height
             color:RLSTheme.backgroundColor.C1
             RLSLogo{
                    id:logo
                    anchors.left: parent.left
                    anchors.leftMargin: 11
                    anchors.top: parent.top
                    anchors.topMargin: 10
                }
         }

             ListView{
                 id:controlView
                 width:parent.width
                 anchors.top: controlsTitleBar.bottom
                 anchors.bottom: parent.bottom
                 clip:true
                 currentIndex: 0
                 model:contentLoaded ? contentLoader.item.componentModel : null
                 delegate: MouseArea{
                     id:delegateItem
                     width:parent.width
                     height:98
                     Rectangle{
                         id:separate
                         width:parent.width
                         height:2
                         anchors.top:parent.top
                         color:"transparent"
                     }

                    Rectangle{
                        id:rec
                        anchors.top:separate.bottom
                        anchors.bottom: parent.bottom
                        width: parent.width
                        color:delegateItem.ListView.isCurrentItem?"#4e4e4e":"#757676"

                      Column{
                          anchors.centerIn: parent
                          spacing: 6
                      Image{
                          id:labelLogo
                          width:32
                          height:32
                          anchors.horizontalCenter: label.horizontalCenter
                          source:delegateItem.ListView.isCurrentItem?
                                     "../icons/"+delegateItem.ListView.view.model[index].icon+"-b.png":
                                     "../icons/"+delegateItem.ListView.view.model[index].icon+".png"
                      }

                     //代理的显示内容
                     Label{
                         id:label
                         text: delegateItem.ListView.view.model[index].name
                         font.pixelSize:RLSTheme.fontSize.F3
                         font.family:RLSTheme.fontFamily
                         renderType: Text.QtRendering
                         color: delegateItem.ListView.isCurrentItem ? RLSTheme.textColor.C7 : RLSTheme.textColor.C9
//                         anchors.left: row.left
//                         anchors.leftMargin: menuMargins
//                         anchors.verticalCenter: row.verticalCenter
                        }
                      }//row
                    }//rect

                     onClicked: {
                         if (controlView.currentIndex != index)
                             controlView.currentIndex = index;

                         currentMenu = -1;
                     }
                 }
             }


         Rectangle{
             //阴影效果
                 width:parent.height
                 height:8
                 rotation: 90
                 anchors.left:parent.right
                 transformOrigin: Item.TopLeft
                 gradient: Gradient{
                         GradientStop{
                                 color:Qt.rgba(0,0,0,0.15)
                                 position: 0
                         }
                         GradientStop{
                                 color:Qt.rgba(0,0,0,0.05)
                                 position: 0.5
                         }
                         GradientStop{
                                 color:Qt.rgba(0,0,0,0)
                                 position: 1
                         }
                 }
         }
     }
     //显示内容区域


     Item{
         id:contentContainer
         anchors.top: parent.top
         anchors.bottom: parent.bottom
         anchors.left: controlsMenu.right
         width:parent.width
         AdvanceConfig{
             id:advanceConfig
         }
         ToolBar{
             id:toolBar
             visible: true
             height:66
             width: parent.width
             z:contentLoader.z + 1
             padding: 0
             background: Rectangle{
                 color:RLSTheme.backgroundColor.C1
             }

             RowLayout{
                 anchors.fill: parent
                 MouseArea{
                    id:controlsButton
                    Layout.preferredWidth: toolBar.height+textMargins
                    Layout.preferredHeight: toolBar.height
                    onClicked:currentMenu=currentMenu==0?-1:0
                    Image{

                        source:"../icons/listMenu.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin:20
                    }

                 }
                 Row{
                     anchors.centerIn: parent
                     spacing: 6
                     Image{
                         anchors.verticalCenter:title.verticalCenter
                         source:"../icons/D-Advanced Settings.png"
                     }
                 Text{
                     id:title
                     text: qsTr("高级设置")
                     font.family:RLSTheme.fontFamily
                     font.pixelSize: RLSTheme.fontSize.F2
                     horizontalAlignment: Text.AlignHCenter
                     color:RLSTheme.textColor.C9
                     Layout.fillWidth: true
                   }
                 }//Row

                     Image {
                         id:exitIcon
                         width: 40
                         height: 26
                         source:"../icons/listClose.png"
                         anchors.verticalCenter: parent.verticalCenter
                         anchors.right: parent.right
                         anchors.rightMargin:20
                         MouseArea{
                             anchors.fill: parent
                             onClicked: {
                                 advanceConfig.setCmdInfo();
                                 mainWindow.close();
                             }
                         }
             }//Image
           }
         }


         Loader{
             id:contentLoader
             anchors.left:parent.left
             anchors.right: parent.right
             anchors.top:toolBar.bottom
             anchors.bottom: parent.bottom
             property QtObject controlData: QtObject {
                 readonly property int componentIndex: controlView.currentIndex
                 readonly property int textMargins: mainWindow.textMargins
             }

             MouseArea {
                 enabled: currentMenu != -1
                 // We would be able to just set this to true here, if it weren't for QTBUG-43083.
                 hoverEnabled: enabled
                 anchors.fill: parent
                 preventStealing: true
                 onClicked: currentMenu = -1
                 focus: enabled
                 z: 1000
             }
        }
      }
     Component.onCompleted: {
         mainWindow.visible=true
         showFullScreen()
         contentLoader.sourceComponent = Qt.createComponent("AdvanceConfigContent.qml")
        }
   }

}

