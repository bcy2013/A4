import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Reciver 1.0
import QtQml.Models 2.2
import "./MaterialUI/Interface"
import "./RLS_components"
ApplicationWindow {
    id:root
    visible: true
    width: 1280
    height: 720
    title: qsTr("RLS_Test")

        Reciver{
            id:reciver
            onDeviceNameChanged:{
                deviceModel.append(
                                     {
                                         "IP":reciver.deviceName
                                     }               )
                deviecList.currentIndex=deviceModel.count-1
                pageIndicator.currentIndex=deviceModel.count-1
        }
        }
        MaterialSnackbar{
            id:tips
        }

        ListModel{
            id:deviceModel

        }
    header: ToolBar {
             RowLayout {
                 anchors.fill: parent
                ComboBox{
                    id:deviecList
                    enabled: false
                    anchors.left: parent.left
                   anchors.leftMargin: 10
                   model:deviceModel
                   onActivated:  pageIndicator.currentIndex=deviecList.currentIndex
                }
                Switch {
                    id:linkState
                    anchors.left: deviecList.right
                    anchors.leftMargin: 10
                    checked: reciver.isConnected?true:false
                    text: linkState.checked? qsTr("设备已连接"):qsTr("设备已断开")
                    onClicked: {
                         reciver.closeClientConnection()
                        deviceModel.clear()
                        deviecList.enabled=false
                    }
                    onCheckedChanged: {
                        if(linkState.checked){
                       deviecList.enabled=true
                        tips.open(qsTr("有设备连入！！"))
                    }else{
                      // reciver.closeClientConnection()
                }
                        }
                }
                Label{
                    id:deviceSendPort
                    visible: reciver.deviceSendPort===0000?false:true
                    text:qsTr("Device CMD Port:")+reciver.deviceSendPort
                    font.pixelSize: 14
                   anchors.left: deviceRecivePort.right
                    anchors.leftMargin: 20
                }
                Label{
                    id:deviceRecivePort
                    visible: true
                    text:qsTr("PC CMD Port:")+reciver.deviceRecivePort
                    font.pixelSize: 14
                     anchors.left: linkState.right
                    anchors.leftMargin: 20
                }
                 Item { Layout.fillWidth: true }
                 Label{
                     text:qsTr("当前设备连接数:  "+deviecList.count)
                     anchors.right: parent.right
                     anchors.rightMargin: 20
                 }

             }
         }
    RLS_ChartView{
        anchors.fill: parent
           }


    footer: PageIndicator{
        id:pageIndicator
        count: deviecList.count
        currentIndex: deviecList.currentIndex
    }


}
