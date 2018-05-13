import QtQuick 2.7
import QtQuick.Controls 2.0
Item {
   id:root
   implicitWidth: 60
   implicitHeight: 60
    property bool isVisible: false
    property int alarmLevel
    property int freeHardDisk
    Image{
        id:hardDiskImage
        width:60
        height:60
        source: "../icons/alarm_hard disk.png"
        visible:isVisible
    }
    Timer{
        id:timer
        //repeat: true
        interval:600
        running: isVisible&&alarmLevel
        onTriggered: {popup.open();getContentText();}
    }


    RLSPopup{
        id:popup
        x:300
        y:300
        dim:true
        transformOrigin: Item.TopLeft
        closePolicy: Popup.NoAutoClose
        RLSSystemPopup{
            id:hardDiskWaringPopup
            buttonText: qsTr("一键清理")


        }
    }
   function getContentText(){
        switch(alarmLevel)
        {
        case 1:hardDiskWaringPopup.contentText=qsTr("硬盘容量还剩余"+freeHardDisk+"G");
            break;
        case 2:hardDiskWaringPopup.contentText=qsTr("硬盘容量还剩余"+freeHardDisk+"G"+'\n'+'     '+"需立即清理!");
            break;
        }
    }

    function closePopup(){
        if(alarmLevel==1)
        {
        isVisible=false;
         popup.close();}
       if(alarmLevel==2){

       }
    }
    function handlePopup(){
        isVisible=false;
        stateinfo.clesrHardDisk();
         popup.close();
    }



    Component.onCompleted: {
               hardDiskWaringPopup.closePop.connect(closePopup)
               hardDiskWaringPopup.handlePop.connect(handlePopup)
           }
}
