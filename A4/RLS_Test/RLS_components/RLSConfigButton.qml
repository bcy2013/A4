import QtQuick 2.7
import "../RLSTheme"
import QtQuick.Controls 2.0
import QtQuick.Templates 2.0 as T

T.Button {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 6
    leftPadding: padding + 2
    rightPadding: padding + 2

    //! [contentItem]
    contentItem: RLSConfigLabel {
        anchors.left: backGround.left
        anchors.leftMargin: 20
        text: control.text
        font.letterSpacing: 1
        opacity: enabled || control.highlighted || control.checked ? 1 : 0.3
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        id:backGround
        implicitWidth: 600
        implicitHeight: 88
        visible: !control.flat || control.down || control.checked || control.highlighted
        color:!control.enabled?RLSTheme.buttonStateColor.buttonDisabledColor:
            control.checked || control.highlighted ?RLSTheme.backgroundColor.C5:RLSTheme.backgroundColor.C6
           // (control.visualFocus ? (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor) : (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor)) :
           // (control.visualFocus ? (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor) : (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor))
        border.color: "#0066ff"
        border.width: control.visualFocus ? 2 : 0
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source:!control.checked? "../icons/secMenu.png":""
        }
    }
    //! [background]
}
