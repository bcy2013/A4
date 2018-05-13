import QtQuick 2.7
import QtCharts 2.1
import ChartsData 2.0
import "../RLSTheme"
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
      ChartData{
          id:data
         onXvalueChanged:addData()
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
          title:qsTr("计数率曲线")
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
              min: 0
              max: 100
              tickCount: 6
              labelsFont.family:RLSTheme.fontFamily
              labelsFont.pixelSize: 12
              labelsColor:"#ffffff"
              labelFormat:"%.1e"
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
              name:"Rate series"
              id: series1
              axisX: axisDateTime
              axisY: axisY
          }


//          Timer{
//              interval: 1000
//              repeat: true
//              running: true
//              onTriggered:series1.color= Qt.hsla(Math.random(), 0.5, 0.5, 1.0)
//          }

        }


      function addData(){
          chart1.visible=data.countRateCurveDisplay;
          series1.color=data.countRateCurveColor;
          series1.width=data.countRateCurveWidth;
          switch(data.lineCountRateCurveLineType){
          case 1:
              series1.style=Qt.SolidLine;
              break;
          case 2:
              series1.style=Qt.DashLine;
              break;
          }
          var lineSeries = chartView.series("Rate series"); 
          if(lineSeries){
              var cur=new Date(data.xvalue);

              var min=new Date(new Date(data.xvalue).setMinutes(0));
              var max=new Date(new Date(data.xvalue).setMinutes(60));
              chartView.axisX().min=min;
              chartView.axisX().max=max;
             if(cur.getMinutes()==00){
                 var offset=cur.getMinutes()/10+1;
                 max.setHours(cur.getHours());
                 max.setMinutes(offset*10);
                 min.setHours(cur.getHours()-1);
                 min.setMinutes(offset*10);
                 chartView.axisX().min=min;
                 chartView.axisX().max=max;
             }

             if(data.yvalue>chartView.axisY().max)
                 chartView.axisY().max=data.yvalue+50;


            lineSeries.append(data.xvalue,data.yvalue);
      }

}
      Component.onCompleted: chart1.visible=data.countRateCurveDisplay
}
