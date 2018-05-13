import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../RLSTheme"
Item{
    id:root
    signal quitWindow()
    signal fullScreen()
    signal minScreen()

Rectangle{
    id:rlsMenuSetting
    color:RLSTheme.backgroundColor.C3
    width:360
    height:66

    RowLayout{
        id:mainLayout
        anchors.fill: parent
        spacing: 2
        RLSMenuLogoSetting{
            id:logoSetting
            width:144
            height:66
        }
       RLSMenuModelChanged{
            id:modelChanged
            width:70
            height:66
        }
        MaxAndMin{
            id:maxAndMin
            width:70
            height:66
            onMinMenu:root.minScreen()
            onMaxMenu: root.fullScreen()

        }
        RLSMenuExit{
            id:menuExit
            width:70
            height:66
             onQuitQuest: root.quitWindow()
        }
    }//rowlayout
 }

 Rectangle{
    height:2
    width:parent.width
    color:RLSTheme.backgroundColor.C3
    anchors.top: rlsMenuSetting.bottom
    anchors.bottom: slidingMenuPopup.top

 }

  RLSPopup{
      id:slidingMenuPopup
      width: 360
      height:1012
      transformOrigin: Item.TopRight
      closePolicy: Popup.NoAutoClose

      y:parent.height+2
      RLSSlidingMenu{
          id:rlsSlidingMenu
          anchors.fill: parent
      }
     // onOpened: root.minScreen()
      //onClosed: root.fullScreen()

  }
  Component.onCompleted: {
              maxAndMin.maxMenu.connect(slidingMenuPopup.close);
              maxAndMin.minMenu.connect(slidingMenuPopup.open);

         }
}
