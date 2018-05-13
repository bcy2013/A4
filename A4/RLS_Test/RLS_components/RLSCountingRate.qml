import QtQuick 2.7
import "../RLSTheme"
import QtQuick.Controls 2.0
import ChartsData 2.0
import EquivalentDoae 1.0
Rectangle {
    id:root
    height:40
    radius: 20
    width: countingRate.contentWidth+40
    color:"#000000"
    opacity: 0.5
    property int count: 600
    property real dose: 0.156
    ChartData{
        id:data
    }
    EquivalentDoaeData{
        id:doseData
    }



    Label{
        id:countingRate
        text:qsTr("计数率: ")+data.yvalue+"cps      "+qsTr("剂量率: ")+doseData.yValue.toFixed(4)+"sv/s"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.family: RLSTheme.fontFamily
        font.pixelSize: RLSTheme.fontSize.F2
        color:RLSTheme.backgroundColor.C2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

}
