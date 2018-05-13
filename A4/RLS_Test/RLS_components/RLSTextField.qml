import QtQuick 2.7
import "../RLSTheme"
import QtQuick.Templates 2.0 as T
T.TextField {
    id: control
    property alias imageSource: img.source
    property bool isChoice: true
    signal popupOpen()
    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4
    rightPadding:padding + 4
    opacity: enabled ? 1 : 0.2
    color: "#353637"
    selectionColor: "#fddd5c"
    selectedTextColor: color
    verticalAlignment: TextInput.AlignVCenter

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color:RLSTheme.textColor.C8
        horizontalAlignment: control.horizontalAlignment
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
    }

    //! [background]
    background: Rectangle {
        id:root
        implicitWidth: 240
        implicitHeight: 40
        MouseArea{
            enabled: isChoice
            anchors.fill: parent
            onClicked: {
                control.forceActiveFocus();
                popupOpen();
            }

        }
        Image{
            id:img
            //source: "icons/basic.png"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                enabled: !isChoice
                anchors.fill: parent
                onClicked: popupOpen()
            }
        }
       // border.width: 1
        border.width: 1
        antialiasing : true
        radius: 5
        color: control.enabled ? "#ffffff" : "#353637"
        //border.color: !isChoice ? RLSTheme.textFieldBorder.isFocusActiveColor : (control.enabled ? RLSTheme.textFieldBorder.isBorderColor : "transparent")
        border.color: !isChoice?(control.activeFocus?RLSTheme.textFieldBorder.isFocusActiveColor :(control.enabled ? RLSTheme.textFieldBorder.isBorderColor : "transparent"))
                               :(control.activeFocus?"#4e4e4e":"#757676")
    }

    //! [background]
}
