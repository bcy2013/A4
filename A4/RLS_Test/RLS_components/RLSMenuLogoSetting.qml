import QtQuick 2.0
import "../RLSTheme"
import QtQuick.Controls 2.0
import "componentCreation.js" as CreateConfig
Item{
    id:root
    implicitWidth: 144
    implicitHeight: 66


    signal input()

    Loader{
        id:loader
    }
Button{
    id:control
    checkable: true
    highlighted:menu.activeFocus
    background: Rectangle{
        implicitWidth: 144
        implicitHeight: 66
       RLSLogo{
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
    onClicked:{

        menu.open();

    }
  }



  Menu{
      id:menu
      x:control.width/2-20
      y:control.height
      focus:true
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
         icon:"replay"
         text:qsTr("数据回放")
          onTriggered:CreateConfig.createSpriteObjects("RLSReplayManager.qml")



      }
      RLSMainMenuItem{
         icon:"alarm"
         text:qsTr("报警处理")
          onTriggered:CreateConfig.createSpriteObjects("RLSWarmingManager.qml")

      }
      RLSMainMenuItem{
         icon:"basic"
         text:qsTr("基本设置")
         onTriggered:CreateConfig.createSpriteObjects("RLSBasicConfig.qml")



      }
      RLSMainMenuItem{
         icon:"advanced"
         text:qsTr("高级设置")
         //onTriggered:CreateConfig.createSpriteObjects("RLSAdvanceConfig.qml")
         onTriggered:{login.open();root.input();}


      }
      RLSMainMenuItem{
         icon:"help"
         text:"帮助"
         onTriggered:CreateConfig.createSpriteObjects("RLSHelp.qml")



      }
      RLSMainMenuItem{

        icon:"about"
         text:"关于"
         onTriggered:about.open()

      }

  }
  RLSPopup{
      id:login
      x:-600-advanceConfigLoginIn.width/2
      y:400
      closePolicy:Popup.NoAutoClose
      transformOrigin : Popup.TopRight
      RLSAdvanceConfigLoginIn{
          id:advanceConfigLoginIn
          anchors.fill: parent
          buttonEnable: false
          buttonText: "确认"
          onClosePop:login.close()
          onTextChanged: function isOk(){
              var password=advanceConfigLoginIn.textFieldText;
              if(password=="1234qwer")
              {
                  advanceConfigLoginIn.buttonEnable=true
              }
          }
          onHandlePop: {
              CreateConfig.createSpriteObjects("RLSAdvanceConfig.qml")
              advanceConfigLoginIn.buttonEnable=false
              login.close()
          }
      }
  }
  RLSPopup{
      id:about
      x:-600-aboutPopup.width/2
      y:400
      width:320
      height:420
      closePolicy:Popup.NoAutoClose
      transformOrigin : Popup.TopRight
      RLSAbout{
          id:aboutPopup
          anchors.fill: parent
          onPopupClose:about.close()
      }
  }
}
