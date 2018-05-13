import QtQuick 2.7
import"../RLSTheme"
import QtQuick.Controls 2.0
Button{
     id:control
    property bool activeState: false
    signal maxMenu()
    signal minMenu()
    background: Rectangle{
        implicitWidth: 70
        implicitHeight: 66
        Image{
            id:min
            visible:activeState
            source: "../icons/max.png"
            anchors.centerIn: parent
        }
        Image{
            id:max
            visible:!activeState
            source: "../icons/min.png"
            anchors.centerIn: parent
        }
     color:{
         control.down?RLSTheme.buttonStateColor.buttonPressColor:RLSTheme.buttonStateColor.buttonColor
     }
     Behavior on color {
         ColorAnimation {
             duration: 200
         }
     }
  }

  onClicked: {
      if(activeState)
      {
          control.maxMenu();
      }else{
          control.minMenu();
      }
      activeState=!activeState;
       }
}
