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
    contentItem: Text {
        text: control.text
        font.letterSpacing: 1
        font.family: RLSTheme.fontFamily
        font.pixelSize: RLSTheme.fontSize.F3
        opacity: enabled || control.highlighted || control.checked ? 1 : 0.3
        color: control.checked || control.highlighted ? "#ffffff" :
                                                        (control.visualFocus ? "#0066ff" :
                                                                               (control.down ? "#ffffff" : "#ffffff"))

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        implicitWidth: 160
        implicitHeight: 54
        radius: RLSTheme.buttonRadius
        visible: !control.flat || control.down || control.checked || control.highlighted
        color:!control.enabled?RLSTheme.buttonStateColor.buttonDisabledColor:
            control.checked || control.highlighted ?
            (control.visualFocus ? (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor) : (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor)) :
            (control.visualFocus ? (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor) : (control.down ? RLSTheme.buttonStateColor.buttonPressColor : RLSTheme.buttonStateColor.buttonColor))
        border.color: "#0066ff"
        border.width: control.visualFocus ? 2 : 0
    }
    //! [background]
}
