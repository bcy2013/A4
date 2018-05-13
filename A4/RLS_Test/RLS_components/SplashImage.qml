import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import StartInit 1.0
import"../RLSTheme"
Window {
    id:root
    color: "transparent"
    width: 558
    height: 308
   StartInit{
       id:start 
   }


    Loader{
        id:loader
    }
    signal timeout()

    onTimeout: {

        loader.sourceComponent= Qt.createComponent("RLSMainWindow.qml");
    }

    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 400
    property alias text: label.text
    Image {
        id: splash
        anchors.fill: parent
        source:"../icons/welcom.png"
        fillMode: Image.PreserveAspectFit
        //clip: true      // only makes a difference if mode is PreserveAspectCrop
        smooth: true
        opacity: 0.2
        //running默认是false；这里PropertyAnimation显示过程中并不会阻塞parent组件中代码的执行
        PropertyAnimation {id: splashAnimation; running: true; target: splash; property: "opacity"; to: 1.0; duration: 1000*1.5 }
        PropertyAnimation {id: splashAnimationComplete; running: false; target: splash; property: "opacity"; to: 0.0; duration: 1500;
            onStopped:{
                root.visible = false;
                root.timeout();
            }
        }
        MaterialProgressBar{
            id:materialProgressBar
            anchors.bottom: label.top
            anchors.bottomMargin: 40-13-label.contentHeight
        }
        Label{
                 id:label
                 text:qsTr("欢迎进入主系统界面. . . . .")
                 font.family: RLSTheme.fontFamily
                 font.pixelSize: RLSTheme.fontSize.F4
                 color:RLSTheme.textColor.C9
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: 13
                 anchors.left: parent.left
                 anchors.leftMargin: 20
         }
        FontLoader { id: webFont; source: "lan.TTF" }
         Label{
             id:labelLogoTexte
             text:qsTr("放射性位置定位系统")
             font.family:webFont.name
             font.pixelSize: 16
             color:RLSTheme.textColor.C8
             anchors.left: parent.left
             anchors.leftMargin: 30
             anchors.top: parent.top
             anchors.topMargin: 71
         }

    }

     Timer{
            id:timer
            running: true
            repeat:true
            interval: timeoutInterval
            onTriggered: {
                materialProgressBar.bufferedValue+=9;
                if(materialProgressBar.bufferedValue%27==0)
                {
                     materialProgressBar.value+=25;
                    if(materialProgressBar.value==25)
                        if(start.isCameraConnect)
                        text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   摄像头已连接");
                        else
                            text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   摄像头未连接");

                    if(materialProgressBar.value==50)
                        if(start.isSpectConnect)
                     text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   探测器已连接");
                        else
                         text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   探测器未连接");
                    if(materialProgressBar.value==75)
                        if(start.isDASWorking)
                     text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   后台已启动");
                        else text=qsTr("Loading:")+ materialProgressBar.value+'%'+qsTr("   后台未启动");
                    if(materialProgressBar.value==100)
                    {
                        text="程序初始化完成!";
                        timer.stop();
                        splashAnimationComplete.running=true;
                    }
                }
            }
        }


    Component.onCompleted: {

        visible = true;

    }

}
