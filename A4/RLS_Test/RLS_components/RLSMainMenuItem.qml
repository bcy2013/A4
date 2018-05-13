import QtQuick 2.7
import "../RLSTheme"
import QtQuick.Templates 2.0 as T

T.MenuItem {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             Math.max(contentItem.implicitHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset
    spacing:10
    padding:6
    property var icon:"basic"

//! [contentItem]
    contentItem: Text {
        leftPadding:  control.indicator.width + control.spacing+10
        text: control.text
        font.pixelSize: RLSTheme.fontSize.F3
        font.family: RLSTheme.fontFamily
        color: RLSTheme.textColor.C9
        elide: Text.ElideRight
        visible: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    //! [contentItem]

    //! [indicator]
    indicator: Image {
        x: 18
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.checkable?control.checked:true
        source: control.checkable ? "../icons/choice.png" : "../icons/"+control.icon+".png"
    }
    //! [indicator]

    //! [background]
    background: Item {
        implicitWidth: 140
        implicitHeight: 54

        Rectangle {
            id:rect
            width: parent.width
            height: parent.height
            color: control.checked || control.down ? RLSTheme.buttonStateColor.buttonPressColor :RLSTheme.buttonStateColor.buttonColor

        }
    }
    //! [background]
}
