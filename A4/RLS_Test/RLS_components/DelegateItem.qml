import QtQuick 2.7
import QtQuick.Controls 2.0
import"../RLSTheme"
Rectangle {
    id:root
    color:RLSTheme.backgroundColor.C1
    implicitWidth: 360
    implicitHeight: rootPadding*2+label.height+rootSpacing+image.height
    property string name
    property bool isSelected: mainViewArea.currentIndex===index
    property real rootSpacing: 10
    property real rootPadding: 15
    property bool active:false
   // width:parent?parent.width:imageItem.width
   // height:imageItem.height
    z:isSelected?1000:-index
   // rotation: isSelected?0:-15
   // scale:isSelected?1.5:0.8
   // Behavior on rotation {
    //    NumberAnimation { duration: 500; easing.type: Easing.OutBack }
    //}
   //Behavior on scale {
   //     NumberAnimation { duration: 1000; easing.type: Easing.OutElastic }
    //}



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
       anchors.rightMargin: 15
   }
   Rectangle{
       id:image
       width:330
       height:370
       color:RLSTheme.backgroundColor.C3
       border.width:2
       border.color: active?RLSTheme.backgroundColor.C2:RLSTheme.backgroundColor.C3
       Image{
           visible: true
           //width: parent.width
           height:parent.height
           source:sensitiveImageData.source+"/images/"+model.image
           anchors.horizontalCenter: parent.horizontalCenter
           //anchors.verticalCenter: parent.verticalCenter
          //fillMode: Image.PreserveAspectFit
       }

   }

//    Image{
//        id:imageItem
//        Layout.alignment: Qt.AlignHCenter
//        width:330
//        height:370
//        anchors.bottom: parent.bottom
//        fillMode: Image.PreserveAspectFit
//        anchors.horizontalCenter: parent.horizontalCenter
//        source:"images/"+model.image
//        visible: true
//    }
   }
}
