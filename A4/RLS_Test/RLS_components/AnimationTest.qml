import QtQuick 2.7
import QtQuick.Controls 2.0
Item {
    id:root
    anchors.fill: parent

    property bool exitRun: false
    Rectangle{
        id:buttonSafe
        width:95
        height:95
        color:"transparent"
       // anchors.centerIn: parent

        Image{
            id:safeimage
            anchors.fill: parent
            source:"../icons/safe.png"
            opacity:0.6
        }
        MouseArea{
        anchors.fill:parent
        hoverEnabled: true
        onExited:{
            exitRun=true

        }
        onClicked: pop.open()
    }
        RLSPopup{
            id:pop
            x:100
            transformOrigin: Item.TopLeft
            closePolicy: Popup.NoAutoClose
            RLSSystemPopup{
                id:popupWidget
                contentText:qsTr("是否退出游戏 ?")
                buttonText:qsTr("确定")

             }
        }

    AnimatedSprite{
        id: imageLeave
        anchors.centerIn: parent
        width: 95
        height: 95
        frameWidth: 95
        frameHeight: 95
        frameCount: 8
        // frameSync: true
        frameRate: 18
        source:"../icons/safe_Leave.png"
        interpolate: true
        loops: Animation.Infinite
        visible: exitRun
        running:exitRun
    }

}
    Component.onCompleted: {
               popupWidget.closePop.connect(pop.close)
           }

}
