import QtQuick 2.7
import QtQuick.Controls 2.0
import QtCharts 2.2
//import Reciver 1.0
import "../RLSTheme"
Rectangle{
      id:root
      implicitWidth:360
      implicitHeight: 300
      color:RLSTheme.backgroundColor.C1
      property real yVal: 0
      property int xPoint: 0
      property int yPonit: 0

      Timer{
          id:timer
          repeat: true
          interval: 40
          onTriggered: addData()
      }
//     Reciver{
//         id:reciver
//         onDataVectorChanged: {
//             for(var i=0;i<128;i++)
//                 console.log(i+":"+reciver.getY(i));
//         }
//     }


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
          animationDuration:250
          title:qsTr("能谱曲线")
          titleColor: RLSTheme.backgroundColor.C2
          titleFont:text.font

          legend.visible: false
          margins.left:15
          margins.top:10
          margins.right: 0
          margins.bottom: 0

          backgroundColor: RLSTheme.backgroundColor.C1
          animationOptions: ChartView.AllAnimations
         // antialiasing: true

          MouseArea
          {
                id: mouseArea
                anchors.fill: parent;
              //  cursorShape:Qt.OpenHandCursor
               // acceptedButtons: Qt.LeftButton | Qt.RightButton // 激活右键（别落下这个）
                onDoubleClicked: {
                   // if (mouse.button == Qt.RightButton) { // 右键菜单
                        //
                        clearEneryData.x=mouseArea.mouseX
                        clearEneryData.y=mouseArea.mouseY
                        clearEneryData.open()
                    }
              //  }
          }


          ValueAxis {
              id: axisY
              tickCount: 6
              min:0
              max:1000
              labelsFont.family:"微软雅黑"
              labelsFont.pixelSize: 12
              labelsColor : "#ffffff"
              labelFormat: "%.1e"
          }
          ValueAxis{
              id:axisX
              labelsAngle: 0
              minorTickCount : 1
              min:0
              max:128
              labelsFont.family: "微软雅黑"
              labelsFont.pixelSize: 12
              tickCount: 9
              labelsColor : "#ffffff"
              labelFormat: "%d"
          }

          LineSeries {
              name:"Energy series"
              id: series1
              axisX: axisX
              axisY: axisY
              useOpenGL : true
              onHovered: {
                  xPoint=point.x;
                  yPonit=point.y
              }
          }
        }
      Menu{
          id:clearEneryData
          z:99
          MenuItem {
              text: qsTr("显示曲线")
              font.family: RLSTheme.fontFamily
              font.pixelSize: 14
              onTriggered: timer.running=true
          }
          MenuItem{
               text:qsTr("清空能谱")
               font.family: RLSTheme.fontFamily
               font.pixelSize: 14
               onTriggered:clear()
          }
      }
     function getYPoint( x){
          var lineSeries = chartView.series("Energy series");
         if(lineSeries){
             return series1.at(x);
         }

     }
      function addData(){      
//          axisX.min=data.reallyCurveXLow;
//          axisX.max=data.reallyCurveXHigh;
//          axisY.min=data.reallyCurveYLow;
//          axisY.max=data.reallyCurveYHigh;
//          chart3.visible=data.reallySpectralCurveDisplay;
            series1.color="#68b5ae";
             series1.width=2;
//          switch(data.lineReallySpectralCurveLineType){
//          case 1:
//              series1.style=Qt.SolidLine;
//              break;
//          case 2:
//              series1.style=Qt.DashLine;
//              break;
//          }
          var lineSeries = chartView.series("Energy series");
          if(lineSeries){
                 lineSeries.clear();
               for(var i=0;i<128;i++)
               {
                  lineSeries.append(i,reciver.getY(i));
                   if((reciver.getY(i)>chartView.axisY().max))
                       chartView.axisY().max=reciver.getY(i)+50;
               }
         }
}
      function clear(){
          var lineSeries = chartView.series("Energy series");
          if(lineSeries){
              if( axisY.max!=1000)
               axisY.max=1000;
                lineSeries.clear();
          }
      }
//Component.onCompleted: timer.running=true
}
