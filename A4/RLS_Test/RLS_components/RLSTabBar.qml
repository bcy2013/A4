import QtQuick 2.7
import QtQuick.Templates 2.0 as T
import "../RLSTheme"

T.TabBar {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    spacing: 2
    padding:2
    //! [contentItem]
    contentItem: ListView {
        implicitWidth: contentWidth
        implicitHeight: 40

        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        implicitHeight:44
        radius: 22
        color:RLSTheme.backgroundColor.C3
    }
    //! [background]
}
