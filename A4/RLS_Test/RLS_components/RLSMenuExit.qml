import QtQuick 2.0
import "../RLSTheme"
import QtQuick.Controls 2.0
Item{
    id:root
    implicitWidth: 70
    implicitHeight: 66
    signal quitQuest();
Button{
    id:control
    checkable: true
    highlighted:control.activeFocus
    background: Rectangle{
        implicitWidth: 70
        implicitHeight: 66
        Image{
            source: "../icons/exit_white.png"
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
    onClicked: pop.open()
  }
RLSPopup{
    id:pop
    x:-600-popupWidget.width/2-370
    y:400
    transformOrigin: Item.TopRight
    closePolicy: Popup.NoAutoClose
    RLSSystemPopup{
        id:popupWidget
        contentText: qsTr("是否退出程序?")
        buttonText: qsTr("确定")
        onHandlePop: root.quitQuest()
     }
}


Component.onCompleted: {
           popupWidget.closePop.connect(pop.close)

       }

}
