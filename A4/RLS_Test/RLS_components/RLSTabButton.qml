import QtQuick 2.6
import QtQuick.Templates 2.0 as T
import "../RLSTheme"
T.TabButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.contentHeight + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 6

    //! [contentItem]
    contentItem: Text {
        text: control.text
        font.family: "微软雅黑"
        font.pixelSize: RLSTheme.fontSize.F3
        elide: Text.ElideRight
        opacity: enabled ? 1 : 0.3
        color: control.checked ? RLSTheme.backgroundColor.C2:RLSTheme.textColor.C10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {

        implicitHeight: 40
        color:control.checked ? RLSTheme.backgroundColor.C1 : "transparent"

    }
    //! [background]
}
