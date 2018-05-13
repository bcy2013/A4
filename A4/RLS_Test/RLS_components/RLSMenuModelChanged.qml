import QtQuick 2.0
import "../RLSTheme"
import QtQuick.Controls 2.0
import RapidChanged 1.0
Item{
    id:root
    implicitWidth: 70
    implicitHeight: 66

   RapidChanged{
       id:rapidChanged
       onModelChanged:rapidChanged.setCmdInfo()
   }



Button{
    id:control
    checkable: true
    highlighted:menu.activeFocus
    background: Rectangle{
        implicitWidth: 70
        implicitHeight: 66
        Image{
            source: "../icons/rapidChanged.png"
            anchors.centerIn: parent
        }
     color:{
         control.highlighted?RLSTheme.buttonStateColor.buttonPressColor:RLSTheme.buttonStateColor.buttonColor
     }
     Behavior on color {
         ColorAnimation {
             duration: 200
         }
     }
    }
    onClicked: menu.open()
  }



  Menu{
      id:menu
      y:control.height
      x:control.width/2-20
      topPadding:13
      leftPadding:5
      rightPadding:5
      bottomPadding:5
      contentItem: ListView {
          implicitHeight: contentHeight
          model: menu.contentModel
          interactive: false
          clip: true
          keyNavigationWraps: false
          currentIndex: -1
          spacing:2
          ScrollIndicator.vertical: ScrollIndicator {}
      }

      background:




          BorderImage{
              height:352
              width:150
              verticalTileMode: BorderImage.Stretch
              source: "../icons/Pull-down Menu.png"

          }




      RLSMainMenuItem{
         id:model0
         text:qsTr("核爆模式")
         autoExclusive : true
         checkable:true
         onTriggered:{rapidChanged.setTrackModel(4);
                      rapidChanged.setCmdInfo();
         }
      }
      RLSMainMenuItem{
          id:model1
          text:qsTr("旅检模式")
          autoExclusive : true
          checkable:true
          onTriggered:{rapidChanged.setTrackModel(1);rapidChanged.setCmdInfo();}
      }
      RLSMainMenuItem{
         id:model2
         text:qsTr("演示模式")
         autoExclusive : true
         checkable:true
         onTriggered:{rapidChanged.setTrackModel(5);rapidChanged.setCmdInfo();}
      }
      RLSMainMenuItem{
          id:model3
         text:qsTr("核电模式")
         autoExclusive : true
         checkable:true
         onTriggered:{rapidChanged.setTrackModel(3);rapidChanged.setCmdInfo();}
      }
      RLSMainMenuItem{
          id:model4
         text:qsTr("货检模式")
         autoExclusive : true
         checkable:true
         onTriggered:{rapidChanged.setTrackModel(2);rapidChanged.setCmdInfo();}
      }
      RLSMainMenuItem{
         id:model5
         text:qsTr("自定模式")
         autoExclusive : true
         checkable:true
         onTriggered:{rapidChanged.setTrackModel(0);rapidChanged.setCmdInfo();}
      }
  }
  function init(){
      switch(rapidChanged.model){
        case 0:
            model5.checked=true;
            break;
        case 1:
            model1.checked=true;
            break;
        case 2:
            model4.checked=true;
            break;
       case 3:
             model3.checked=true;
             break;
       case 4:
             model0.checked=true;
             break;
       case 5:
            model2.checked=true;
            break;
      }
  }
  Component.onCompleted: init()
}
