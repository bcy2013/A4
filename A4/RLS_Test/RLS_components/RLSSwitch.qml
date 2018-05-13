import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"
  Switch {
      id: control
      indicator: Rectangle {
          implicitWidth: 100
          implicitHeight: 40
          radius: 20
          color: control.checked ? RLSTheme.backgroundColor.C2 :RLSTheme.textColor.C12
          border.color: control.checked ? RLSTheme.backgroundColor.C2 : RLSTheme.textColor.C12
          Rectangle {
              x: control.checked ? parent.width - width-2 : 2
              y: 2
              width: 36
              height: 36
              radius: 18
              color: "#ffffff"
              border.color: RLSTheme.textColor.C12//control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
          }
      }
  }

