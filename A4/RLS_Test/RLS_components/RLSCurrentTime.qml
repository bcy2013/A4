import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"
Rectangle {
    id:root
    implicitWidth: 360
    implicitHeight: 32
   color:RLSTheme.backgroundColor.C1
    Label {
          id:textDateTime

          font.pixelSize: RLSTheme.fontSize.F4
          font.family:RLSTheme.fontFamily
          color:RLSTheme.textColor.C9
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.rightMargin: 15
      }
    Timer{
        id: timer
        triggeredOnStart : true
        interval: 1000 //间隔(单位毫秒):1000毫秒=1秒
        repeat: true //重复
        onTriggered:{
            textDateTime.text = currentDateTime();
        }
    }
    function currentDateTime(){
        return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss");
    }
    Component.onCompleted: {
        timer.start()
    }

}
