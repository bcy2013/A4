import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import "../RLSTheme"
ApplicationWindow {
     id:mainWindow
     width:1920
     height:1080
     modality: Qt.ApplicationModal
     flags: Qt.Window


     SwipeView{
         id:swipeView
         anchors.fill: parent
         currentIndex: indicator.currentIndex

         Item{
            id: firstPage
             SwipeViewContent {
                id:firstPageSwipe
                z:1
                title: qsTr("监控区")
                contentText1: qsTr("图像监控区域显示实时监控图像;")
                buttonText: qsTr("下一步")
                currentPage: 0
                onNextPage:{
                    swipeView.currentIndex=firstPageSwipe.currentPage+1;
                }
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/1Page.png"
             }

         }
         Item{
              id: secondPage
             SwipeViewContent {
                 id:secondPageSwipe
                 title: qsTr("状态区")
                 contentText1: qsTr("1. 状态区域反应系统实时报警状态，各个状态在发生问题时报警;")
                 contentText2: qsTr("2. 功能自左向右(放射源等级，放射源定位，探测器未连接，摄像头未连接，硬盘报警，温度报警，声音报警);")
                 buttonText: qsTr("下一步")
                 currentPage: 1
              z:1
              onNextPage:  swipeView.currentIndex=secondPageSwipe.currentPage+1
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/2Page.png"
             }

         }
         Item{
              id: thirdPage
             SwipeViewContent {
                 id:thirdPageSwipe
                 title: qsTr("计数率/剂量率")
                 contentText1: qsTr("显示实时监控录像的计数率与剂量率数值;")
                 buttonText: qsTr("下一步")
                 currentPage: 2
              z:1
              onNextPage: swipeView.currentIndex=thirdPageSwipe.currentPage+1
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/3Page.png"
             }

         }
         Item{
              id: forthPage
             SwipeViewContent {
                 id:forthPageSwipe
                 title: qsTr("工具栏")
                 contentText1: qsTr("1. 主菜单，包含(数据回放、报警处、基本设置、高级设置、关于、帮助);")
                 contentText2: qsTr("2. 模式切换，包含(旅检模式、核爆模式、演示模式、核电模式、货检模式、自定模式);")
                 contentText3: qsTr("3. 监控界面最大化最小化切换;")
                 contentText4: qsTr("4. 退出程序;")
                 buttonText: qsTr("下一步")
                 currentPage: 3
              z:1
              onNextPage: swipeView.currentIndex=forthPageSwipe.currentPage+1
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/4Page.png"
             }

         }
         Item{
              id: fifthPage
             SwipeViewContent {
                 id:fifthPageSwipe
                 title: qsTr("曲线区")
                 contentText1: qsTr("1. 该区域显示实时曲线，包括(计数率曲线、剂量当量率曲线、矫正能谱曲线);")
                 contentText2: qsTr("2. 显示实时监控时曲线的状态;")
                 buttonText: qsTr("下一步")
                 currentPage: 4
              z:1
              onNextPage: swipeView.currentIndex=fifthPageSwipe.currentPage+1
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/5Page.png"
             }

         }
         Item{
              id: sixthPage
             SwipeViewContent {
                 id:sixthPageSwipe
                 title: qsTr("敏感图像区")
                 contentText1: qsTr("1. 显示报警时敏感图像,帮助监控者确认放射源目标;")
                 contentText2: qsTr("2. 点击查看更多，可显示历史敏感图片;")
                 currentPage: 5
                 buttonText: qsTr("下一步")
              z:1
              onNextPage: swipeView.currentIndex=sixthPageSwipe.currentPage+1
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/6Page.png"
             }

         }
         Item{
              id: lastPage
             SwipeViewContent {
                 title: qsTr("时间显示区")
                 contentText1: qsTr(" 显示本地实时时间;")
              z:1
               currentPage: 6
               buttonText: qsTr("知道了")
              onNextPage: mainWindow.close()
             }
             Image{
                 anchors.fill:parent
                 source: "../icons/7Page.png"
             }

         }
     }

     PageIndicator {
         id: indicator

         count: swipeView.count
         currentIndex: swipeView.currentIndex
         anchors.bottom: swipeView.bottom
         anchors.bottomMargin: 330
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.horizontalCenterOffset: -180
         delegate: Rectangle {
                   implicitWidth: 8
                   implicitHeight: 8

                   radius: width / 2
                   color: RLSTheme.textColor.C9

                   opacity: index === indicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                   Behavior on opacity {
                       OpacityAnimator {
                           duration: 100
                       }
                   }
               }
     }


     Component.onCompleted: {
         mainWindow.visible=true
         showFullScreen()
     }
}
