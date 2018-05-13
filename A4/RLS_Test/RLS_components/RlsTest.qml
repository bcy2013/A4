import QtQuick 2.7
import QtQuick.Controls 2.0
import QtCharts 2.2
import Reciver 1.0
import "../RLSTheme"
ApplicationWindow{
    id:main
    width:1280
    height: 720
    visible: true
    Rectangle{
          id:root
          implicitWidth:360
          implicitHeight: 300
          anchors.centerIn: parent
          //property string dateString
          color:RLSTheme.backgroundColor.C1
          property real yVal: 0

    //      function timeNow(){
    //          var d=new Date(data.xvalue);
    //          return d.toUTCString();
    //      }

          Timer{
              id:timer
              repeat: true
              interval: 40
              onTriggered: addData()
          }
         Reciver{
             id:reciver
             onDataVectorChanged: {
                 timer.running=true;
                 for(var i=0;i<128;i++)
                     console.log(i+":"+reciver.dataVector[i]);
             }
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
              title:qsTr("能谱曲线")
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

              MouseArea
              {
                    id: mouseArea
                    anchors.fill: parent;
                    cursorShape:Qt.OpenHandCursor
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
              }
            }
          Menu{
              id:clearEneryData
              z:99
              MenuItem {
                  text: qsTr("刷新曲线")
                  font.family: RLSTheme.fontFamily
                  font.pixelSize: 14
                  onTriggered: timer.running=true
              }
          }
    //Component.onCompleted: timer.running=true
    }
    function addData(){
        var lineSeries = chartView.series("Energy series");
        if(lineSeries){
               lineSeries.clear();
             for(var i=0;i<128;i++)
             {
                lineSeries.append(i,reciver.dataVector[i]);
                 if((reciver.dataVector[i]>chartView.axisY().max))
                     chartView.axisY().max=reciver.dataVector[i]+50;
             }
       }
}
}


