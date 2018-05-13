import QtQuick 2.7
import QtQuick.Controls 2.1
import "./RLS_components"
Item {
    id:chartView
    Rectangle{
        id:backgroundImage
        color:"#353434"
        opacity: 0.7
        anchors.fill: parent
    }
    Rectangle {
        id: rectangle
        color: "#68b5ae"
        anchors.top: parent.top
        anchors.topMargin: 65
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 87
        anchors.right: rectangle1.left
        anchors.rightMargin: 54
        anchors.left: parent.left
        anchors.leftMargin: 21

        RLSChartEnergy{
            id:energyChart
            width:parent.width*0.75
            height:parent.height
        }

        Item {
            id: item1
            y: 0
            height: 54
            anchors.left: energyChart.right
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            Label {
                id: label1
                x: 34
                y: 8
                width: 118
                height: 33
                text: qsTr("Parameter")
                anchors.centerIn: parent
                font.italic: true
                font.bold: true
                font.pointSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        TextField {
            id: textField
            x: 698
            y: 56
            placeholderText: qsTr("0~5000")
            anchors.right: parent.right
            anchors.rightMargin: 0
            onEditingFinished: reciver.highVoltage=Number(textField.text)
        }

        Label {
            id: label2
            y: 56
            width: 63
            height: 44
            text: qsTr("highVoltage:")
            anchors.left: energyChart.right
            anchors.leftMargin: 8
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: textField1
            x: 698
            y: 115
            placeholderText:  qsTr("0~5000")
            anchors.right: parent.right
            anchors.rightMargin: 0
             onEditingFinished: reciver.threshold=Number(textField1.text)
        }

        Label {
            id: label3
            y: 115
            width: 63
            height: 44
            text: qsTr("threshold:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.left: energyChart.right
            anchors.leftMargin: 8
        }

        Item {
            id: item2
            y: 335
            height: 200
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.left: energyChart.right
            anchors.leftMargin: 2

            Label {
                id: label6
                y: 153
                height: 40
                text: qsTr("X: "+energyChart.xPoint+"    "+"Y: "+energyChart.yPonit)
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }

            Label {
                id: label7
                width: 60
                height: 30
                text: qsTr("X: ")
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 2
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: label8
                width: 60
                height: 30
                text: qsTr("Y: ")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: label7.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 2
            }

            TextField {
                id: yPoint
                x: 79
                y: 63
                readOnly: true
                placeholderText:qsTr("Show YPoint")
                horizontalAlignment: Text.AlignLeft
                anchors.right: parent.right
                anchors.rightMargin: 2
                anchors.verticalCenter: label8.verticalCenter

            }

            TextField {
                id: xPoint
                x: 81
                y: 13
                onEditingFinished:showYPoint()
                placeholderText:qsTr("Input YPoint")
                anchors.verticalCenter: label7.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2
            }

        }

        Label {
            id: label4
            y: 175
            height: 40
            text: qsTr("HighVoltage: "+reciver.highVoltage+"  "+"Threshold: "+reciver.threshold)
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: energyChart.right
            anchors.leftMargin: 5
        }
    }

    Rectangle {
        id: rectangle1
        x: 1008
        width: 208
        color: "#68b5ae"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 92
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 64

        Label {
            id: label
            x: 19
            y: 8
            width: 155
            height: 39
            text: qsTr("Operation")
            font.italic: true
            font.bold: true
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            id: button
            x: 19
            y: 62
            width: 166
            height: 48
            text: qsTr("QuaryStatus")
            onClicked: reciver.initConnectinon()
        }

        Button {
            id: button1
            x: 19
            y: 111
            enabled:reciver.isConnected
            width: 166
            height: 48
            text: qsTr("ParameterSetting")
            onClicked: reciver.sendParameterSettingCmd()
        }

        Button {
            id: button2
            x: 19
            y: 219
            enabled: reciver.isConnected
            width: 166
            height: 48
            text: qsTr("StartSendData")
            onClicked: reciver.sendStartSendDataCmd()
        }

        Button {
            id: button3
            x: 19
            y: 165
            enabled:  reciver.isConnected
            width: 166
            height: 48
            text: qsTr("CurrenParameter")
            onClicked:  reciver.sendGetCurrenParameterCmd()
        }

        Button {
            id: button4
            x: 19
            y: 273
            enabled: reciver.isConnected
            width: 166
            height: 48
            text: qsTr("StopSendData")
            onClicked:  reciver.sendStopSendDataCmd()
        }
    }
  function showYPoint(){
      var str=energyChart.getYPoint(Number(xPoint.text)).toString();
      var temp=str.indexOf(",");
      var temq=str.indexOf(")");
       yPoint.text=str.substring(temp+1,temq);
  }
}
