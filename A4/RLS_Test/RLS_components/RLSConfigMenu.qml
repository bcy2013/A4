import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Templates 2.0 as T

T.Menu {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem ? contentItem.implicitWidth + leftPadding + rightPadding : 0)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem ? contentItem.implicitHeight : 0) + topPadding + bottomPadding

    margins: 2
    enter: Transition {
        // grow_fade_in
        NumberAnimation { property: "scale"; from: 0.3; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        // shrink_fade_out
        NumberAnimation { property: "scale"; from: 1.0; to: 0.3; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 100 }
    }

    //! [contentItem]
    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        // TODO: improve this?
        interactive: ApplicationWindow.window ? contentHeight > ApplicationWindow.window.height : false
        clip: true
        keyNavigationWraps: false
        currentIndex: -1

        ScrollIndicator.vertical: ScrollIndicator {}
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        implicitWidth: 578
        implicitHeight: 88
        color: "transparent"
        border.color: "transparent"
    }
    //! [background]
}
