import QtQuick 2.7
import QtQuick.Templates 2.0 as T
import "../RLSTheme"
T.MenuItem {
    id: control
    property bool isColorSelect: false
    property color textColor: "#68b5ae"

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             Math.max(contentItem.implicitHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 6

    //! [contentItem]
    contentItem: Text {
        id:text
        leftPadding: control.checkable && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.checkable && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        //font: control.font
        font.family: RLSTheme.fontFamily
        font.pixelSize: RLSTheme.fontSize.F3
        color: control.enabled ?(isColorSelect?textColor:RLSTheme.textColor.C8 ): "#bdbebf"
        elide: Text.ElideRight
        visible: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    //! [contentItem]

    //! [indicator]
    indicator: Image {
        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.checked
        source: control.checkable ? "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png" : ""
    }
    //! [indicator]

    //! [background]
    background: Item {
        implicitWidth: 578
        implicitHeight: 88

        Rectangle {
            x: 1
            y: 1
            width: parent.width - 2
            height: parent.height - 2
            color: control.visualFocus || control.down ? "#eeeeee" : "#ffffff"
        }
    }
    //! [background]
}
