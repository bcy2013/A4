import QtQuick 2.7
import QtCharts 2.0
Rectangle {
    anchors.fill:parent
    color:"transparent"
    Column{
        anchors.fill: parent
    spacing:2
    RLSChart{
       id:chart1
      // source: "images/10.png"s
    }
    RLSChartOne{
       id:chart2
      // source: "images/20.png"

    }
    RLSChartEnergy{
       id:chart3
      // source: "images/14.png"

    }

}

}
