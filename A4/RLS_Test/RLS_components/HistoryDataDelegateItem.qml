import QtQuick 2.7
import QtQuick.Controls 2.0
import"../RLSTheme"
Rectangle {
    id:root
    color:RLSTheme.backgroundColor.C3
    implicitWidth: 360
    implicitHeight: rootPadding*2+label.height+rootSpacing+imageItem.height
    property string name
    property bool isSelected: mainViewArea.currentIndex===index
    property real rootSpacing: 10
    property real rootPadding: 20
    //width:parent?parent.width:imageItem.width
    //height:imageItem.height
    z:isSelected?1000:-index
    //rotation: isSelected?0:-15
   // scale:isSelected?1:0.8
//    Behavior on rotation {
//        NumberAnimation { duration: 500; easing.type: Easing.OutBack }
//    }
  // Behavior on scale {
  //      NumberAnimation { duration: 1000; easing.type: Easing.OutElastic }
   // }
   Column{
   anchors.fill: parent
   spacing: rootSpacing
   padding:rootPadding
   Label{
       id:label
       text:model.name
       font.family: RLSTheme.fontFamily
       font.pixelSize: RLSTheme.fontSize.F4
       color:RLSTheme.textColor.C11
       anchors.right: parent.right
       anchors.rightMargin: 20

   }
   Rectangle{
       id:imageItem
       width:320
       height:200
       color:RLSTheme.backgroundColor.C4
       border.width:2
       border.color: isSelected?RLSTheme.backgroundColor.C2:RLSTheme.backgroundColor.C3
       Image{
           visible: true
           anchors.top:imageItem.top
           anchors.topMargin: 2
           anchors.left:imageItem.left
           anchors.leftMargin: 2
           height:parent.height-4
           width:parent.width-4
           source:"file:///"+historyReplay.getWorkDir()+"100//History//"+model.name+"//history.jpg"
           anchors.horizontalCenter: parent.horizontalCenter
       }
       MouseArea{
           anchors.fill:imageItem
           onClicked:
          {
               //if(isSelected)
                   historyReplay.historyReplayEnd()

               //}
               //else{
                   mainViewArea.currentIndex=index
                   historyReplay.replayFile=label.text
                  //historyReplay.initHistoryReplay()
                  historyReplay.historyReplay()
               //}
           }
       }

   }
   }
}
