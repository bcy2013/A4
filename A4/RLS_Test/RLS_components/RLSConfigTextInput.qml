import QtQuick 2.7
import "../RLSTheme"
import QtQuick.Templates 2.0 as T
T.TextField {
    id: control
    signal enterKeyClicked
    Keys.onReleased: {
        if (event.key === Qt.Key_Return)
            enterKeyClicked()
    }
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
        color: RLSTheme.textColor.C10
        horizontalAlignment: control.horizontalAlignment
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
    }

    //! [background]
    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 44
        //border.width: 1
        border.width: control.activeFocus ? 1 : 0
        antialiasing : true
        radius: 5
        color: control.enabled ? "#ffffff" : "#353637"
        border.color: control.activeFocus ? RLSTheme.textFieldBorder.isFocusActiveColor : (control.enabled ? RLSTheme.textFieldBorder.isBorderColor : "transparent")
    }
    //! [background]
}
