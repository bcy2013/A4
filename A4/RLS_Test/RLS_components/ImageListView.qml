import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"
import SensitiveImage 1.0
import StateInfo 1.0
Item {
    id:root
    property bool getMore: false
    StateInfo{
        id:stateInfo
    }
    SensitiveImageData{
        id:sensitiveImageData
        source:"file:///"+stateInfo.getSensiveImageDir()
        onImageSaved:{
            imageModel.insert(0,{
                                     "name":sensitiveImageData.name,
                                     "active":true,
                                     "image":sensitiveImageData.name+".jpg"
                                 }
                               );
            imageModel.setProperty(1,"active",false);
        }
        Component.onCompleted:{
            sensitiveImageData.getFilesConut();
            for(var i=0;i<sensitiveImageData.count;i++)
            {
               imageModel.append({
                                    "name":sensitiveImageData.name,
                                    "active":false,
                                    "image":sensitiveImageData.getThumbnail(sensitiveImageData.count-1-i)+".jpg"
                                 }
                   );

            }
        }

    }

    ListView{
        id:mainViewArea
        anchors.fill: parent
        spacing:2
        model: ImageModel{
            id:imageModel
        }
        interactive:getMore

        //snapMode :ListView.SnapOneItem

        delegate: DelegateItem{
            id:delegateItem
            name:model.name
            active:model.active
            ListView.onAdd: SequentialAnimation {
                PropertyAction { target: delegateItem; property: "height"; value: 0 }
                NumberAnimation { target: delegateItem; property: "height"; to: 424; duration: 200; easing.type: Easing.InOutQuad }
            }
        }
        // highlightFollowsCurrentItem: true
        // highlightRangeMode: ListView.StrictlyEnforceRange
        // highlightResizeDuration: 400
        clip: true
        //cacheBuffer: 2000
        //currentIndex:2
        //verticalLayoutDirection :ListView.BottomToTop
        //preferredHighlightBegin:root.height*0.5-140
        //preferredHighlightEnd: root.height*0.5-140
        footer: Rectangle{
            z:999
            id:footer
            color:RLSTheme.backgroundColor.C1
            height:40
            width:360
            Rectangle{
                anchors.centerIn: parent
                Image{
                    width:14
                    height:14
                    source: "../icons/getmore.png"
                    anchors.right:text.left
                    anchors.rightMargin: 6
                    anchors.verticalCenter: text.verticalCenter

                }

                Text{
                    id:text
                    anchors.centerIn: parent
                    text:qsTr("查看更多")
                    font.family: RLSTheme.fontFamily
                    font.pixelSize: RLSTheme.fontSize.F3
                    color:RLSTheme.textColor.C7
                }
            }


            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    getMore=true;
                    footer.visible=false
                    }
                onDoubleClicked: {
                    getMore=false;
                    //mainViewArea.currentIndex=-1
                }
            }
        }

        footerPositioning :ListView.OverlayFooter
        ScrollIndicator.vertical: ScrollIndicator {
           id:scrollBar
           width: 15
           rightPadding: 3
       }

    }


//    Timer{
//        interval: 1000*2
//        running: true
//        repeat: true
//        onTriggered:{
//            imageModel.insert(0,{
//                                     "name":"1.png",
//                                     "active":true
//                                 }
//                               );
//            imageModel.setProperty(1,"active",false);
//        }
//    }




}
