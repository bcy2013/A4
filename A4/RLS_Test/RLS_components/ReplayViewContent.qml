import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import Charts 1.1
import "../RLSTheme"
import "../Lib/MaterialUI/Interface" as Material
Item {
    anchors.fill: parent
    property int leftMargin: 20
    property int rightMargin: 20
    property var componentModel: [
        {name:qsTr("数据回放"),icon:"accountAD",component:historyDataView}

    ]
    Loader{
        id:componentloader
        //anchors.fill:parent
        visible: status == Loader.Ready
        sourceComponent: componentModel[controlData.componentIndex].component

    }

   Material.MaterialSnackbar{
        id:tips
    }
    Component{
        id:historyDataView
        Rectangle{
            id:historyDataViewContent
            width:1920
            height:1014
            color:RLSTheme.backgroundColor.C6


           Rectangle{
               id:historyDataListView
               width:360
               height:parent.height
               anchors.right: parent.right
               color:RLSTheme.backgroundColor.C1


               ListModel {
                   id: rootModel
                   Component.onCompleted: function initListView(){
                       for(var i=0;i<historyReplay.count;i++){
                           rootModel.append(
                                       {
                                           "name":historyReplay.getThumbnail(i),
                                       }
                                       );
                            console.log(rootModel.get(i).name);
                       }
                       historyReplay.replayFile=rootModel.get(0).name;
                       //historyReplay.initHistoryReplay();
                       historyReplay.historyReplay();
                       //console.log(historyReplay.replayFile);
                   }
                      }


               ListView{
                   id:mainViewArea
                   anchors.fill: parent
                   spacing:2
                   model:rootModel

                   //snapMode :ListView.SnapOneItem

                   delegate: HistoryDataDelegateItem{
                       id:delegateItem
                       name:model.name
                       ListView.onAdd: SequentialAnimation {
                           PropertyAction { target: delegateItem; property: "height"; value: 0 }
                           NumberAnimation { target: delegateItem; property: "height"; to: 280; duration: 200; easing.type: Easing.InOutQuad }
                       }
                   }
                   clip: true
                   header:Rectangle{
                        z:998
                        id:header
                        color:RLSTheme.backgroundColor.C3
                        height:40
                        width:360

                            Label{
                                id:recordConut
                                text:qsTr("历史数据记录(")+historyReplay.count+qsTr(")条")
                                font.family: RLSTheme.fontFamily
                                font.pixelSize: RLSTheme.fontSize.F4
                                color:RLSTheme.textColor.C11
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.verticalCenter: parent.verticalCenter

                            }
                            Image{
                                id:deleteImage
                                source:"../icons/delete.png"
                                width: 21
                                height:24
                                anchors.right: parent.right
                                anchors.margins: 20
                                anchors.verticalCenter: recordConut.verticalCenter
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:deleMenu.open()
                                }
                            }
                            Menu{
                                id:deleMenu
                                background: Rectangle {
                                         implicitWidth: 120
                                         implicitHeight: 40
                                         color: "#ffffff"
                                         border.color: "#353637"
                                     }
                                x:deleteImage.x
                                y:deleteImage.height+deleteImage.y+40
                                MenuItem{
                                    text:qsTr("删除所有")
                                    onTriggered: function removeAll(){
                                      rootModel.clear()
                                      historyReplay.removeAll()

                                    }
                                }
                            }
                            Rectangle{
                                width:parent.width
                                height:2
                                color:RLSTheme.backgroundColor.C1
                                anchors.bottom: parent.bottom
                            }

                   }

                   headerPositioning: ListView.OverlayHeader
                   ScrollIndicator.vertical: ScrollIndicator {
                      id:scrollBar
                      width: 15
                      rightPadding: 3
                  }

               }


           }
           Rectangle{
               id:viewPort
               height:parent.height
               width:parent.width-historyDataListView.width
               anchors.left: parent.left
               color:"black"

                   Rectangle{
                       id:view
                       height:878
                       width:parent.width
                       anchors.top: parent.top
                       anchors.topMargin: (parent.height-view.height)/2
                       HistoryReplay{
                             id:historyReplay
                             imageWidth: parent.width
                             imageHeight: parent.height
                             anchors.fill: parent
                             Component.onCompleted: {

                                 historyReplay.getFilesConut();
                             }
                             onPlayEnd:{
                                 historyReplay.historyReplayEnd()
                             }
                       }
                   }
           }



        }//historyDataViewContent
  }

}
