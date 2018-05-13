import QtQuick 2.7
import QtCharts 2.1
import "../RLSTheme"
import EquivalentDoae 1.0
Rectangle{
      id:root
      implicitWidth:360
      implicitHeight: 300
      //property string dateString
      color:RLSTheme.backgroundColor.C1
      property real yVal: 0

//      function timeNow(){
//          var d=new Date(data.xvalue);
//          return d.toUTCString();
//      }

      EquivalentDoaeData{
          id:data
          onXValueChanged: addData();
      }

      Text{
          id:text
          font.family: RLSTheme.fontFamily
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          font.pointSize: RLSTheme.fontSize.F3

      }
      ChartView {
          id: chartView
          anchors.fill: parent
          animationDuration:300
          title:qsTr("剂量当量曲线")
          titleColor: RLSTheme.backgroundColor.C2
          titleFont:text.font

          legend.visible: false
          dropShadowEnabled : true
          margins.left:15
          margins.top:10
          margins.right: 0
          margins.bottom: 0

          backgroundColor: RLSTheme.backgroundColor.C1
          animationOptions: ChartView.SeriesAnimations
          antialiasing: true


          ValueAxis {
              id: axisY
              min: 0.0
              max: 0.5
              tickCount: 6
              labelsFont.family:"微软雅黑"
              labelsFont.pixelSize: 12
              labelsColor : "#ffffff"
              labelFormat: "%.1e"
          }
          DateTimeAxis{
              id:axisDateTime
              labelsAngle: 45
              labelsFont.family: "微软雅黑"
              labelsFont.pixelSize: 12
              tickCount: 7
              labelsColor : "#ffffff"
              format:"hh:mm"
          }

          LineSeries {
              name:"EquivalentDoae series"
              id: series1
              axisX: axisDateTime
              axisY: axisY

          }
        }


      function addData(){
          chart2.visible=data.doseCurveDisplay
          series1.color=data.doseCurveColor;
          series1.width=data.doseCurveWidth;
          switch(data.lineDoseCurveLineType){
          case 1:
              series1.style=Qt.SolidLine;
              break;
          case 2:
              series1.style=Qt.DashLine;
              break;
          }
          var lineSeries = chartView.series("EquivalentDoae series");
          if(lineSeries){
              var cur=new Date(data.xValue);

              var min=new Date(new Date(data.xValue).setMinutes(0));
              var max=new Date(new Date(data.xValue).setMinutes(60));
              chartView.axisX().min=min;
              chartView.axisX().max=max;
             if(cur.getMinutes()==60){
                 var offset=cur.getMinutes()/10+1;
                 max.setHours(cur.getHours());
                 max.setMinutes(offset*10);
                 min.setHours(cur.getHours()-1);
                 min.setMinutes(offset*10);
                 chartView.axisX().min=min;
                 chartView.axisX().max=max;
             }

             if(data.yValue>chartView.axisY().max)
             {    chartView.axisY().max=data.yValue+0.5;
             }


            lineSeries.append(data.xValue,data.yValue.toFixed(2));
      }

}
      Component.onCompleted: chart2.visible=data.doseCurveDisplay
}

