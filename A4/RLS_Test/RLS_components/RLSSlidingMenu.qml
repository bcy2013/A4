import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../RLSTheme"
Rectangle {
    id:root
    implicitWidth:360
    implicitHeight:1012
    color:RLSTheme.backgroundColor.C3

    ColumnLayout{
    anchors.fill: parent
    spacing: 2

    Rectangle{
        id:rlsTabBar
        height:72
        Layout.fillWidth: true
        color:RLSTheme.backgroundColor.C1
      RLSTabBar{
          id:tabBar
          position: TabBar.Footer
          width:330
          anchors.centerIn: parent

           RLSTabButton{
               id:tabButton1
               text:qsTr("实时曲线")
               checked: true
               background: Rectangle {
                   id:tabButtonRight
                   implicitHeight: 40

                   radius: 20
                   Rectangle{

                       width:40
                       height:40
                       anchors.right: parent.right
                       color:tabButtonRight.color

                   }

                   color:tabButton1.checked ? RLSTheme.backgroundColor.C1 : "transparent"

               }

           }
           RLSTabButton{
               id:tabButton2
               text:qsTr("敏感图片")
               background: Rectangle {
                   id:tabButtonLeft
                   implicitHeight: 40

                   radius: 20
                   Rectangle{

                       width:40
                       height:40
                       anchors.left: parent.left
                       color:tabButtonLeft.color

                   }

                   color:tabButton2.checked ? RLSTheme.backgroundColor.C1 : "transparent"

               }

           }

      }
    }//tabBar


    StackLayout {
         id:rlsStackView
         width:parent.width
         currentIndex: tabBar.currentIndex
         ListSheet{
             id:listSheetView

         }
         ImageListView{
             id:imageListView
         }

     }


    RLSCurrentTime{
        id:rlsCurrentTime
        Layout.fillWidth: true

    }


   }//layout
}
