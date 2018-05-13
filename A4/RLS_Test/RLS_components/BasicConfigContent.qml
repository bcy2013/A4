import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import BasicConfig 1.0
import StateInfo 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.Dialogs 1.2
import EquivalentDoae 1.0
import EnergyCurve 1.0
import ChartsData 2.0
import QtQuick.Templates 2.0 as T
import "../RLSTheme"
import "../Lib/MaterialUI/Interface"
Item {
    anchors.fill: parent
    property int leftMargin: 20
    property int rightMargin: 20
    property var componentModel: [

        {name:qsTr("图像显示"),icon:"Image",component:imageView},
        {name:qsTr("曲线显示"),icon:"curve",component:curveView},
        {name:qsTr("报警参数"),icon:"Caution",component:warmingView},
        {name:qsTr("定位仪"),  icon:"positioning",component:positionView},
        {name:qsTr("重建参数"),icon:"reconstruction",component:reconstructionView},
        {name:qsTr("硬盘设置"),icon:"disk",component:hardDiskView}
    ]
    Loader{
        id:componentloader
        //anchors.fill:parent
        visible: status == Loader.Ready
        sourceComponent: componentModel[controlData.componentIndex].component

    }

    MaterialSnackbar{
        id:tips
    }

    Component{
        id:imageView


       Rectangle{
           id:content
           width:600
           height:1014
           color:RLSTheme.backgroundColor.C6
           BasicConfig{
               id:basicConfig
           }


       GridLayout{
             id:gridLayout
             anchors.left: parent.left
             anchors.leftMargin: 20
             width:560
             columns: 2
             rowSpacing: 22


             RLSConfigSeparate{
                 Layout.columnSpan: 2
             }
             RLSConfigLabel{
                 text:qsTr("可见光是否剪切")
             }
            RLSSwitch{
                 id:imageCut
                 checked: basicConfig.imageCut
                 anchors.right: parent.right
                 onClicked: {
                      basicConfig.imageCut=imageCut.checked;
                      basicConfig.updateAllConfig()
                      tips.open("设置已保存！！")
                 }
             }
             RLSConfigSeparate{
                 Layout.columnSpan: 2
             }
             RLSConfigLabel{
                 text:qsTr("图像尺寸")
             }

             RLSTextField{
                 id:imageSize
                 width:370
                 readOnly: true
                 enabled:imageCut.checked?true:false
                 cursorVisible: false
                 imageSource:"../icons/down.png"
                 anchors.right: parent.right
                 font.family: RLSTheme.fontFamily
                 font.pixelSize: RLSTheme.fontSize.F3
                 color:RLSTheme.textColor.C10
                 onPopupOpen:imageSizeMenu.open()
                 Component.onCompleted: function initText(){
                     switch(basicConfig.imageSize)
                     {
                     case 0:
                         imageSize.text=qsTr("原始大小");break;
                     case 1:
                         imageSize.text=qsTr("等比例缩放");break;
                     case 2:
                         imageSize.text=qsTr("铺满屏幕");break;
                     }
                 }
             }
//             RLSConfigSeparate{
//                 Layout.columnSpan: 2
//             }
//             RLSConfigLabel{
//                 text:qsTr("图像显示")
//             }

//             RLSTextField{
//                 id:imageViewModel
//                 width:370
//                 readOnly: true
//                 cursorVisible: false
//                 imageSource:"../icons/down.png"
//                 anchors.right: parent.right
//                 font.family: RLSTheme.fontFamily
//                 font.pixelSize: RLSTheme.fontSize.F3
//                 color:RLSTheme.textColor.C10
//                 onPopupOpen:imageViewModelMenu.open()
//                 Component.onCompleted: function initText(){
//                     switch(basicConfig.imageDisplay)
//                     {
//                     case 0:
//                         imageViewModel.text=qsTr("仅显示可见光图像");break;
//                     case 1:
//                         imageViewModel.text=qsTr("仅显示探测器图像");break;
//                     case 2:
//                         imageViewModel.text=qsTr("图像融合显示");break;
//                     }
//                 }
//             }

             RLSConfigSeparate{
                 Layout.columnSpan: 2
             }
             RLSConfigLabel{
                 text:qsTr("融合比例")
             }
             RowLayout{
                 anchors.right: parent.right
                 spacing:20
                 RLSSlider{
                     id:slider
                     Layout.preferredWidth: 370
                     from:0
                     to:1
                     value: basicConfig.imageFuseRatio
                     stepSize :0.1
                     snapMode:Slider.SnapOnRelease
                    // anchors.right: parent.right
                     onValueChanged: {

                         basicConfig.imageFuseRatio=slider.value.toFixed(1)
                         basicConfig.updateAllConfig()
                         tips.open("设置已保存！！")
                     }
                 }
                 RLSConfigLabel{
                     id:label
                     text:slider.value.toFixed(1)*100+"%"
                 }
             }

             RLSConfigSeparate{
                 Layout.columnSpan: 2
             }
       }

       RLSConfigMenu{
           id:imageSizeMenu
           //parent:content
           dim:true
           modal:true

           focus: false
           transformOrigin : Popup.Bottom

           y:parent.height-10-imageSizeMenu.height
           x:11
           RLSConfigMenuItem{
               id:menuItem1
               text:qsTr("等比例缩放")
               autoExclusive : true
               checkable:true
               checked: basicConfig.imageSize==1?true:false
               onTriggered:{
                   tips.open("设置已保存！！")
                   imageSize.text= menuItem1.text
                   basicConfig.imageSize=1
                   basicConfig.updateAllConfig()
               }
           }
           RLSConfigMenuItem{
                id:menuItem2
               text:qsTr("原始大小")
               autoExclusive : true
               checkable:true
               checked: basicConfig.imageSize==0?true:false
               onTriggered:{
                   tips.open("设置已保存！！")
                   imageSize.text= menuItem2.text
                   basicConfig.imageSize=0
                   basicConfig.updateAllConfig()
               }
           }
           RLSConfigMenuItem{
               id:menuItem3
               text:qsTr("铺满屏幕")
               autoExclusive : true
               checkable:true
               checked: basicConfig.imageSize==2?true:false
               onTriggered:{
                   tips.open("设置已保存！！")
                   imageSize.text= menuItem3.text
                   basicConfig.imageSize=2
                   basicConfig.updateAllConfig()
               }
           }
           onOpened: imageSize.imageSource="../icons/up.png"
           onClosed: {imageSize.imageSource="../icons/down.png";imageSize.forceActiveFocus();}
       }
       RLSConfigMenu{
           id:imageViewModelMenu
           parent:content
           dim:true
           modal:true
           focus: false
           transformOrigin : Popup.Bottom
           y:parent.height-10-imageSizeMenu.height
           x:11
           RLSConfigMenuItem{
               id:menuItem4
               text:qsTr("仅显示可见光图像")
               autoExclusive : true
               checkable:true
               checked: basicConfig.imageDisplay==0?true:false
               onTriggered: {
                   imageViewModel.text=menuItem4.text
                   basicConfig.imageDisplay=0
                   basicConfig.updateAllConfig()
                   tips.open("设置已保存！！")
                   }
           }
           RLSConfigMenuItem{
               id:menuItem5
               text:qsTr("仅显示探测器图像")
               autoExclusive : true
               checkable:true
               checked:basicConfig.imageDisplay==1?true:false
               onTriggered: {
                   imageViewModel.text=menuItem5.text
                   basicConfig.imageDisplay=1
                    basicConfig.updateAllConfig()
                   tips.open("设置已保存！！")
                   }
           }
           RLSConfigMenuItem{
               id:menuItem6
               text:qsTr("图像融合显示")
               autoExclusive : true
               checkable:true
                checked:basicConfig.imageDisplay==2?true:false
               onTriggered: {
                   imageViewModel.text=menuItem6.text
                   basicConfig.imageDisplay=2
                    basicConfig.updateAllConfig()
                   tips.open("设置已保存！！")
                   }
           }
           onOpened: imageViewModel.imageSource="../icons/up.png"
           onClosed: {imageViewModel.imageSource="../icons/down.png";imageViewModel.forceActiveFocus();}
       }

    }      
    }
///////////////////////=!CurveConfig!=///////////////////////////
    Component{
        id:curveView

        Rectangle{
            id:curveViewContent
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
            BasicConfig{
                id:basicConfig
            }
            EquivalentDoaeData{
                id:data
            }
            EnergyCurveData{
            id:energyCurveData
            }
            ChartData{
                id:countRateData
            }

       ColumnLayout{
           spacing:0
           RLSConfigButton{
               id:countRate
               text:qsTr("计数率曲线")
               checkable: true
               //checked: true
               autoExclusive : true
               onClicked:countRatePopup.open()
           }
           RLSConfigSeparate{
               Layout.preferredWidth : parent.width
           }
           RLSConfigButton{
               id:doseCurve
               text:qsTr("剂量当量曲线")
               checkable: true
               autoExclusive : true
               onClicked:doseCurvePopup.open()
           }
           RLSConfigSeparate{
               Layout.preferredWidth : parent.width
           }
           RLSConfigButton{
               id:reallySpectralCurve
               text:qsTr("矫正能谱曲线")
               checkable: true
               autoExclusive : true
               onClicked: reallySpectralCurvePopup.open()
           }
           RLSConfigSeparate{
               Layout.preferredWidth : parent.width
           }
       }
       RLSPopup{
           id:countRatePopup
           width:600
           height: 1014
           x:parent.width
           leftPadding: 1
           transformOrigin: Popup.TopLeft
           Rectangle{
               anchors.fill: parent
               color:RLSTheme.backgroundColor.C6
               GridLayout{
                     id:countRatePopupGridLayout
                     anchors.left: parent.left
                     anchors.leftMargin: 20
                     width:560
                     columns: 2
                     rowSpacing: 22
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("是否显示")
                     }
                     RLSSwitch{
                         id:countRateDisplay
                         checked: basicConfig.countRateCurveDisplay
                         anchors.right: parent.right
                         onClicked: {
                              basicConfig.countRateCurveDisplay=countRateDisplay.checked;
                              basicConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线颜色")
                     }
                     RLSTextField{
                         id:countRateLineColor
                         Layout.preferredWidth:370
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         readOnly: true
                         color:countRateData.countRateCurveColor
                         //placeholderText :doseCurveLineColor.activeFocus?"": data.doseCurveColor
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:countRateLineColorMenu.open()
                         Component.onCompleted: function initText(){
                             if(countRateData.countRateCurveColor=="#68b5ae")
                                countRateLineColor.text="默认"
                             if(countRateData.countRateCurveColor=="#fff200")
                                countRateLineColor.text="可选色一"
                             if(countRateData.countRateCurveColor=="#019f43")
                                countRateLineColor.text="可选色二"
                             if(countRateData.countRateCurveColor=="#e60111")
                                countRateLineColor.text="可选色三"
                             if(countRateData.countRateCurveColor=="#00a1ea")
                                countRateLineColor.text="可选色四"
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线宽度")
                     }
                     RowLayout{
                         anchors.right: parent.right
                         spacing: 20
                         RLSSlider{
                             id:countRateCurveLineWidth
                             from:0.5
                             to:2.0
                             value:countRateData.countRateCurveWidth
                             stepSize :0.1
                             snapMode:Slider.SnapOnRelease
                             Layout.preferredWidth : 370
                             onValueChanged: {
                                 countRateData.countRateCurveWidth=countRateCurveLineWidth.value.toFixed(1)
                                 countRateData.updateAllConfig()
                                 tips.open("设置已保存！！")
                             }
                            // anchors.right: parent.right
                         }
                         RLSConfigLabel{
                             id:dcountRateCurveLineWidthLabel
                             text:countRateCurveLineWidth.value.toFixed(1)+"   px"
                         }
                     }

                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线风格")
                     }
                     RLSTextField{
                         id:curveLineStyle
                         Layout.preferredWidth:370
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         readOnly: true
                         color:RLSTheme.textColor.C10
                         //placeholderText :countRateData.lineCountRateCurveLineType
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:curveLineStyleMenu.open()
                         Component.onCompleted: function initText(){

                             switch(countRateData.lineCountRateCurveLineType){
                             case 1:
                                 curveLineStyle.text="实线"
                                 break;
                             case 2:
                                 curveLineStyle.text="虚线"
                                 break;
                             }
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
               }

               RLSConfigMenu{
                   id:countRateLineColorMenu
                   dim:true
                   modal:true
                   focus:false
                   transformOrigin: Popup.Bottom
                   x:parent.x+11
                   y:parent.height-10-countRateLineColorMenu.height
                   RLSConfigMenuItem{
                       id:countRateLineColorMenuItem1
                       text:qsTr("默认")
                       textColor: "#68b5ae"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:countRateData.countRateCurveColor==countRateLineColorMenuItem1.textColor?true:false
                       onTriggered: {
                           countRateLineColor.text=countRateLineColorMenuItem1.text
                           countRateData.countRateCurveColor=countRateLineColorMenuItem1.textColor
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:countRateLineColorMenuItem2
                       text:qsTr("可选色一")
                       isColorSelect: true
                       textColor: "#fff200"
                       autoExclusive : true
                       checkable:true
                       checked:countRateData.countRateCurveColor==countRateLineColorMenuItem2.textColor?true:false
                       onTriggered: {
                           countRateLineColor.text=countRateLineColorMenuItem2.text
                           countRateData.countRateCurveColor=countRateLineColorMenuItem2.textColor
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:countRateLineColorMenuItem3
                       text:qsTr("可选色二")
                       textColor: "#019f43"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:countRateData.countRateCurveColor==countRateLineColorMenuItem3.textColor?true:false
                       onTriggered: {
                           countRateLineColor.text=countRateLineColorMenuItem3.text
                           countRateData.countRateCurveColor=countRateLineColorMenuItem3.textColor
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:countRateLineColorMenuItem4
                       text:qsTr("可选色三")
                       textColor: "#e60111"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:countRateData.countRateCurveColor==countRateLineColorMenuItem4.textColor?true:false
                       onTriggered: {
                           countRateLineColor.text=countRateLineColorMenuItem4.text
                           countRateData.countRateCurveColor=countRateLineColorMenuItem4.textColor
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:countRateLineColorMenuItem5
                       text:qsTr("可选色四")
                       textColor:"#00a1ea"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:countRateData.countRateCurveColor==countRateLineColorMenuItem5.textColor?true:false
                       onTriggered: {
                           countRateLineColor.text=countRateLineColorMenuItem5.text
                           countRateData.countRateCurveColor=countRateLineColorMenuItem5.textColor
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   onOpened: countRateLineColor.imageSource="../icons/up.png"
                   onClosed: {countRateLineColor.imageSource="../icons/down.png";countRateLineColor.forceActiveFocus();}

               }

               RLSConfigMenu{
                   id:curveLineStyleMenu
                  // parent:countRatePopup
                   dim:true
                   modal:true
                   focus:false
                   transformOrigin : Popup.Bottom
                   y:parent.height-10-curveLineStyleMenu.height
                   x:parent.x+11
                   RLSConfigMenuItem{
                       id:menuItem1
                       text:qsTr("实线")
                       autoExclusive : true
                       checkable:true
                       checked: countRateData.lineCountRateCurveLineType==1?true:false
                       onTriggered: {
                           curveLineStyle.text=menuItem1.text
                           countRateData.lineCountRateCurveLineType=1
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:menuItem2
                       text:qsTr("虚线")
                       autoExclusive : true
                       checkable:true
                       checked: countRateData.lineCountRateCurveLineType==2?true:false
                       onTriggered: {
                           curveLineStyle.text=menuItem2.text
                           countRateData.lineCountRateCurveLineType=2
                           countRateData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   onOpened: curveLineStyle.imageSource="../icons/up.png"
                   onClosed:{ curveLineStyle.imageSource="../icons/down.png";curveLineStyle.forceActiveFocus();}
               }
           }
       }//countRatePopup
       RLSPopup{
           id:doseCurvePopup
           width:600
           height: 1014
           x:parent.width
           leftPadding: 1
           transformOrigin: Popup.TopLeft
           Rectangle{
               id:doseCurvePopupConent
               anchors.fill: parent
               color:RLSTheme.backgroundColor.C6
               GridLayout{
                     id:doseCurvePopupGridLayout
                     anchors.left: parent.left
                     anchors.leftMargin: 20
                     width:560
                     columns: 2
                     rowSpacing: 22
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("是否显示")
                     }
                     RLSSwitch{
                         id:doseCurveDisplay
                         checked: basicConfig.doseCurveDisplay
                         anchors.right: parent.right
                         onClicked: {
                              basicConfig.doseCurveDisplay=doseCurveDisplay.checked;
                              basicConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线颜色")
                     }
                     RLSTextField{
                         id:doseCurveLineColor
                         Layout.preferredWidth:370
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         readOnly: true
                         color:data.doseCurveColor
                         //placeholderText :doseCurveLineColor.activeFocus?"": data.doseCurveColor
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:doseCurveLineColorMenu.open()
                         Component.onCompleted: function initText(){
                             if(data.doseCurveColor=="#68b5ae")
                                doseCurveLineColor.text="默认"
                             if(data.doseCurveColor=="#fff200")
                                doseCurveLineColor.text="可选色一"
                             if(data.doseCurveColor=="#019f43")
                                doseCurveLineColor.text="可选色二"
                             if(data.doseCurveColor=="#e60111")
                                doseCurveLineColor.text="可选色三"
                             if(data.doseCurveColor=="#00a1ea")
                                doseCurveLineColor.text="可选色四"
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线宽度")
                     }
                     RowLayout{
                         anchors.right: parent.right
                         spacing: 20
                         RLSSlider{
                             id:doseCurveLineWidth
                             from:0.5
                             to:2.0
                             value:data.doseCurveWidth
                             stepSize :0.1
                             snapMode:Slider.SnapOnRelease
                             Layout.preferredWidth : 370

                            // anchors.right: parent.right
                             onValueChanged: {
                                 data.doseCurveWidth=doseCurveLineWidth.value.toFixed(1)
                                 data.updateAllConfig()
                                 tips.open("设置已保存！！")
                             }
                         }
                         RLSConfigLabel{
                             id:doseCurveLineWidthLabel
                             text:doseCurveLineWidth.value.toFixed(1)+"   px"
                         }
                     }

                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线风格")
                     }
                     RLSTextField{
                         id:doseCurveLineStyle
                          Layout.preferredWidth:370
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          readOnly: true
                          color:RLSTheme.textColor.C10
                         //placeholderText : basicConfig.imageSize
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:doseurveLineStyleMenu.open()
                         Component.onCompleted: function initText(){
                             switch(data.lineDoseCurveLineType){
                             case 1:
                                 doseCurveLineStyle.text="实线"
                                 break;
                             case 2:
                                 doseCurveLineStyle.text="虚线"
                                 break;
                             }
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
               }

               RLSConfigMenu{
                   id:doseCurveLineColorMenu
                   dim:true
                   modal:true
                    focus:false
                   transformOrigin: Popup.Bottom
                   x:parent.x+11
                   y:parent.height-10-doseCurveLineColorMenu.height
                   RLSConfigMenuItem{
                       id:doseCurveLineColorMenuItem1
                       text:qsTr("默认")
                       textColor: "#68b5ae"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:data.doseCurveColor==doseCurveLineColorMenuItem1.textColor?true:false
                       onTriggered: {
                           doseCurveLineColor.text=doseCurveLineColorMenuItem1.text
                           data.doseCurveColor=doseCurveLineColorMenuItem1.textColor
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:doseCurveLineColorMenuItem2
                       text:qsTr("可选色一")
                       isColorSelect: true
                       textColor: "#fff200"
                       autoExclusive : true
                       checkable:true
                       checked:data.doseCurveColor==doseCurveLineColorMenuItem2.textColor?true:false
                       onTriggered: {
                           doseCurveLineColor.text=doseCurveLineColorMenuItem2.text
                           data.doseCurveColor=doseCurveLineColorMenuItem2.textColor
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:doseCurveLineColorMenuItem3
                       text:qsTr("可选色二")
                       textColor: "#019f43"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:data.doseCurveColor==doseCurveLineColorMenuItem3.textColor?true:false
                       onTriggered: {
                           doseCurveLineColor.text=doseCurveLineColorMenuItem3.text
                           data.doseCurveColor=doseCurveLineColorMenuItem3.textColor
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:doseCurveLineColorMenuItem4
                       text:qsTr("可选色三")
                       textColor: "#e60111"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:data.doseCurveColor==doseCurveLineColorMenuItem4.textColor?true:false
                       onTriggered: {
                           doseCurveLineColor.text=doseCurveLineColorMenuItem4.text
                           data.doseCurveColor=doseCurveLineColorMenuItem4.textColor
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:doseCurveLineColorMenuItem5
                       text:qsTr("可选色四")
                       textColor:"#00a1ea"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:data.doseCurveColor==doseCurveLineColorMenuItem5.textColor?true:false
                       onTriggered: {
                           doseCurveLineColor.text=doseCurveLineColorMenuItem5.text
                           data.doseCurveColor=doseCurveLineColorMenuItem5.textColor
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   onOpened: doseCurveLineColor.imageSource="../icons/up.png"
                   onClosed: {doseCurveLineColor.imageSource="../icons/down.png";doseCurveLineColor.forceActiveFocus();}

               }
               RLSConfigMenu{
                   id:doseurveLineStyleMenu
                  // parent:countRatePopup
                   dim:true
                   modal:true
                   focus:false
                   transformOrigin : Popup.Bottom
                   y:parent.height-10-doseurveLineStyleMenu.height
                   x:parent.x+11
                   RLSConfigMenuItem{
                       id:menuItem4
                       text:qsTr("实线")
                       autoExclusive : true
                       checkable:true
                       checked: data.lineDoseCurveLineType==1?true:false
                       onTriggered: {
                           doseCurveLineStyle.text=menuItem4.text
                           data.lineDoseCurveLineType=1
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:menuItem5
                       text:qsTr("虚线")
                       autoExclusive : true
                       checkable:true
                       checked: data.lineDoseCurveLineType==2?true:false
                       onTriggered: {
                           doseCurveLineStyle.text=menuItem5.text
                           data.lineDoseCurveLineType=2
                           data.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   onOpened: doseCurveLineStyle.imageSource="../icons/up.png"
                   onClosed: {doseCurveLineStyle.imageSource="../icons/down.png";doseCurveLineStyle.forceActiveFocus();}
               }



           }//doseCurvePopupConent
       }
       RLSPopup{
           id:reallySpectralCurvePopup
           width:600
           height: 1014
           x:parent.width
           leftPadding: 1
           transformOrigin: Popup.TopLeft
           Rectangle{
               id:reallySpectralCurvePopupConent
               color:RLSTheme.backgroundColor.C6
               anchors.fill: parent
               GridLayout{
                     id:reallySpectralCurvePopupGridLayout
                     anchors.left: parent.left
                     anchors.leftMargin: 20
                     width:560
                     columns: 2
                     rowSpacing: 22
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("是否显示")
                     }
                     RLSSwitch{
                         id:reallySpectralCurveDisplay
                         checked: basicConfig.reallySpectralCurveDisplay
                         anchors.right: parent.right
                         onClicked: {
                              basicConfig.reallySpectralCurveDisplay=reallySpectralCurveDisplay.checked;
                              basicConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线颜色")
                     }
                     RLSTextField{
                         id:reallySpectralCurveColor
                         Layout.preferredWidth:370
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         readOnly: true
                         color:energyCurveData.reallySpectralCurveColor
                         placeholderText :doseCurveLineColor.activeFocus?"": energyCurveData.reallySpectralCurveColor
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:reallySpectralCurveColorMenu.open()
                         Component.onCompleted: function initText(){
                             if(energyCurveData.reallySpectralCurveColor=="#68b5ae")
                                reallySpectralCurveColor.text="默认"
                             if(energyCurveData.reallySpectralCurveColor=="#fff200")
                                reallySpectralCurveColor.text="可选色一"
                             if(energyCurveData.reallySpectralCurveColor=="#019f43")
                                reallySpectralCurveColor.text="可选色二"
                             if(energyCurveData.reallySpectralCurveColor=="#e60111")
                                reallySpectralCurveColor.text="可选色三"
                             if(energyCurveData.reallySpectralCurveColor=="#00a1ea")
                                reallySpectralCurveColor.text="可选色四"
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线宽度")
                     }

                     RowLayout{
                         anchors.right: parent.right
                         spacing: 20
                         RLSSlider{
                             id:reallySpectralCurveLineWidth
                             from:0.5
                             to:2.0
                             value:energyCurveData.reallySpectralCurveWidth
                             stepSize :0.1
                             snapMode:Slider.SnapOnRelease
                             Layout.preferredWidth : 370
                            // anchors.right: parent.right
                             onValueChanged: {
                                 energyCurveData.reallySpectralCurveWidth=reallySpectralCurveLineWidth.value.toFixed(1)
                                 energyCurveData.updateAllConfig()
                                 tips.open("设置已保存！！")
                             }
                         }
                         RLSConfigLabel{
                             id:reallySpectralCurveLineWidthLabel
                             text:reallySpectralCurveLineWidth.value.toFixed(1)+"   px"
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("曲线风格")
                     }
                     RLSTextField{
                         id:reallySpectralCurveLineStyle
                          Layout.preferredWidth:370
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          readOnly: true
                          color:RLSTheme.textColor.C10
                         //placeholderText : energyCurveData.lineReallySpectralCurveLineType
                         cursorVisible: false
                         imageSource:"../icons/down.png"
                         anchors.right: parent.right
                         onPopupOpen:reallySpectralCurveLineStyleMenu.open()
                         Component.onCompleted: function initText(){
                             switch(energyCurveData.lineReallySpectralCurveLineType){

                             case 1:
                                 reallySpectralCurveLineStyle.text="实线"
                                 break;
                             case 2:
                                 reallySpectralCurveLineStyle.text="虚线"
                                 break;
                             }
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("X轴的范围")
                     }
                     RowLayout{
                         spacing: 20
                         anchors.right: parent.right
                         RLSConfigTextInput{
                             id:reallyCurveXLow
                             validator: IntValidator{bottom: 0; top: 1500;}
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.label: reallyCurveXLow.text
                             placeholderText :reallyCurveXLow.activeFocus?"":energyCurveData.reallyCurveXLow
                             EnterKeyAction.actionId:EnterKeyAction.Next
                             EnterKeyAction.enabled:reallyCurveXLow.length>0||reallyCurveXLow.inputMethodComposing?true:false
                             onEnterKeyClicked: {
                                 reallyCurveXLow.focus=false
                                 energyCurveData.reallyCurveXLow=reallyCurveXLow.text;
                                 energyCurveData.updateAllConfig();
                                 tips.open(qsTr("设置已保存"));
                             }

                         }
                         RLSConfigLabel{
                             text:qsTr("  ~  ")
                         }
                         RLSConfigTextInput{
                             id:reallyCurveXHigh
                             validator: IntValidator{bottom: 0; top: 1500;}
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             inputMethodHints: Qt.ImhDigitsOnly
                             placeholderText :reallyCurveXHigh.activeFocus?"":energyCurveData.reallyCurveXHigh
                             EnterKeyAction.actionId:EnterKeyAction.Next
                             EnterKeyAction.enabled:reallyCurveXHigh.length>0||reallyCurveXHigh.inputMethodComposing?true:false
                             onEnterKeyClicked: {
                                 reallyCurveXHigh.focus=false
                                 energyCurveData.reallyCurveXHigh=reallyCurveXHigh.text;
                                 energyCurveData.updateAllConfig();
                                 tips.open(qsTr("设置已保存"));
                             }

                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("Y轴是否更新")
                     }
                     RLSSwitch{


                         id:reallyCurveYAutoUpdate
                         checked: energyCurveData.reallyCurveYAutoUpdate
                         anchors.right: parent.right
                         onClicked: {
                            energyCurveData.reallyCurveYAutoUpdate=reallyCurveYAutoUpdate.checked
                            energyCurveData.updateAllConfig()
                            tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }
                     RLSConfigLabel{
                         text:qsTr("Y轴的范围")
                     }
                     RowLayout{
                         spacing: 20
                         anchors.right: parent.right
                         RLSConfigTextInput{
                             id:reallyCurveYLow
                             validator: IntValidator{bottom: 0; top: 1500;}
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             inputMethodHints: Qt.ImhDigitsOnly
                             placeholderText :reallyCurveYLow.activeFocus?"":energyCurveData.reallyCurveYLow
                             EnterKeyAction.actionId:EnterKeyAction.Next
                             EnterKeyAction.label: "Next"
                             EnterKeyAction.enabled:reallyCurveYLow.length>0||reallyCurveYLow.inputMethodComposing?true:false
                             onEnterKeyClicked: {
                                 reallyCurveYLow.focus=false
                                 energyCurveData.reallyCurveYLow=reallyCurveYLow.text;
                                 energyCurveData.updateAllConfig();
                                 tips.open(qsTr("设置已保存"));
                             }

                         }
                         RLSConfigLabel{
                             text:qsTr("~")
                         }
                         RLSConfigTextInput{
                             id:reallyCurveYHigh
                             validator: IntValidator{bottom: 0; top: 1500;}
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             inputMethodHints: Qt.ImhDigitsOnly
                             placeholderText :reallyCurveYHigh.activeFocus?"":energyCurveData.reallyCurveYHigh
                             EnterKeyAction.actionId:EnterKeyAction.Next
                             EnterKeyAction.label: "Next"
                             EnterKeyAction.enabled:reallyCurveYHigh.length>0||reallyCurveYHigh.inputMethodComposing?true:false
                             onEnterKeyClicked: {
                                 reallyCurveYHigh.focus=false
                                 energyCurveData.reallyCurveYHigh=reallyCurveYHigh.text;
                                 energyCurveData.updateAllConfig();
                                 tips.open(qsTr("设置已保存"));
                             }

                         }
                     }
                     RLSConfigSeparate{
                          Layout.columnSpan: 2
                     }

               }

               RLSConfigMenu{
                   id:reallySpectralCurveColorMenu
                   dim:true
                   modal:true
                    focus:false
                   transformOrigin: Popup.Bottom
                   x:parent.x+11
                   y:parent.height-10-reallySpectralCurveColorMenu.height
                   RLSConfigMenuItem{
                       id:reallySpectralCurveColorMenuItem1
                       text:qsTr("默认")
                       textColor: "#68b5ae"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:energyCurveData.reallySpectralCurveColor==reallySpectralCurveColorMenuItem1.textColor?true:false
                       onTriggered: {
                           reallySpectralCurveColor.text=reallySpectralCurveColorMenuItem1.text
                           energyCurveData.reallySpectralCurveColor=reallySpectralCurveColorMenuItem1.textColor
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:reallySpectralCurveColorMenuItem2
                       text:qsTr("可选色一")
                       isColorSelect: true
                       textColor: "#fff200"
                       autoExclusive : true
                       checkable:true
                       checked:energyCurveData.reallySpectralCurveColor==reallySpectralCurveColorMenuItem2.textColor?true:false
                       onTriggered: {
                           reallySpectralCurveColor.text=reallySpectralCurveColorMenuItem2.text
                           energyCurveData.reallySpectralCurveColor=reallySpectralCurveColorMenuItem2.textColor
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:reallySpectralCurveColorMenuItem3
                       text:qsTr("可选色二")
                       textColor: "#019f43"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:energyCurveData.reallySpectralCurveColor==reallySpectralCurveColorMenuItem3.textColor?true:false
                       onTriggered: {
                           reallySpectralCurveColor.text=reallySpectralCurveColorMenuItem3.text
                           energyCurveData.reallySpectralCurveColor=reallySpectralCurveColorMenuItem3.textColor
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:reallySpectralCurveColorMenuItem4
                       text:qsTr("可选色三")
                       textColor: "#e60111"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:energyCurveData.reallySpectralCurveColor==reallySpectralCurveColorMenuItem4.textColor?true:false
                       onTriggered: {
                           reallySpectralCurveColor.text=reallySpectralCurveColorMenuItem4.text
                           energyCurveData.reallySpectralCurveColor=reallySpectralCurveColorMenuItem4.textColor
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:reallySpectralCurveColorMenuItem5
                       text:qsTr("可选色四")
                       textColor:"#00a1ea"
                       isColorSelect: true
                       autoExclusive : true
                       checkable:true
                       checked:energyCurveData.reallySpectralCurveColor==reallySpectralCurveColorMenuItem5.textColor?true:false
                       onTriggered: {
                           reallySpectralCurveColor.text=reallySpectralCurveColorMenuItem5.text
                           energyCurveData.reallySpectralCurveColor=reallySpectralCurveColorMenuItem5.textColor
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   onOpened: reallySpectralCurveColor.imageSource="../icons/up.png"
                   onClosed: {reallySpectralCurveColor.imageSource="../icons/down.png";reallySpectralCurveColor.forceActiveFocus();}

               }

               RLSConfigMenu{
                   id:reallySpectralCurveLineStyleMenu
                  // parent:countRatePopup
                   dim:true
                   modal:true
                   transformOrigin : Popup.Bottom
                   y:parent.height-10-reallySpectralCurveLineStyleMenu.height
                   x:parent.x+11
                   RLSConfigMenuItem{
                       id:menuItem7
                       text:qsTr("实线")
                       autoExclusive : true
                       checkable:true
                       checked: energyCurveData.lineReallySpectralCurveLineType==1?true:false
                       onTriggered: {
                           reallySpectralCurveLineStyle.text=menuItem7.text
                           energyCurveData.lineReallySpectralCurveLineType=1
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }
                   RLSConfigMenuItem{
                       id:menuItem8
                       text:qsTr("虚线")
                       autoExclusive : true
                       checkable:true
                       checked: energyCurveData.lineReallySpectralCurveLineType==2?true:false
                       onTriggered: {
                           reallySpectralCurveLineStyle.text=menuItem8.text
                           energyCurveData.lineReallySpectralCurveLineType=2
                           energyCurveData.updateAllConfig()
                           tips.open("设置已保存！！")
                           }
                   }                  
                   onOpened: reallySpectralCurveLineStyle.imageSource="../icons/up.png"
                   onClosed: {reallySpectralCurveLineStyle.imageSource="../icons/down.png";reallySpectralCurveLineStyle.forceActiveFocus();}
               }

           }//reallySpectralCurvePopupConent
           InputPanel {
               id:reallySpectralCurveSetting
               z: 99
               y: reallySpectralCurvePopup.height
               width:parent.width
               //anchors.left: parent.left
               //anchors.right: parent.right
               states: State {
                   name: "visible"
                   /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                       but then the handwriting input panel and the keyboard input panel can be visible
                       at the same time. Here the visibility is bound to InputPanel.active property instead,
                       which allows the handwriting panel to control the visibility when necessary.
                   */
                   when: reallySpectralCurveSetting.active
                   PropertyChanges {
                       target: reallySpectralCurveSetting
                       y: reallySpectralCurvePopup.height - reallySpectralCurveSetting.height
                   }
               }
               transitions: Transition {
                   from: ""
                   to: "visible"
                   reversible: true
                   ParallelAnimation {
                       NumberAnimation {
                           properties: "y"
                           duration: 250
                           easing.type: Easing.InOutQuad
                       }
                   }
               }
           }
       }
    }
 }
//////////////////////////////=!warmingConfig!=//////////////////

    Component{
        id:warmingView
        Rectangle{
            id:warmingViewContent
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
            BasicConfig{
                id:basicConfig
            }
            ColumnLayout{
                spacing:0
                RLSConfigButton{
                    id:radioactivityWarming
                    text:qsTr("报警模式参数")
                    checkable: true
                    autoExclusive : true
                    onClicked:radioactivityWarmingPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
                RLSConfigButton{
                    id:hardDiskWarming
                    text:qsTr("硬盘报警")
                    checkable: true
                    autoExclusive : true
                    onClicked:hardDiskWarmingPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
                RLSConfigButton{
                    id:temperatureWarming
                    text:qsTr("温度报警")
                    checkable: true
                    autoExclusive : true
                   onClicked: temperatureWarmingPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
            }

            RLSPopup{
                id:hardDiskWarmingPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    id:hardDiskWarmingPopupConent
                    color:RLSTheme.backgroundColor.C6
                    anchors.fill: parent
                    GridLayout{
                          id:hardDiskWarmingPopupGridLayout
                          anchors.left: parent.left
                          anchors.leftMargin: 20
                          width:560
                          columns: 2
                          rowSpacing: 22

                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          Text{
                               text:qsTr("高等级报警")
                               Layout.columnSpan: 2
                               font.family: RLSTheme.fontFamily
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("空间不足")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                   id:firstLevelFreeSizeLow
                                    validator: IntValidator{bottom: 0; top: 10000;}
                                   font.family: RLSTheme.fontFamily
                                   font.pixelSize: RLSTheme.fontSize.F3
                                   placeholderText :firstLevelFreeSizeLow.activeFocus?"":basicConfig.diskFreeSizeLowWarningThreshold
                                   inputMethodHints: Qt.ImhDigitsOnly
                                   EnterKeyAction.actionId:EnterKeyAction.Next
                                   EnterKeyAction.label: "Next"
                                   EnterKeyAction.enabled:firstLevelFreeSizeLow.length>0||firstLevelFreeSizeLow.inputMethodComposing?true:false
                                   onEnterKeyClicked:{

                                       if(Number(firstLevelFreeSizeLow.text)>= basicConfig.diskFreeSizeHighWarningThreshold)
                                       {
                                           tips.open(qsTr("高等级报警的空间剩余必须大于低等级报警！！"))
                                           firstLevelFreeSizeLow.clear()
                                       }else{
                                           firstLevelFreeSizeLow.focus=false
                                           basicConfig.diskFreeSizeLowWarningThreshold=Number(firstLevelFreeSizeLow.text)
                                           basicConfig.updateAllConfig()
                                           tips.open("设置已保存！！")
                                       }


                                   }
                              }
                              RLSConfigLabel{
                                  text:qsTr("GB")
                              }
                         }

                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("报警后是否自动清空硬盘")
                          }
                          RLSSwitch{
                              id:isAutoClearDisk
                              checked: basicConfig.autoClearDisk
                              anchors.right: parent.right
                              onClicked: {
                                 basicConfig.autoClearDisk=isAutoClearDisk.checked
                                 basicConfig.updateAllConfig()
                                 tips.open("设置已保存！！")
                              }
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }

                          Text{
                              text:qsTr("低等级报警")
                               Layout.columnSpan: 2
                               font.family: RLSTheme.fontFamily
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("空间不足")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                   id:secendLevelFreeSizeHigh
                                   validator: IntValidator{bottom: 0; top: 10000;}
                                   font.family: RLSTheme.fontFamily
                                   font.pixelSize: RLSTheme.fontSize.F3
                                   placeholderText :secendLevelFreeSizeHigh.activeFocus?"":basicConfig.diskFreeSizeHighWarningThreshold
                                   inputMethodHints: Qt.ImhDigitsOnly
                                   EnterKeyAction.actionId:EnterKeyAction.Next
                                   EnterKeyAction.label: "Next"
                                   EnterKeyAction.enabled:secendLevelFreeSizeHigh.length>0||secendLevelFreeSizeHigh.inputMethodComposing?true:false
                                   onEnterKeyClicked:{
                                       if(Number(secendLevelFreeSizeHigh.text)<basicConfig.diskFreeSizeLowWarningThreshold)
                                       {
                                           tips.open(qsTr("低等级报警的空间剩余必须小于高等级报警!!"))
                                          secendLevelFreeSizeHigh.clear()
                                       }else{
                                           secendLevelFreeSizeHigh.focus=false
                                           basicConfig.diskFreeSizeHighWarningThreshold=Number(secendLevelFreeSizeHigh.text)
                                           basicConfig.updateAllConfig()
                                           tips.open("设置已保存！！")
                                       }


                                   }
                              }
                              RLSConfigLabel{
                                  text:qsTr("GB")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                    }
                }
                InputPanel {
                    id: inputPanelDiskSetting
                    z: 99
                    y: hardDiskWarmingPopup.height
                    width:parent.width
                    //anchors.left: parent.left
                    //anchors.right: parent.right
                    states: State {
                        name: "visible"
                        /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                            but then the handwriting input panel and the keyboard input panel can be visible
                            at the same time. Here the visibility is bound to InputPanel.active property instead,
                            which allows the handwriting panel to control the visibility when necessary.
                        */
                        when: inputPanelDiskSetting.active
                        PropertyChanges {
                            target: inputPanelDiskSetting
                            y: hardDiskWarmingPopup.height - inputPanelDiskSetting.height
                        }
                    }
                    transitions: Transition {
                        from: ""
                        to: "visible"
                        reversible: true
                        ParallelAnimation {
                            NumberAnimation {
                                properties: "y"
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }

            RLSPopup{
                id:temperatureWarmingPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    id:temperatureWarmingPopupConent
                    color:RLSTheme.backgroundColor.C6
                    anchors.fill: parent
                    GridLayout{
                          id:temperatureWarmingPopupGridLayout
                          anchors.left: parent.left
                          anchors.leftMargin: 20
                          width:560
                          columns: 2
                          rowSpacing: 22
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("PMT低阈值")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                  id:temPMTMin
                                  validator: IntValidator{bottom: 0; top: 100;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  //text:basicConfig.temperaturePMTMin
                                  placeholderText :temPMTMin.activeFocus?"":basicConfig.temperaturePMTMin
                                   inputMethodHints: Qt.ImhDigitsOnly

                                  EnterKeyAction.actionId:EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:temPMTMin.length>0||temPMTMin.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      temPMTMin.focus=false
                                      basicConfig.temperaturePMTMin=Number(temPMTMin.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")

                                  }
                              }
                              RLSConfigLabel{
                                  text:qsTr("℃")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("PMT高阈值")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                  id:temPMTMax
                                   validator: IntValidator{bottom: 0; top: 100;}
                                  //text:basicConfig.temperaturePMTMax
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  placeholderText :temPMTMax.activeFocus?"":basicConfig.temperaturePMTMax
                                  inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:  EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:temPMTMax.length>0||temPMTMax.inputMethodComposing?true:false
                                  onEnterKeyClicked:
                                      {
                                      temPMTMax.focus=false
                                      basicConfig.temperaturePMTMax=Number(temPMTMax.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                      }
                              }
                              RLSConfigLabel{
                                  text:qsTr("℃")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("ADC低阈值")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                   id:temADCMin
                                    validator: IntValidator{bottom: 0; top: 100;}
                                   font.family: RLSTheme.fontFamily
                                   font.pixelSize: RLSTheme.fontSize.F3
                                   //text:basicConfig.temperatureADCMin
                                   placeholderText :temADCMin.activeFocus?"":basicConfig.temperatureADCMin
                                   inputMethodHints: Qt.ImhDigitsOnly
                                   EnterKeyAction.actionId:  EnterKeyAction.Next
                                   EnterKeyAction.label: "Next"
                                   EnterKeyAction.enabled:temADCMin.length>0||temADCMin.inputMethodComposing?true:false
                                   onEnterKeyClicked:{
                                       temADCMin.focus=false
                                       basicConfig.temperatureADCMin=Number(temADCMin.text)
                                       basicConfig.updateAllConfig()
                                       tips.open("设置已保存！！")                                    
                                   }
                              }
                              RLSConfigLabel{
                                  text:qsTr("℃")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("ADC高阈值")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                  id:temADCMax
                                  validator: IntValidator{bottom: 0; top: 100;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  //text:basicConfig.temperatureADCMax
                                  placeholderText :temADCMax.activeFocus?"":basicConfig.temperatureADCMax
                                  inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:  EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:temADCMax.length>0||temADCMax.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      temADCMax.focus=false
                                      basicConfig.temperatureADCMax=Number(temADCMax.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                  }
                              }

                              RLSConfigLabel{
                                  text:qsTr("℃")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }


                    }
                }
                InputPanel {
                    id:inputPanelTemSetting
                    z: 99
                    y: temperatureWarmingPopup.height
                    width:parent.width
                    //anchors.left: parent.left
                    //anchors.right: parent.right
                    states: State {
                        name: "visible"
                        /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                            but then the handwriting input panel and the keyboard input panel can be visible
                            at the same time. Here the visibility is bound to InputPanel.active property instead,
                            which allows the handwriting panel to control the visibility when necessary.
                        */
                        when: inputPanelTemSetting.active
                        PropertyChanges {
                            target: inputPanelTemSetting
                            y: temperatureWarmingPopup.height - inputPanelTemSetting.height
                        }
                    }
                    transitions: Transition {
                        from: ""
                        to: "visible"
                        reversible: true
                        ParallelAnimation {
                            NumberAnimation {
                                properties: "y"
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }


            RLSPopup{
                id:radioactivityWarmingPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    id:radioactivityWarmingPopupConent
                    color:RLSTheme.backgroundColor.C6
                    anchors.fill: parent
                    GridLayout{
                          id:radioactivityWarmingPopupGridLayout
                          anchors.left: parent.left
                          anchors.leftMargin: 20
                          width:560
                          columns: 2
                          rowSpacing: 22
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("模式设置")
                          }
                          RLSTextField{
                              Layout.preferredWidth: 370
                              placeholderText : qsTr("自定义模式")
                              cursorVisible: false
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: 18
                              readOnly: true
                              enabled: false
                              anchors.right: parent.right
                              //onPopupOpen:customCountRateTypeMenu.open()
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("计数率模式")
                          }
                          RLSTextField{
                              id:customCountRateType
                              Layout.preferredWidth: 370
                              //placeholderText : basicConfig.customCountRateType
                              cursorVisible: false
                              imageSource:"../icons/down.png"
                              anchors.right: parent.right
                              readOnly: true
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              onPopupOpen:customCountRateTypeMenu.open()
                              Component.onCompleted: function initText(){
                                  switch(basicConfig.customCountRateType)
                                  {
                                  case 0:
                                      customCountRateType.text=qsTr("实时计数率");break;
                                  case 1:
                                      customCountRateType.text=qsTr("平均计数率");break;
                                  case 2:
                                      customCountRateType.text=qsTr("全部计数率");break;
                                  }
                              }
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("报警计数率")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                   validator: IntValidator{bottom: 0; top: 10000000;}
                                  id:customWarningCountRate
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  placeholderText :customWarningCountRate.activeFocus?"":basicConfig.customWarningCountRate
                                  inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:  EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:customWarningCountRate.length>0||customWarningCountRate.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      customWarningCountRate.focus=false
                                      basicConfig.customWarningCountRate=Number(customWarningCountRate.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                  }
                              }
                              RLSConfigLabel{
                                  text:qsTr("个/秒")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("定位计数率")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                  id:customTrackCountRate
                                  validator: IntValidator{bottom: 0; top: 10000000;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  placeholderText :customTrackCountRate.activeFocus?"":basicConfig.customTrackCountRate
                                   inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:  EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:customTrackCountRate.length>0||customTrackCountRate.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      customTrackCountRate.focus=false
                                      basicConfig.customTrackCountRate=Number(customTrackCountRate.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                  }

                              }
                              RLSConfigLabel{
                                  text:qsTr("个/秒")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("时间长度")
                          }
                          RowLayout{
                              spacing: 6
                              anchors.right: parent.right
                              RLSConfigTextInput{
                                  validator: IntValidator{bottom: 0; top: 3600000;}
                                  id:customWarningCountRateTime
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  enabled: basicConfig.customCountRateType?true:false
                                  placeholderText : customWarningCountRateTime.enabled?(customWarningCountRateTime.activeFocus?"":basicConfig.customWarningCountRateTime):""
                                   inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:  EnterKeyAction.Next
                                  EnterKeyAction.label: "Next"
                                  EnterKeyAction.enabled:customWarningCountRateTime.length>0||customWarningCountRateTime.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      customWarningCountRateTime.focus=false
                                      basicConfig.customWarningCountRateTime=Number(customWarningCountRateTime.text)
                                      basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                  }
                              }
                              RLSConfigLabel{
                                  text:qsTr("     秒")
                              }
                         }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                    }

                    RLSConfigMenu{
                        id:customCountRateTypeMenu
                        //parent:content
                        dim:true
                        modal:true
                        focus:false
                        transformOrigin : Popup.Bottom

                        y:parent.height-10-customCountRateTypeMenu.height
                        x:11
                        RLSConfigMenuItem{
                            id:menuItem1
                            text:qsTr("实时计数率")
                            autoExclusive : true
                            checkable:true
                            checked:basicConfig.customCountRateType==0?true:false
                            onTriggered:{
                                basicConfig.customCountRateType=0
                                tips.open("设置已保存！！")
                                customCountRateType.text=menuItem1.text
                                basicConfig.updateAllConfig()
                            }
                        }
                        RLSConfigMenuItem{
                             id:menuItem2
                            text:qsTr("平均计数率")
                            autoExclusive : true
                            checkable:true
                            checked:basicConfig.customCountRateType==1?true:false
                            onTriggered:{
                                basicConfig.customCountRateType=1
                                tips.open("设置已保存！！")
                                customCountRateType.text=menuItem2.text
                                basicConfig.updateAllConfig()

                            }
                        }
                        RLSConfigMenuItem{
                            id:menuItem3
                            text:qsTr("全部计数率")
                            autoExclusive : true
                            checkable:true
                            checked:basicConfig.customCountRateType==2?true:false
                            onTriggered:{
                                basicConfig.customCountRateType=2
                                tips.open("设置已保存！！")
                                customCountRateType.text=menuItem3.text
                                basicConfig.updateAllConfig()

                            }
                        }
                        onOpened: customCountRateType.imageSource="../icons/up.png"
                        onClosed: {customCountRateType.imageSource="../icons/down.png"; customCountRateType.forceActiveFocus();}
                    }

                }
                InputPanel {
                    id:radioactivityWarmingSetting
                    z: 99
                    y: radioactivityWarmingPopup.height
                    width:parent.width
                    //anchors.left: parent.left
                    //anchors.right: parent.right
                    states: State {
                        name: "visible"
                        /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                            but then the handwriting input panel and the keyboard input panel can be visible
                            at the same time. Here the visibility is bound to InputPanel.active property instead,
                            which allows the handwriting panel to control the visibility when necessary.
                        */
                        when: radioactivityWarmingSetting.active
                        PropertyChanges {
                            target: radioactivityWarmingSetting
                            y: radioactivityWarmingPopup.height - radioactivityWarmingSetting.height
                        }
                    }
                    transitions: Transition {
                        from: ""
                        to: "visible"
                        reversible: true
                        ParallelAnimation {
                            NumberAnimation {
                                properties: "y"
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

            }
      }//warmingViewContent
    }
///////////////////////////////////////=!positionView!=//////////
    Component{
        id:positionView
       Rectangle{
           id:positionViewContent
           width:600
           height:1014
           color:RLSTheme.backgroundColor.C6
           BasicConfig{
               id:basicConfig
           }
           ColumnLayout{
               spacing:0
               RLSConfigButton{
                   id:cameraPositionView
                   text:qsTr("摄像头")
                   checkable: true
                   autoExclusive : true
                  onClicked:cameraPositionViewPopup.open()
               }
               RLSConfigSeparate{
                   Layout.preferredWidth : parent.width
               }
               RLSConfigButton{
                   id:dectorPositionView
                   text:qsTr("探测器")
                   checkable: true
                   autoExclusive : true
                   onClicked:dectorPositionViewPopup.open()
               }
               RLSConfigSeparate{
                   Layout.preferredWidth : parent.width
           }
       }
           RLSPopup{
               id:cameraPositionViewPopup
               width:600
               height: 1014
               x:parent.width
               leftPadding: 1
               transformOrigin: Popup.TopLeft
               Rectangle{
                   id:cameraPositionViewPopupConent
                   color:RLSTheme.backgroundColor.C6
                   anchors.fill: parent
                   GridLayout{
                         id:cameraPositionViewPopupGridLayout
                         anchors.left: parent.left
                         anchors.leftMargin: 20
                         width:560
                         columns: 2
                         rowSpacing: 22
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("历史数据的存储方式")
                         }
                         RLSTextField{
                             id:historyDataSaveStyle
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             color:RLSTheme.textColor.C10
                             Layout.preferredWidth: 370
                             //placeholderText : historyDataSaveStyle.activeFocus?"":basicConfig.cameraSaveType
                             cursorVisible: false
                             readOnly: true
                             imageSource:"../icons/down.png"
                             anchors.right: parent.right
                             onPopupOpen:historyDataSaveStyleMenu.open()
                             Component.onCompleted: function initText(){
                                 switch(basicConfig.cameraSaveType)
                                 {
                                 case 0:
                                     historyDataSaveStyle.text=qsTr("不存储");break;
                                 case 1:
                                     historyDataSaveStyle.text=qsTr("全存储");break;
                                 case 2:
                                     historyDataSaveStyle.text=qsTr("仅在报警的时候存储");break;
                                 }
                             }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("流数据的存储方式")
                         }
                         RLSTextField{
                             id:streamDataSaveStyle
                             Layout.preferredWidth: 370
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             color:RLSTheme.textColor.C10
                             //placeholderText : basicConfig.cameraStoreByTime
                             cursorVisible: false
                             imageSource:"../icons/down.png"
                             anchors.right: parent.right
                             readOnly: true
                             onPopupOpen:streamDataSaveStyleMenu.open()
                             Component.onCompleted: function initText(){
                                 switch( basicConfig.cameraStoreByTime)
                                 {
                                 case true:
                                     streamDataSaveStyle.text=qsTr("按时存储");break;
                                 case false:
                                     streamDataSaveStyle.text=qsTr("按大小存储");break;

                             }
                         }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("存储间隔")
                         }
                         RLSTextField{
                             id:saveIntervalStyle
                             enabled: basicConfig.cameraStoreByTime
                             Layout.preferredWidth: 370
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             color:RLSTheme.textColor.C10
                             readOnly: true
                            // placeholderText : basicConfig.cameraStoreTimeInterval+"S"
                             cursorVisible: false
                             imageSource:"../icons/down.png"
                             anchors.right: parent.right
                             onPopupOpen:saveIntervalStyleMenu.open()
                             Component.onCompleted: function initText(){
                                 switch(basicConfig.cameraStoreTimeInterval)
                                 {
                                 case 60:
                                     saveIntervalStyle.text=qsTr("60 S");break;
                                 case 600:
                                     saveIntervalStyle.text=qsTr("600 S");break;
                                 case 1800:
                                     saveIntervalStyle.text=qsTr("1800 S");break;
                                 case 3600:
                                     saveIntervalStyle.text=qsTr("3600 S");break;
                             }
                          }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("存储大小")
                         }
                         RLSTextField{
                             id:saveSizeStyle
                             enabled:! basicConfig.cameraStoreByTime
                             Layout.preferredWidth: 370
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             color:RLSTheme.textColor.C10
                             readOnly: true
                            // placeholderText : basicConfig.cameraStoreSizeInterval+"M"
                             cursorVisible: false
                             imageSource:"../icons/down.png"
                             anchors.right: parent.right
                             onPopupOpen:saveSizeStyleMenu.open()
                             Component.onCompleted: function initText(){

                                 switch(basicConfig.cameraStoreSizeInterval)
                                 {
                                 case 100:
                                     saveSizeStyle.text=qsTr("100 M");break;
                                 case 200:
                                     saveSizeStyle.text=qsTr("200 M");break;
                                 case 500:
                                     saveSizeStyle.text=qsTr("500 M");break;
                                 case 1000:
                                     saveSizeStyle.text=qsTr("1000 M");break;
                                 }
                             }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("报警后是否自动清空硬盘")

                         }
                         RLSSwitch{
                             id:cameraSynchronization
                             anchors.right: parent.right
                             checked: basicConfig.cameraSynchronization
                             onClicked: {
                                 basicConfig.cameraSynchronization=cameraSynchronization.checked
                                 basicConfig.updateAllConfig()
                                 tips.open("设置已保存！！")
                             }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("同步周期")
                         }
                         RLSTextField{
                             id:synchronizeTime
                             Layout.preferredWidth: 370
                             font.family: RLSTheme.fontFamily
                             font.pixelSize: RLSTheme.fontSize.F3
                             color:RLSTheme.textColor.C10
                             readOnly: true
                            // placeholderText : basicConfig.cameraSynchronizationCycle==1?basicConfig.cameraSynchronizationCycle+"S":basicConfig.cameraSynchronizationCycle+"H"
                             cursorVisible: false
                             imageSource:"../icons/down.png"
                             anchors.right: parent.right
                             onPopupOpen:synchronizeTimeMenu.open()
                             Component.onCompleted: function initText(){

                                 switch(basicConfig.cameraSynchronizationCycle)
                                 {
                                 case 1:
                                     synchronizeTime.text=qsTr("1 S");break;
                                 case 2:
                                     synchronizeTime.text=qsTr("2 H");break;
                                 case 6:
                                     synchronizeTime.text=qsTr("6 H");break;
                                 case 12:
                                     synchronizeTime.text=qsTr("12 H");break;
                                 case 24:
                                     synchronizeTime.text=qsTr("24 H");break;
                                 }
                             }
                         }
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                   }

                   RLSConfigMenu{
                       id:historyDataSaveStyleMenu
                      // parent:countRatePopup
                       dim:true
                       modal:true
                       focus:false
                       transformOrigin : Popup.Bottom
                       y:parent.height-10-historyDataSaveStyleMenu.height
                       x:parent.x+11
                       RLSConfigMenuItem{
                           id:menuItem1
                           text:qsTr("不存储")
                           autoExclusive : true
                           checkable:true
                           checked:basicConfig.cameraSaveType==0?true:false
                           onTriggered: {
                               historyDataSaveStyle.text=menuItem1.text
                               basicConfig.cameraSaveType=0;
                               basicConfig.updateAllConfig();
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem2
                           text:qsTr("仅在报警的时候存储")
                           autoExclusive : true
                           checkable:true
                           checked:basicConfig.cameraSaveType==2?true:false
                           onTriggered: {
                               historyDataSaveStyle.text=menuItem2.text
                               basicConfig.cameraSaveType=2;
                               basicConfig.updateAllConfig();
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem3
                           text:qsTr("全存储")
                           autoExclusive : true
                           checkable:true
                           checked:basicConfig.cameraSaveType==1?true:false
                           onTriggered: {
                               historyDataSaveStyle.text=menuItem3.text
                               basicConfig.cameraSaveType=1;
                               basicConfig.updateAllConfig();
                               tips.open("设置已保存！！")
                               }
                       }
                       onOpened: historyDataSaveStyle.imageSource="../icons/up.png"
                       onClosed: {historyDataSaveStyle.imageSource="../icons/down.png";historyDataSaveStyle.forceActiveFocus();}
                   }
                   RLSConfigMenu{
                       id:streamDataSaveStyleMenu
                      // parent:countRatePopup
                       dim:true
                       modal:true
                       focus:false
                       transformOrigin : Popup.Bottom
                       y:parent.height-10-streamDataSaveStyleMenu.height
                       x:parent.x+11
                       RLSConfigMenuItem{
                           id:menuItem4
                           text:qsTr("按时存储")
                           autoExclusive : true
                           checkable:true
                           checked:basicConfig.cameraStoreByTime
                           onTriggered: {
                               streamDataSaveStyle.text=menuItem4.text
                               basicConfig.cameraStoreByTime=true;
                               basicConfig.updateAllConfig();
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem5
                           text:qsTr("按大小存储")
                           autoExclusive : true
                           checkable:true
                           checked: !basicConfig.cameraStoreByTime
                           onTriggered: {
                               streamDataSaveStyle.text=menuItem5.text
                               basicConfig.cameraStoreByTime=false;
                               basicConfig.updateAllConfig();
                               tips.open("设置已保存！！")
                               }
                       }
                       onOpened: streamDataSaveStyle.imageSource="../icons/up.png"
                       onClosed: {streamDataSaveStyle.imageSource="../icons/down.png";streamDataSaveStyle.forceActiveFocus();}
                   }

                   RLSConfigMenu{
                       id:saveIntervalStyleMenu
                      // parent:countRatePopup
                       dim:true
                       modal:true
                       focus:false
                       transformOrigin : Popup.Bottom
                       y:parent.height-10-saveIntervalStyleMenu.height
                       x:parent.x+11
                       RLSConfigMenuItem{
                           id:menuItem6
                           text:qsTr("60 S")
                           autoExclusive : true
                           checkable:true
                           checked: basicConfig.cameraStoreTimeInterval==60?true:false
                           onTriggered: {
                               saveIntervalStyle.text=menuItem6.text
                               basicConfig.cameraStoreTimeInterval=60
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem7
                           text:qsTr("600 S")
                           autoExclusive : true
                           checkable:true
                           checked: basicConfig.cameraStoreTimeInterval==600?true:false
                           onTriggered: {
                               saveIntervalStyle.text=menuItem7.text
                               basicConfig.cameraStoreTimeInterval=600
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem8
                           text:qsTr("1800 S")
                           autoExclusive : true
                           checkable:true
                           checked: basicConfig.cameraStoreTimeInterval==1800?true:false
                           onTriggered: {
                               saveIntervalStyle.text=menuItem8.text
                               basicConfig.cameraStoreTimeInterval=1800
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem9
                           text:qsTr("3600 S")
                           autoExclusive : true
                           checkable:true
                           checked: basicConfig.cameraStoreTimeInterval==3600?true:false
                           onTriggered: {
                               saveIntervalStyle.text=menuItem9.text
                               basicConfig.cameraStoreTimeInterval=3600
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       onOpened: saveIntervalStyle.imageSource="../icons/up.png"
                       onClosed: {saveIntervalStyle.imageSource="../icons/down.png";
                                 saveIntervalStyle.forceActiveFocus();
                       }
                   }

                   RLSConfigMenu{
                       id:saveSizeStyleMenu
                      // parent:countRatePopup
                       dim:true
                       modal:true
                       focus:false
                       transformOrigin : Popup.Bottom
                       y:parent.height-10-saveSizeStyleMenu.height
                       x:parent.x+11
                       RLSConfigMenuItem{
                           id:menuItem10
                           text:qsTr("100 M")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraStoreSizeInterval==100?true:false
                           onTriggered: {
                               saveSizeStyle.text=menuItem10.text
                               basicConfig.cameraStoreSizeInterval=100
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem11
                           text:qsTr("200 M")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraStoreSizeInterval==200?true:false
                           onTriggered: {
                               saveSizeStyle.text=menuItem11.text
                               basicConfig.cameraStoreSizeInterval=200
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem12
                           text:qsTr("500 M")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraStoreSizeInterval==500?true:false
                           onTriggered: {
                               saveSizeStyle.text=menuItem12.text
                               basicConfig.cameraStoreSizeInterval=500
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem13
                           text:qsTr("1000 M")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraStoreSizeInterval==1000?true:false
                           onTriggered: {
                               saveSizeStyle.text=menuItem13.text
                               basicConfig.cameraStoreSizeInterval=1000
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       onOpened: saveSizeStyle.imageSource="../icons/up.png"
                       onClosed:{ saveSizeStyle.imageSource="../icons/down.png";saveSizeStyle.forceActiveFocus();}
                   }


                   RLSConfigMenu{
                       id:synchronizeTimeMenu
                      // parent:countRatePopup
                       dim:true
                       modal:true
                       focus:false
                       transformOrigin : Popup.Bottom
                       y:parent.height-10-synchronizeTimeMenu.height
                       x:parent.x+11
                       RLSConfigMenuItem{
                           id:menuItem14
                           text:qsTr("1 S")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraSynchronizationCycle==1?true:false
                           onTriggered: {
                               synchronizeTime.text=menuItem14.text
                               basicConfig.cameraSynchronizationCycle=1
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem15
                           text:qsTr("2 H")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraSynchronizationCycle==2?true:false
                           onTriggered: {
                               synchronizeTime.text=menuItem15.text
                               basicConfig.cameraSynchronizationCycle=2
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem16
                           text:qsTr("6 H")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraSynchronizationCycle==6?true:false
                           onTriggered: {
                               synchronizeTime.text=menuItem16.text
                               basicConfig.cameraSynchronizationCycle=6
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem17
                           text:qsTr("12 H")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraSynchronizationCycle==12?true:false
                           onTriggered: {
                               synchronizeTime.text=menuItem17.text
                               basicConfig.cameraSynchronizationCycle=12
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       RLSConfigMenuItem{
                           id:menuItem18
                           text:qsTr("24 H")
                           autoExclusive : true
                           checkable:true
                           checked:  basicConfig.cameraSynchronizationCycle==24?true:false
                           onTriggered: {
                               synchronizeTime.text=menuItem18.text
                               basicConfig.cameraSynchronizationCycle=24
                               basicConfig.updateAllConfig()
                               tips.open("设置已保存！！")
                               }
                       }
                       onOpened: synchronizeTime.imageSource="../icons/up.png"
                       onClosed: {synchronizeTime.imageSource="../icons/down.png";synchronizeTime.forceActiveFocus();}
                   }

               }//Rectangle
         }

               RLSPopup{
                   id:dectorPositionViewPopup
                   width:600
                   height: 1014
                   x:parent.width
                   leftPadding: 1
                   transformOrigin: Popup.TopLeft
                   Rectangle{
                       id:dectorPositionViewPopupContent
                       color:RLSTheme.backgroundColor.C6
                       anchors.fill: parent
                       GridLayout{
                             id:dectorPositionViewPopupGridLayout
                             anchors.left: parent.left
                             anchors.leftMargin: 20
                             width:560
                             columns: 2
                             rowSpacing: 22
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("能窗低值")
                             }
                             RowLayout{
                                 spacing: 6
                                 anchors.right: parent.right
                                 RLSConfigTextInput{
                                     id:lowEnergy
                                     validator: IntValidator{bottom: 0; top: 1024;}
                                     font.family: RLSTheme.fontFamily
                                     font.pixelSize: RLSTheme.fontSize.F3
                                     placeholderText :lowEnergy.activeFocus?"":basicConfig.lowEnergy
                                      inputMethodHints: Qt.ImhDigitsOnly
                                     EnterKeyAction.actionId:  EnterKeyAction.Next
                                     EnterKeyAction.label: "Next"
                                     EnterKeyAction.enabled:lowEnergy.length>0||lowEnergy.inputMethodComposing?true:false
                                     onEnterKeyClicked:{
                                         lowEnergy.focus=false
                                         basicConfig.lowEnergy=Number(lowEnergy.text)
                                         basicConfig.updateAllConfig()
                                         tips.open("设置已保存！！")
                                     }
                                 }
                                 RLSConfigLabel{
                                     text:qsTr("道")
                                 }
                            }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("能窗高值")
                             }
                             RowLayout{
                                 spacing: 6
                                 anchors.right: parent.right
                                 RLSConfigTextInput{
                                     id:highEnergy
                                     validator: IntValidator{bottom: 0; top: 1024;}
                                     font.family: RLSTheme.fontFamily
                                     font.pixelSize: RLSTheme.fontSize.F3
                                     placeholderText :highEnergy.activeFocus?"":basicConfig.highEnergy
                                      inputMethodHints: Qt.ImhDigitsOnly
                                     EnterKeyAction.actionId:  EnterKeyAction.Next
                                     EnterKeyAction.label: "Next"
                                     EnterKeyAction.enabled:highEnergy.length>0||highEnergy.inputMethodComposing?true:false
                                     onEnterKeyClicked:{
                                         highEnergy.focus=false
                                         basicConfig.highEnergy=Number(highEnergy.text)
                                         basicConfig.updateAllConfig()
                                         tips.open("设置已保存！！")
                                     }
                                 }
                                 RLSConfigLabel{
                                     text:qsTr("道")
                                 }
                            }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("能谱清空方式")
                             }
                             RLSTextField{
                                 id:clearSpectStyle
                                 Layout.preferredWidth: 370
                                 font.family: RLSTheme.fontFamily
                                 font.pixelSize: RLSTheme.fontSize.F3
                                 readOnly: true
                                 color:RLSTheme.textColor.C10
                                 //placeholderText:basicConfig.clearSpectrumByTime
                                 cursorVisible: false
                                 imageSource:"../icons/down.png"
                                 anchors.right: parent.right
                                 onPopupOpen:clearSpectStyleMenu.open()
                                 Component.onCompleted: function initText(){
                                     switch(basicConfig.clearSpectrumByTime){
                                     case true:
                                         clearSpectStyle.text=qsTr("定时清空");break;
                                     case false:
                                         clearSpectStyle.text=qsTr("定计数清空");break;
                                     }
                                 }
                             }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("设置时长")
                             }
                             RowLayout{
                                 spacing: 6
                                 anchors.right: parent.right
                                 RLSConfigTextInput{
                                     validator: IntValidator{bottom: 0; top: 3600;}
                                     enabled:basicConfig.clearSpectrumByTime
                                     id:clearSpectByTimeInterval
                                     font.family: RLSTheme.fontFamily
                                     font.pixelSize: RLSTheme.fontSize.F3
                                     placeholderText :clearSpectByTimeInterval.activeFocus?"":basicConfig.clearSpectrumInterval
                                      inputMethodHints: Qt.ImhDigitsOnly
                                     EnterKeyAction.actionId:  EnterKeyAction.Next
                                     EnterKeyAction.label: "Next"
                                     EnterKeyAction.enabled:clearSpectByTimeInterval.length>0||clearSpectByTimeInterval.inputMethodComposing?true:false
                                     onEnterKeyClicked:{
                                         clearSpectByTimeInterval.focus=false
                                         basicConfig.clearSpectrumInterval=Number(clearSpectByTimeInterval.text)
                                         basicConfig.updateAllConfig()
                                         tips.open("设置已保存！！")
                                     }
                                 }
                                 RLSConfigLabel{
                                     text:qsTr("秒")
                                 }
                            }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("设置个数")
                             }
                             RowLayout{
                                 spacing: 6
                                 anchors.right: parent.right
                                 RLSConfigTextInput{
                                     validator: IntValidator{bottom: 0; top: 10000000;}
                                     font.family: RLSTheme.fontFamily
                                     font.pixelSize: RLSTheme.fontSize.F3
                                     enabled:!basicConfig.clearSpectrumByTime
                                     id:clearSpectCount
                                     placeholderText :clearSpectCount.activeFocus?"":basicConfig.clearSpectrumCount
                                     inputMethodHints: Qt.ImhDigitsOnly
                                     EnterKeyAction.actionId:  EnterKeyAction.Next
                                     EnterKeyAction.label: "Next"
                                     EnterKeyAction.enabled:clearSpectCount.length>0||clearSpectCount.inputMethodComposing?true:false
                                     onEnterKeyClicked:{
                                         clearSpectCount.focus=false
                                         basicConfig.clearSpectrumCount=Number(clearSpectCount.text)
                                         basicConfig.updateAllConfig()
                                         tips.open("设置已保存！！")
                                     }
                                 }
                                 RLSConfigLabel{
                                     text:qsTr("个")
                                 }
                            }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("原始数据存储时间间隔")
                             }
                             RowLayout{
                                 spacing: 6
                                 anchors.right: parent.right
                                 RLSConfigTextInput{
                                     validator: IntValidator{bottom: 0; top: 3600;}
                                     font.family: RLSTheme.fontFamily
                                     font.pixelSize: RLSTheme.fontSize.F3
                                     id:spectStoreTimeInterval
                                     placeholderText :spectStoreTimeInterval.activeFocus?"":basicConfig.spectStoreTimeInterval
                                      inputMethodHints: Qt.ImhDigitsOnly
                                     EnterKeyAction.actionId:  EnterKeyAction.Next
                                     EnterKeyAction.label: "Next"
                                     EnterKeyAction.enabled:spectStoreTimeInterval.length>0||spectStoreTimeInterval.inputMethodComposing?true:false
                                     onEnterKeyClicked:{
                                         spectStoreTimeInterval.focus=false
                                         basicConfig.spectStoreTimeInterval=Number(spectStoreTimeInterval.text)
                                         basicConfig.updateAllConfig()
                                         tips.open("设置已保存！！")
                                     }

                                 }
                                 RLSConfigLabel{
                                     text:qsTr("秒")
                                 }
                            }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                             RLSConfigLabel{
                                 text:qsTr("增益改变后是否立即清除能谱数据")
                             }
                             RLSSwitch{
                                 id:gainChangeClearSpectrum
                                 anchors.right: parent.right
                                 checked: basicConfig.gainChangeClearSpectrum
                                 onClicked: {
                                     basicConfig.gainChangeClearSpectrum=gainChangeClearSpectrum.checked
                                     basicConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                 }
                             }
                             RLSConfigSeparate{
                                  Layout.columnSpan: 2
                             }
                       }

                       RLSConfigMenu{
                           id:clearSpectStyleMenu
                          // parent:countRatePopup
                           dim:true
                           modal:true
                           focus:false
                           transformOrigin : Popup.Bottom
                           y:parent.height-10-clearSpectStyleMenu.height
                           x:parent.x+11
                           RLSConfigMenuItem{
                               id:menuItem19
                               text:qsTr("定时清空")
                               autoExclusive : true
                               checkable:true
                               checked:basicConfig.clearSpectrumByTime
                               onTriggered: {
                                   clearSpectStyle.text=menuItem19.text
                                   basicConfig.clearSpectrumByTime=true;
                                   basicConfig.updateAllConfig();
                                   tips.open("设置已保存！！")
                                   }
                           }
                           RLSConfigMenuItem{
                               id:menuItem20
                               text:qsTr("定计数清空")
                               autoExclusive : true
                               checkable:true
                               checked:!basicConfig.clearSpectrumByTime
                               onTriggered: {
                                   clearSpectStyle.text=menuItem20.text
                                   basicConfig.clearSpectrumByTime=false;
                                   basicConfig.updateAllConfig();
                                   tips.open("设置已保存！！")
                                   }
                           }
                           onOpened: clearSpectStyle.imageSource="../icons/up.png"
                           onClosed:{ clearSpectStyle.imageSource="../icons/down.png";clearSpectStyle.forceActiveFocus();}
                       }

                   }//Rectangel

                   InputPanel {
                       id:inputPanelDectorPositionSetting
                       z: 99
                       y: dectorPositionViewPopup.height
                       width:parent.width
                       //anchors.left: parent.left
                       //anchors.right: parent.right
                       states: State {
                           name: "visible"
                           /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                               but then the handwriting input panel and the keyboard input panel can be visible
                               at the same time. Here the visibility is bound to InputPanel.active property instead,
                               which allows the handwriting panel to control the visibility when necessary.
                           */
                           when: inputPanelDectorPositionSetting.active
                           PropertyChanges {
                               target: inputPanelDectorPositionSetting
                               y: dectorPositionViewPopup.height - inputPanelDectorPositionSetting.height
                           }
                       }
                       transitions: Transition {
                           from: ""
                           to: "visible"
                           reversible: true
                           ParallelAnimation {
                               NumberAnimation {
                                   properties: "y"
                                   duration: 250
                                   easing.type: Easing.InOutQuad
                               }
                           }
                       }
                   }
               }
    }
 }//positionView
////////////////////////////////////////=!reconstructionView!=///
    Component{
        id:reconstructionView
       Rectangle{
           id:reconstructionViewContent
           width:600
           height:1014
           color:RLSTheme.backgroundColor.C6
           BasicConfig{
               id:basicConfig
           }
           GridLayout{
                 id:reconstructionViewGridLayout
                 anchors.left: parent.left
                 anchors.leftMargin: 20
                 //width:600
                 columns: 2
                 rowSpacing: 22
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("是否开启重建模式")
                 }
                 RLSSwitch{
                     id:reconMode
                     anchors.right: parent.right
                     checked: basicConfig.reconMode
                     onClicked: {
                         basicConfig.reconMode=reconMode.checked
                         basicConfig.updateAllConfig()
                          tips.open("设置已保存！！")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("重建图像色标类型")
                 }
                 ComboBox{
                     id:control
                     font.family: "微软雅黑"
                     font.pixelSize: 14
                     anchors.right: parent.right
                     model: ["NIH", "NIH + white", "green temperature","hot blue","hot green","spectrum","inv. NIH + white","inverse NIH","inverse spectrum"]
                     spacing: 1

                     contentItem: Text {
                         id:content
                         leftPadding: 10
                         rightPadding: control.indicator.width + control.spacing
                         text: control.displayText
                         font: control.font
                         color: RLSTheme.backgroundColor.C2
                         horizontalAlignment: Text.AlignLeft
                         verticalAlignment: Text.AlignVCenter
                         elide: Text.ElideRight
                     }
                     indicator: Image {
                         x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
                         y: control.topPadding + (control.availableHeight - height) / 2
                         source: "../icons/down.png"
                         sourceSize.width: width
                         sourceSize.height: height
                     }
                     delegate: Rectangle{
                         color:control.currentIndex==index?RLSTheme.backgroundColor.C5:RLSTheme.backgroundColor.C6
                         MouseArea{
                             anchors.fill: parent
                             onClicked:{
                                 control.currentIndex=index;
                                 basicConfig.colorType=control.textAt(index);
                                 basicConfig.updateAllConfig()
                                 tips.open(qsTr("设置已保存!!"))
                                 control.popup.close();
                             }
                         }
                         implicitHeight:40
                         implicitWidth:300
                         Label{
                             id:text
                             text:modelData
                             font.family: "微软雅黑"
                             font.pixelSize: 12
                             color:RLSTheme.textColor.C10
                             anchors.leftMargin: 10
                             anchors.verticalCenter: parent.verticalCenter
                             anchors.left: parent.left
                         }
                         Image{
                             source:"../icons/"+modelData+".png"
                             anchors.right: parent.right
                             anchors.verticalCenter: parent.verticalCenter
                             anchors.rightMargin: 10
                         }

                     }
                     popup: T.Popup {
                         y: control.height - (control.visualFocus ? 0 : 1)
                         width: control.width
                         implicitHeight: listview.contentHeight
                         topMargin: 6
                         bottomMargin: 6

                         contentItem: ListView {
                             id: listview
                             clip: true
                             model: control.popup.visible ? control.delegateModel : null
                             currentIndex: control.highlightedIndex

                             Rectangle {
                                 z: 10
                                 parent: listview
                                 width: listview.width
                                 height: listview.height
                                 color: "transparent"
                                 border.color: "#bdbebf"
                             }

                             T.ScrollIndicator.vertical: ScrollIndicator { }
                         }
                         }
                     background: Rectangle {
                         implicitWidth: 300
                         implicitHeight: 40
                         radius: 5
                         color: control.visualFocus ? (control.pressed ? "#cce0ff" : "#f0f6ff") :
                             (control.pressed ? "#d0d0d0" : "#e0e0e0")
                     }
                     Component.onCompleted: function initText(){
                         console.log(basicConfig.colorType)
                         if(basicConfig.colorType=="NIH")
                            control.currentIndex=0;
                         if(basicConfig.colorType=="NIH + white")
                            control.currentIndex=1;
                         if(basicConfig.colorType=="green temperature")
                            control.currentIndex=2;
                         if(basicConfig.colorType=="hot blue")
                            control.currentIndex=3;
                         if(basicConfig.colorType=="hot green")
                            control.currentIndex=4;
                         if(basicConfig.colorType=="spectrum")
                            control.currentIndex=5;
                         if(basicConfig.colorType=="inv. NIH + white")
                            control.currentIndex=6;
                         if(basicConfig.colorType=="inverse NIH")
                            control.currentIndex=7;
                         if(basicConfig.colorType=="inverse spectrum")
                            control.currentIndex=8;

                     }

                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RowLayout{
                     anchors.left: parent.left
                     //spacing: 20+
                     RLSConfigLabel{
                         text:qsTr("色标上限")
                     }
                     RLSConfigTextInput{
                         id:reconColorUpLimit
                         validator: IntValidator{bottom: 0; top: 100;}
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         placeholderText :reconColorUpLimit.activeFocus?"":basicConfig.reconColorUpLimit*100
                          inputMethodHints: Qt.ImhDigitsOnly
                         EnterKeyAction.actionId:  EnterKeyAction.Next
                         EnterKeyAction.label: "Next"
                         EnterKeyAction.enabled:reconColorUpLimit.length>0||reconColorUpLimit.inputMethodComposing?true:false
                         onEnterKeyClicked:{
                             reconColorUpLimit.focus=false
                             basicConfig.reconColorUpLimit=Number(reconColorUpLimit.text)/100
                             basicConfig.updateAllConfig()
                             tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigLabel{
                         text:qsTr("%")
                     }
                 }
                 RowLayout{
                     anchors.right: parent.right
                     //spacing: 20+
                     RLSConfigLabel{
                         text:qsTr("色标下限")
                     }
                     RLSConfigTextInput{
                        id:reconColorLowLimit
                        validator: IntValidator{bottom: 0; top: 100;}
                        font.family: RLSTheme.fontFamily
                        font.pixelSize: RLSTheme.fontSize.F3
                        placeholderText :reconColorLowLimit.activeFocus?"":basicConfig.reconColorLowLimit*100
                         inputMethodHints: Qt.ImhDigitsOnly
                        EnterKeyAction.actionId:  EnterKeyAction.Next
                        EnterKeyAction.label: "Next"
                        EnterKeyAction.enabled:reconColorLowLimit.length>0||reconColorLowLimit.inputMethodComposing?true:false
                        onEnterKeyClicked:{
                            reconColorLowLimit.focus=false
                            basicConfig.reconColorLowLimit=Number(reconColorLowLimit.text)/100
                            basicConfig.updateAllConfig()
                            tips.open("设置已保存！！")
                        }
                     }
                     RLSConfigLabel{
                         text:qsTr("%")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("重建图像是否平滑显示")
                 }
                 RLSSwitch{
                     id:reconImageSmooth
                     anchors.right: parent.right
                     checked: basicConfig.reconImageSmooth
                     onClicked: {
                         basicConfig.reconImageSmooth=reconImageSmooth.checked
                         basicConfig.updateAllConfig()
                         tips.open("设置已保存！！")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("迭代次数")
                 }
                 RowLayout{
                     anchors.right: parent.right
                     spacing: 6
                     RLSConfigTextInput{
                         id:reconIterationNumber
                         validator: IntValidator{bottom: 0; top: 10000;}
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         placeholderText :reconIterationNumber.activeFocus?"":basicConfig.reconIterationNumber
                         inputMethodHints: Qt.ImhDigitsOnly
                         EnterKeyAction.actionId:  EnterKeyAction.Next
                         EnterKeyAction.label: "Next"
                         EnterKeyAction.enabled:reconIterationNumber.length>0||reconIterationNumber.inputMethodComposing?true:false
                         onEnterKeyClicked:{
                             reconIterationNumber.focus=false
                             basicConfig.reconIterationNumber=Number(reconIterationNumber.text)
                             basicConfig.updateAllConfig()
                             tips.open("设置已保存！！")
                         }
                     }
                     RLSConfigLabel{
                         text:qsTr("次")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("是否快速重建模式")
                 }
                 RLSSwitch{
                     id:reconFastMode
                     anchors.right: parent.right
                     checked: basicConfig.reconFastMode
                     onClicked: {
                         basicConfig.reconFastMode=reconFastMode.checked
                         basicConfig.updateAllConfig()
                         tips.open("设置已保存！！")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("增益后是否立即重建")
                 }
                 RLSSwitch{
                     id:reconByGain
                     anchors.right: parent.right
                     checked: basicConfig.reconByGain
                     onClicked: {
                         basicConfig.reconByGain=reconByGain.checked
                         basicConfig.updateAllConfig()
                         tips.open("设置已保存！！")
                     }
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
           }
           ColumnLayout{
               anchors.top: reconstructionViewGridLayout.bottom
               spacing:0
                        RLSConfigButton{
                             id:reconByTime
                             text:qsTr("定时重建")
                             checkable: true
                             enabled: basicConfig.reconMode
                             autoExclusive : true
                             onClicked:reconByTimeViewPopup.open()
                         }
                        RLSConfigSeparate{
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            Layout.preferredWidth : parent.width-40
                        }
                         RLSConfigButton{
                             text:qsTr("定计数重建")
                             checkable: true
                             enabled:basicConfig.reconMode
                             autoExclusive : true
                             onClicked:reconByCountViewPopup.open()
                        }
                         RLSConfigSeparate{
                             anchors.left: parent.left
                             anchors.leftMargin: 20
                             Layout.preferredWidth : parent.width-40
                         }
       }

           RLSPopup{
               id:reconByTimeViewPopup
               width:600
               height: 1014
               x:parent.width
               leftPadding: 1
               transformOrigin: Popup.TopLeft
               Rectangle{
                   id:reconByTimeViewPopupContent
                   color:RLSTheme.backgroundColor.C6
                   anchors.fill: parent
                   GridLayout{
                         id:reconByTimeViewPopupGridLayout
                         anchors.left: parent.left
                         anchors.leftMargin: 20
                         width:560
                         columns: 2
                         rowSpacing: 22
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("是否定时重建")
                         }
                         RLSSwitch{
                             id:isReconByTime
                             anchors.right: parent.right
                             checked: basicConfig.reconByTime
                            onClicked: {
                                 basicConfig.reconByTime=isReconByTime.checked
                                 basicConfig.updateAllConfig()
                                 tips.open("设置已保存！！")
                            }
                         }
                         RLSConfigSeparate{
                             Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("时间长度")
                         }
                         RowLayout{
                             anchors.right: parent.right
                             spacing: 6
                             RLSConfigTextInput{
                                 validator: IntValidator{bottom: 0; top: 1000000;}
                                 font.family: RLSTheme.fontFamily
                                 font.pixelSize: RLSTheme.fontSize.F3
                             id:reconInterval
                             enabled:basicConfig.reconByTime
                             placeholderText:reconInterval.activeFocus?"":basicConfig.reconInterval
                              inputMethodHints: Qt.ImhDigitsOnly
                             EnterKeyAction.actionId:  EnterKeyAction.Next
                             EnterKeyAction.label: "Next"
                             EnterKeyAction.enabled:reconInterval.length>0||reconInterval.inputMethodComposing?true:false
                             onEnterKeyClicked:{
                                 reconInterval.focus=false
                                 basicConfig.reconInterval=Number(reconInterval.text)
                                 basicConfig.updateAllConfig()
                                 tips.open("设置已保存！！")
                             }
                             }
                             RLSConfigLabel{
                                 text:qsTr("秒")
                             }
                         }
                         RLSConfigSeparate{
                             Layout.columnSpan: 2
                         }

                   }
               }
               InputPanel {
                   id:inputPanelReconByTimeViewSetting   //reconByCountViewPopup
                   z: 99
                   y: reconByTimeViewPopup.height
                   width:parent.width
                   //anchors.left: parent.left
                   //anchors.right: parent.right
                   states: State {
                       name: "visible"
                       /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                           but then the handwriting input panel and the keyboard input panel can be visible
                           at the same time. Here the visibility is bound to InputPanel.active property instead,
                           which allows the handwriting panel to control the visibility when necessary.
                       */
                       when:reconInterval.activeFocus
                       PropertyChanges {
                           target: inputPanelReconByTimeViewSetting
                           y: reconByTimeViewPopup.height - inputPanelReconByTimeViewSetting.height
                       }
                   }
                   transitions: Transition {
                       from: ""
                       to: "visible"
                       reversible: true
                       ParallelAnimation {
                           NumberAnimation {
                               properties: "y"
                               duration: 250
                               easing.type: Easing.InOutQuad
                           }
                       }
                   }
               }
           }
           RLSPopup{
               id:reconByCountViewPopup
               width:600
               height: 1014
               x:parent.width
               leftPadding: 1
               transformOrigin: Popup.TopLeft
               Rectangle{
                   id:reconByCountViewPopupContent
                   color:RLSTheme.backgroundColor.C6
                   anchors.fill: parent
                   GridLayout{
                         id:reconByCountViewPopupGridLayout
                         anchors.left: parent.left
                         anchors.leftMargin: 20
                         width:560
                         columns: 2
                         rowSpacing: 22
                         RLSConfigSeparate{
                              Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("是否定计数重建")
                         }
                         RLSSwitch{
                             id:isReconByCount
                             anchors.right: parent.right
                             checked: basicConfig.reconByCount
                             onClicked: {
                                 basicConfig.reconByCount=isReconByCount.checked
                                 basicConfig.updateAllConfig()
                                 tips.open("设置已保存！！")
                            }
                         }
                         RLSConfigSeparate{
                             Layout.columnSpan: 2
                         }
                         RLSConfigLabel{
                             text:qsTr("计数")
                         }
                         RowLayout{
                             anchors.right: parent.right
                             spacing: 6
                             RLSConfigTextInput{
                                 validator: IntValidator{bottom: 0; top: 10000000;}
                                 font.family: RLSTheme.fontFamily
                                 font.pixelSize: RLSTheme.fontSize.F3
                              id:reconCount
                              enabled:basicConfig.reconByCount
                              placeholderText :reconCount.activeFocus?"":basicConfig.reconCount
                               inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:  EnterKeyAction.Next
                              EnterKeyAction.label: "Next"
                              EnterKeyAction.enabled:reconCount.length>0||reconCount.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  reconCount.focus=false
                                  basicConfig.reconCount=Number(reconCount.text)
                                  basicConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                             }
                             RLSConfigLabel{
                                 text:qsTr("个")
                             }
                         }
                         RLSConfigSeparate{
                             Layout.columnSpan: 2
                         }

                   }
               }
               InputPanel {
                   id:inputPanelReconByCountViewSetting   //reconByCountViewPopup
                   z: 99
                   y: reconByCountViewPopup.height
                   width:parent.width
                   //anchors.left: parent.left
                   //anchors.right: parent.right
                   states: State {
                       name: "visible"
                       /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                           but then the handwriting input panel and the keyboard input panel can be visible
                           at the same time. Here the visibility is bound to InputPanel.active property instead,
                           which allows the handwriting panel to control the visibility when necessary.
                       */
                       when: reconCount.activeFocus
                       PropertyChanges {
                           target: inputPanelReconByCountViewSetting
                           y: reconByCountViewPopup.height - inputPanelReconByCountViewSetting.height
                       }
                   }
                   transitions: Transition {
                       from: ""
                       to: "visible"
                       reversible: true
                       ParallelAnimation {
                           NumberAnimation {
                               properties: "y"
                               duration: 250
                               easing.type: Easing.InOutQuad
                           }
                       }
                   }
               }
           }

           InputPanel {
               id:inputPanelReconStructionSetting
               z: 99
               y: reconstructionViewContent.height
               width:parent.width
               //anchors.left: parent.left
               //anchors.right: parent.right
               states: State {
                   name: "visible"
                   /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                       but then the handwriting input panel and the keyboard input panel can be visible
                       at the same time. Here the visibility is bound to InputPanel.active property instead,
                       which allows the handwriting panel to control the visibility when necessary.
                   */
                   when: reconColorLowLimit.activeFocus||reconColorUpLimit.activeFocus||reconIterationNumber.activeFocus
                   PropertyChanges {
                       target: inputPanelReconStructionSetting
                       y: reconstructionViewContent.height - inputPanelReconStructionSetting.height
                   }
               }
               transitions: Transition {
                   from: ""
                   to: "visible"
                   reversible: true
                   ParallelAnimation {
                       NumberAnimation {
                           properties: "y"
                           duration: 250
                           easing.type: Easing.InOutQuad
                       }
                   }
               }
           }
     }
 }//reconstructionView
////////////////////////////////////////=!hardDiskView!=/////////
    Component{
        id:hardDiskView
       Rectangle{
           id:hardDiskViewContent
           width:600
           height:1014
           color:RLSTheme.backgroundColor.C6
           BasicConfig{
               id:basicConfig
           }
           StateInfo{
               id:stateInfo
           }

           GridLayout{
                 id:hardDiskViewGridLayout
                 anchors.left: parent.left
                 anchors.leftMargin: 20
                 columns: 2
                 rowSpacing: 10
                 width:560
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 Text{
                     font.family: RLSTheme.fontFamily
                     font.pixelSize: RLSTheme.fontSize.F4
                     color:RLSTheme.textColor.C11
                     text:qsTr("原始数据存储路径")
                     Layout.columnSpan: 2
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     id:rawDirFree
                     anchors.left: parent.left
                     text:qsTr("可用："+stateInfo.getFreeHardDisk()+"GB")
                 }
                 RLSConfigLabel{
                     id:rawDirTotal
                     anchors.right: parent.right
                     text:qsTr("总共："+stateInfo.getTotalHardDisk()+"GB")
                 }
                 Rectangle{
                     color:RLSTheme.textColor.C13
                     Layout.columnSpan: 2
                     height:15
                     Layout.fillWidth: true
                     Rectangle{
                         color:RLSTheme.backgroundColor.C2
                         height:15
                         width:Math.floor(parent.width- parent.width*stateInfo.getFreeHardDisk()/stateInfo.getTotalHardDisk())
                     }
                 }
                 RowLayout{
                     anchors.left: parent.left
                     spacing: 6
                     RLSConfigLabel{
                         text:qsTr("存储路径")
                     }
                     RLSConfigTextInput{
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         id:rawDirPath
                         readOnly: true
                         placeholderText:stateInfo.getRawDataDir()
                         Layout.preferredWidth: 300
                     }
                 }
                 RLSButton{
                     text:qsTr("选择路径")
                     anchors.right: parent.right
                     onClicked: fileDialog.open()
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                     height:4
                 }
                 Text{
                     font.family: RLSTheme.fontFamily
                     font.pixelSize: RLSTheme.fontSize.F4
                     color:RLSTheme.textColor.C11
                     text:qsTr("敏感图片存储路径")
                     Layout.columnSpan: 2
                 }
                 RLSConfigSeparate{
                     Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     id:imageFree
                     anchors.left: parent.left
                     text:qsTr("可用:"+stateInfo.getFreeHardDiskSensiveImagePath()+"GB")
                 }
                 RLSConfigLabel{
                     id:imageTotal
                     anchors.right: parent.right
                     text:qsTr("总共:"+stateInfo.getTotalHardDiskSensiveImagePath()+"GB")
                 }
                 Rectangle{
                     color:RLSTheme.textColor.C13
                     Layout.columnSpan: 2
                     height:15
                     Layout.fillWidth: true
                     Rectangle{
                         color:RLSTheme.backgroundColor.C2
                         height:15
                         width:Math.floor(parent.width- parent.width*stateInfo.getFreeHardDiskSensiveImagePath()/stateInfo.getTotalHardDiskSensiveImagePath())
                     }
                 }
                 RowLayout{
                     anchors.left: parent.left
                     spacing: 12
                     RLSConfigLabel{
                         text:qsTr("存储路径")
                     }
                     RLSConfigTextInput{
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                        id:sensiveImagePath
                        Layout.preferredWidth: 300
                        readOnly: true
                        placeholderText: stateInfo.getSensiveImageDir()
                     }
                 }
                 RLSButton{
                     text:qsTr("选择路径")
                     anchors.right: parent.right
                     onClicked: fileDialogSensiveImage.open()
                 }
           }
           FileDialog{
               id:fileDialog
               title:qsTr("原始数据的存储路径")
               folder: shortcuts.documents
               selectFolder : true
               sidebarVisible: true
               modality:Qt.WindowModal
               onAccepted:{

                   setRawDir();
                   rawDirFree.text=qsTr("可用："+stateInfo.getFreeHardDisk()+"GB");
                   rawDirTotal.text=qsTr("总共:"+stateInfo.getTotalHardDisk()+"GB");
                   Qt.quit();}
                onRejected: {
                         Qt.quit()
                     }
           }
           FileDialog{
               id:fileDialogSensiveImage
               title:qsTr("敏感图片的存储路径")
               folder: shortcuts.documents
               selectFolder : true
               sidebarVisible: true
               modality:Qt.WindowModal
               onAccepted:{
                   setSensiveImage();
                    imageFree.text=qsTr("可用:"+stateInfo.getFreeHardDiskSensiveImagePath()+"GB");
                    imageTotal.text=qsTr("总共:"+stateInfo.getTotalHardDiskSensiveImagePath()+"GB");
                   Qt.quit();}
                onRejected: {
                         Qt.quit()
                     }
           }
           function setSensiveImage(){
               stateInfo.setSensiveImageDir(fileDialogSensiveImage.fileUrls)
               var path=new String(fileDialogSensiveImage.fileUrls)
               sensiveImagePath.text=path.slice(8)
           }
           function setRawDir(){
               stateInfo.setRawDataDir(fileDialog.fileUrls)
               var path=new String(fileDialog.fileUrls)
               rawDirPath.text=path.slice(8)
                  }
    }
 }//reconstructionView

}
