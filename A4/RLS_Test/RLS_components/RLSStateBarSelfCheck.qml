import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id:root
    implicitWidth:cameraCheck.width+detectorCheck.width+temperatureCheck.width+2*15
    implicitHeight: 60


     visible: false
     property bool isCameraVisiable:false
     property bool isDetectorVisiable:false
     property bool isTemperatureVisiable:false

    Row{
        spacing: 15
        Image{

            width:60
            height:60
            id:cameraCheck
            source: "../icons/alarm_camera.png"
            visible: isCameraVisiable
        }
        Image{

            width:60
            height:60
            id:detectorCheck
            source: "../icons/alarm_detector.png"
            visible: isDetectorVisiable
        }
        Image{

            width:60
            height:60
            id:temperatureCheck
            source: "../icons/alarm_temperature.png"
            visible: isTemperatureVisiable
        }

    }

    Timer{
        id:timer
        //repeat: true
        interval:600
        running: (isCameraVisiable||isDetectorVisiable)&&root.visible
        onTriggered:
           {getContentText(); popup.open();}
    }

    RLSPopup{
        id:popup
        x:450
        y:400
        z:20
        transformOrigin: Item.TopLeft
        closePolicy: Popup.NoAutoClose
        RLSSystemPopup{
            id:selfCheckPopup
            //contentText:getContentText()
            buttonText: qsTr("重新连接")
        }
    }
    function getContentText(){
        if(isCameraVisiable&&isDetectorVisiable)
            selfCheckPopup.contentText=qsTr("摄像头100未连接!"+'\n'+"探测器100未连接!");
        else{
            if(isCameraVisiable)
                selfCheckPopup.contentText=qsTr("摄像头100未连接!");
            else
                selfCheckPopup.contentText=qsTr("探测器100未连接!");
        }
    }

    function closePopup(){
         popup.close();
    }
    function handlePopup(){
        if(isCameraVisiable)
            stateinfo.cameraConnect();
        if(isDetectorVisiable)
            stateinfo.spectConnect();
        //isCameraVisiable=false;
        //isDetectorVisiable=false;
        //isTemperatureVisiable=false;
        popup.close();
    }



    Component.onCompleted: {
               selfCheckPopup.closePop.connect(closePopup)
               selfCheckPopup.handlePop.connect(handlePopup)
           }


}
