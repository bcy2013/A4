import QtQuick 2.7
import QtQuick.Controls 2.0
import QtMultimedia 5.6
import "../RLSTheme"

Item {
    id:root
    implicitWidth:radiationFound.width+peopleFound.width+soundLoud.width+3*rowSpacing+rectangle.width
    implicitHeight: 60
    property bool isRadiationFoundSplash: false
    property bool isPeopleFoundSplash: false

    property string radiationName

    property bool isSoundLoudVisiable: true
    property bool isPeopleFoundVisiable: false
    property bool isRadiationFoundLevelVisiable: false

    property int radiationAlarmLevel: 4
    property real rowSpacing: 15
    property alias soundType:alarmAudio.source
    Row{
        spacing: rowSpacing

        Rectangle{
            color:"transparent"
            width:60
            height:60
        Image{
            id:radiationFound
            anchors.centerIn: parent
            visible: isRadiationFoundSplash
            source: "../icons/radioTreatment.png"
            opacity:1.0
            SequentialAnimation {
                     id:animationRadiationFound
                     PropertyAnimation {target: radiationFound; property: "opacity"; to: 0.0; duration: 100 }
                     PropertyAnimation {target: radiationFound; property: "opacity"; to: 1.0; duration: 100 }
                 }


        }
         Image{
             id:alarmLevel
             anchors.centerIn: parent
             visible:!isRadiationFoundSplash&&isRadiationFoundLevelVisiable
             source:"../icons/"+radiationAlarmLevel+".png"
               onVisibleChanged: alarmLevel.visible?timer.start():timer.stop()
         }

       }
        Image{
            id:peopleFound
            width:60
            height:60
            source: "../icons/radioLocation.png"
            visible: isPeopleFoundVisiable
            opacity: 1.0

            SequentialAnimation {
                     id:animationPeopleFound
                     PropertyAnimation {target: peopleFound; property: "opacity"; to: 0.0; duration: 100 }
                     PropertyAnimation {target: peopleFound; property: "opacity"; to: 1.0; duration: 100 }
                 }
        }

          Rectangle{
             id:soundLoud
              visible: isSoundLoudVisiable
              color:"transparent"
              anchors.verticalCenter: parent.verticalCenter
              width:60
              height:60
              onVisibleChanged: {
                  if(!soundLoud.visible)
                  alarmAudio.stop();
              }
          AnimatedImage {
              id: animation
              playing:isSoundLoudVisiable
              anchors.fill: parent
              source: "../icons/sound.gif"
          }
          Audio{
              id:alarmAudio
             autoLoad : true
             autoPlay : true
              loops: 20
              //onPlaying: soundLoud.visible==true
              onStopped: soundLoud.visible==false
              onSourceChanged: {
                  alarmAudio.stop();
                  alarmAudio.play();
              }
             // loops:advanceConfig.autoStopWarning&& !soundLoud.visible?advanceConfig.warningKeepTime:Audio.Infinite
          }
          MouseArea{
              anchors.fill: parent
              onPressed:{
                  isSoundLoudVisiable=false;
                  alarmAudio.stop();
              }
          }
          }
          Rectangle{
              id:rectangle
              width:60
              height:60
              radius: 30
              visible: stateinfo.warming&&(radiationName==""?false:true)
              color:RLSTheme.backgroundColor.C1
              Label{
                  text:radiationName
                  color:RLSTheme.backgroundColor.C2
                  anchors.centerIn: parent
                  font.family: RLSTheme.fontFamily
                  font.pixelSize: 22
                  font.bold: true
              }
              SequentialAnimation {
                       id:animationRadiationStype
                       running:rectangle.visible
                       loops: Animation.Infinite
                       PropertyAnimation {target: rectangle; property: "opacity"; to: 0.0; duration: 200 }
                       PropertyAnimation {target: rectangle; property: "opacity"; to: 1.0; duration: 200 }
                   }
          }

    }
    Timer{
        id:timer
        repeat: true
        interval: 250
        running: isPeopleFoundSplash||isRadiationFoundSplash
        onTriggered: {
            sound();

            if(isRadiationFoundSplash)
                animationRadiationFound.running=true
            if(isPeopleFoundSplash)
                animationPeopleFound.running=true
        }


    }


    function sound(){
        switch(radiationAlarmLevel){
        case 1:
        case 2:soundType="../RLSSonic/spect_warning_low.wav";break;
        case 3:
        case 4:soundType="../RLSSonic/spect_warning_mid.wav";break;
        case 5:soundType="../RLSSonic/spect_warning_hig.wav";break;
        }
    }
}
