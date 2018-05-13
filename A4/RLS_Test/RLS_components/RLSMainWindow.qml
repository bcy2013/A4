import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.VirtualKeyboard 2.1
import "../RLS_components"
import Charts 1.1
//import Units 0.3
Window {
    id:rootWindow
    width:1920
    height:1080
    flags:Qt.Window
          //|Qt.FramelessWindowHint|Qt.WindowSystemMenuHint
    color: "black"
    //visible:true
    modality: Qt.NonModal


    InputPanel {
        id: inputPanelDiskSetting
        z: 99
        y: rootWindow.height
        width:720
        anchors.left: parent.left
        anchors.leftMargin:(parent.width-inputPanelDiskSetting.width)*0.5
        //anchors.right: parent.right
        states: State {
            name: "visible"
            /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                but then the handwriting input panel and the keyboard input panel can be visible
                at the same time. Here the visibility is bound to InputPanel.active property instead,
                which allows the handwriting panel to control the visibility when necessary.
            */
            when: inputPanelDiskSetting.active
            PropertyChanges {
                target: inputPanelDiskSetting
                y: rootWindow.height - inputPanelDiskSetting.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
//    Button{
//        text:"缩放测试"
//        z:9
//        y:500
//        onClicked:contents.state="MINSCREEN"
//        onPressAndHold: contents.state="FULLSCREEN"
//        //onReleased: contents.state="FULLSCREEN"
//    }
      Timer{
          id:timer
          interval: 1000/60
          repeat: true
          onTriggered:imageShow.clearChart()
      }

     Frame{
         id:contents
        // anchors.fill:parent
         padding: 0


         PieChart{
               id:imageShow
               anchors.fill: parent
               imageWidth: parent.width
               imageHeight: parent.height
               color: "red"
               source:imagesPath
               Component.onCompleted: {timer.running=true;}

         }

         state:"FULLSCREEN"
         states: [
             State{
                 name:"FULLSCREEN"
                 PropertyChanges {
                     target: contents
                     width:1920
                     height:1080
                     y:0

                 }
             },
             State {
                 name: "MINSCREEN"
                 PropertyChanges {
                     target: contents
                     width:1560
                     height:878
                     y:101
                 }
             }
         ]
         transitions:[
             Transition {
             from: "FULLSCREEN"
             to: "MINSCREEN"
             ParallelAnimation {
             NumberAnimation { duration: 300; properties: "height,width,y" }
             }
         },
             Transition {
             from: "MINSCREEN"
             to: "FULLSCREEN"
             ParallelAnimation {
             NumberAnimation { duration: 300; properties: "height,width,y" }
             }
         }

         ]

}


   RLSMenuSetting{
                  id:mainMenuSetting
                  width:360
                  height:66
                  anchors.top: parent.top
                  anchors.right: parent.right
                  onQuitWindow: {
                      imageShow.setCmdInfo_EXIT();
                      rootWindow.close();
                      Qt.quit();
                  }
                  onFullScreen: contents.state="FULLSCREEN"
                  onMinScreen: contents.state="MINSCREEN"

                }


   RLSCountingRate{
       id:dateInfo
       height:40
       anchors.right:mainMenuSetting.left
       anchors.top: parent.top
       anchors.topMargin: 12
       anchors.rightMargin: 30


   }
   RLSStateBar{
       id:stateBar
       anchors.left: parent.left
       anchors.leftMargin:20
       anchors.top: parent.top
       anchors.topMargin: 20
   }




     Component.onCompleted:{

         rootWindow.visible=true;
         showFullScreen();
     }
}

