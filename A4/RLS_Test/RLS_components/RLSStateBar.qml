import QtQuick 2.7
import StateInfo 1.0
import AdvanceConfig 1.0
Item {

    StateInfo{
        id:stateinfo
    }
    AdvanceConfig{
        id:advanceConfig
    }

    Row{

   RLSStateBarIsAlarming{
            id:isAlarming
            //visible: true
            visible: stateinfo.warming||stateinfo.found||stateinfo.warmingLevel&&stateinfo.warming
            isRadiationFoundLevelVisiable:stateinfo.warmingLevel&&stateinfo.warming?true:false
            isRadiationFoundSplash:stateinfo.warming&&!stateinfo.warmingLevel
            isSoundLoudVisiable:stateinfo.warming
            isPeopleFoundVisiable:stateinfo.found
            isPeopleFoundSplash:stateinfo.found
            radiationAlarmLevel:stateinfo.warmingLevel
            radiationName: stateinfo.radiationName
        }
    RLSStateBarSelfCheck{
        id:selfCheck
        visible:stateinfo.tempWarming||!stateinfo.isCameraConnect||!stateinfo.isSpectConnect
        isTemperatureVisiable:stateinfo.tempWarming
        isCameraVisiable:!stateinfo.isCameraConnect
        isDetectorVisiable:!stateinfo.isSpectConnect
    }
   RLSStateBarHardDisk{
         id:hardDish
         visible: true
         isVisible: stateinfo.hardWarming&&!stateinfo.autoClearDisk
         alarmLevel:stateinfo.hardWarmingLevel
         freeHardDisk:stateinfo.freeHardDisk

        }
    }
    Timer{
        id:timer
        interval: 300
        running: stateinfo.autoClearDisk&&stateinfo.hardWarming
        repeat: false
        onTriggered: stateinfo.clesrHardDisk()
    }
//    Component.onCompleted: timer.running=true
}
