import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
import QtQuick.Window 2.0
import io.qt.examples.texteditor 1.0
ApplicationWindow {
    visible: true
    width: 720
    height: 480
    title: qsTr("RLS_Test  Sender")
    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }
    header: ToolBar{
        background: Rectangle{
            implicitHeight:40
            color:"#464646"
        }
        RowLayout{
            anchors.fill: parent
            spacing: 2
            TextField {
                id: textField
                placeholderText: qsTr("FilePath here...")
                anchors.left: parent.left
                anchors.leftMargin: 10
                 Layout.preferredWidth: parent.width*0.5
            }
            ToolButton{
                text:qsTr("GetConnect")
                Layout.fillWidth: true
                onClicked: Sender.sendInitConnectionCMD()
            }
            ToolButton{
                text:qsTr("OpenFile")
                Layout.fillWidth: true
                onClicked: openDialog.open()
            }
            ToolButton{
                text:qsTr("StartSend")
                Layout.fillWidth: true
                onClicked: {Sender.startBroadcastsender(
                              openDialog.currentFile ,
                               textFieldTimeS.text,
                               textFieldTimeL.text
                               )
                }
            }
            ToolButton{
                text:qsTr("StopSend")
                Layout.fillWidth: true
                onClicked: Sender.stopBroadcastsender()
            }
        }
    }
    Rectangle{
        id:mainContent
        anchors.fill: parent
        Rectangle{
            id:timeStamps
            height: 50
            width: parent.width
            color: "#cccccc"
            RowLayout{
                anchors.fill: parent
                Label{
                    text:qsTr("smallest time:    ")
                }
                TextField {
                    id: textFieldTimeS
                     Layout.fillWidth: true
                    text: document.earliestTime?document.earliestTime:"No File,     Sorry!"
                }

                Label{
                    text:qsTr("lagest time:    ")
                }
                TextField {
                    id: textFieldTimeL
                    font.pointSize: 12
                     Layout.fillWidth: true
                   text: document.lastestTime?document.lastestTime:"No File,      Sorry!"
                }
                Button{
                    width: 100
                    text:qsTr("Clips")
                }
                Button{
                    width: 100
                    text:qsTr("GetTimeList")
                    onClicked: {
                        var list=Sender.getTimeList();
                        var length=Sender.getTimeListLength();
                        if(timeListModel.count!=0)
                            timeListModel.clear()
                        for(var i=0;i<=length;i++)
                        {
                            timeListModel.append(
                                        {
                                            "stamps":list[i]
                                        }
                                        )
                        }
                        timeList.open()
                }
                }
            }
        }

        Pane {
            id: pane
            width: parent.width
            height: parent.height-timeStamps.height
            anchors.top: timeStamps.bottom
            Flickable {
                id: flickable
                flickableDirection: Flickable.VerticalFlick
                anchors.fill: parent
                width: parent.width
                height: 640
                TextArea.flickable: TextArea {
                    id: textArea
                    textFormat: Qt.RichText
                    wrapMode: TextArea.Wrap
                    focus: true
                    selectByMouse: true
                    persistentSelection: true
                    // Different styles have different padding and background
                    // decorations, but since this editor is almost taking up the
                    // entire window, we don't need them.
                    leftPadding: 6
                    rightPadding: 6
                    topPadding: 0
                    bottomPadding: 0
                    background: null
                }
                ScrollBar.vertical: ScrollBar {}
            }
        }
    }
    DocumentHandler {
        id: document
        document: textArea.textDocument
        cursorPosition: textArea.cursorPosition
        selectionStart: textArea.selectionStart
        selectionEnd: textArea.selectionEnd
        textColor: "#ffffff"
       // Component.onCompleted: document.load("qrc:/texteditor.html")
        onLoaded: {
            textArea.text = text
        }
    }
    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 1
        nameFilters: ["Raw files (*.raw)"]
        modality:Qt.WindowModal
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: {
            var path=new String(openDialog.currentFile)
            textField.text=path.slice(8)
           document.load(openDialog.currentFile)
        }
    }
   Drawer{
       id:timeList
      y:header.height+timeStamps.height
      width:parent.width*0.25
      height:parent.height-timeStamps.height
      ListView{
             height: timeList.height
             width: timeList.width
             model:timeListModel
             spacing:2
             delegate:Rectangle
             {   id:back
                 implicitWidth:timeList.width
                 implicitHeight:40
                 color:"#68b5ae"
                 opacity:0.85
                 Text {
                 text:stamps
                 anchors.centerIn: back
                 font.family: "微软雅黑"
                 color: "#ffffff"
                 font.pixelSize: 14
                 horizontalAlignment:Text.AlignHCenter
                   }
             }
              ScrollBar.vertical: ScrollBar {
                  width: 10
              }
      }
   }
   ListModel{
       id:timeListModel
   }
}
