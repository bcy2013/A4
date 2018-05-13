import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"
Rectangle{
     id:mainWindow

     color:"transparent"
     signal popupClose()
     Rectangle{
         id:root
          anchors.fill: parent
          color:RLSTheme.backgroundColor.C1
          radius: RLSTheme.buttonRadius
          anchors.rightMargin: 0
          anchors.bottomMargin: 0
          anchors.leftMargin: 0
          anchors.topMargin: 0
          Image{
              id:exit
              source:"../icons/close.png"
              anchors.top: parent.top
              anchors.right: parent.right
              anchors.topMargin: 15
              anchors.rightMargin: 15
              MouseArea{
                  anchors.fill: parent
                  onClicked: mainWindow.popupClose()
              }
          }
          Image{
              source:"../icons/RLSabout.png"
              anchors.left: parent.left
              anchors.leftMargin: 63
              anchors.bottom:content.top
              anchors.bottomMargin: 22
          }

         Rectangle{
             id:content
             height:250
              focus: true
             width:parent.width
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 20
             color:RLSTheme.backgroundColor.C6
         Label{
             id:label
             anchors.fill: parent
             anchors.margins: 20
             wrapMode: Text.WordWrap
             font.family: RLSTheme.fontFamily
             font.pixelSize: RLSTheme.fontSize.F4
             textFormat: Text.StyledText
             horizontalAlignment: Text.AlignJustify
             text: "<b>系统版本:</b>V 1.0"
                   +"<p><b>发布日期:</b>2016/12/30"
                   +"<p><b>操作系统:</b>支持Window7系统及以上"
                   +"<p><b>系统制造商:北京永新医疗设备有限公司</b>"
                   +"<p><b>系统介绍:</b>本产品\"RLS-1000A放射性物质定位系统\"具有辐射源定位和对实时运动物体的追踪定位能力，能够快速、准确找出携带放射性物质的人或物，实现了大面积监管，同时也提高了监控效率。"

             //

         }


         }
     }

     RLSTabButton {
         x: -35
         y: 27
     }

     RLSTextField {
         x: -17
         y: -13
     }
}
