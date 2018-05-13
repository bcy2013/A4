import QtQuick 2.7
import QtQuick.Controls 1.4 as TableControl
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.VirtualKeyboard 2.1
import QtQuick.Controls.Styles 1.4
import DataBase 1.0
import "../RLSTheme"
import "../Lib/MaterialUI/Interface"
import QtQuick.Controls 1.4
import QtQuick.LocalStorage 2.0
Item {
    anchors.fill: parent
    //property int number: 100
    property int leftMargin: 20
    property int rightMargin: 20
    property string currentUserName
    property int allUserCount
    property var componentModel: [

        {name:qsTr("图像显示"),icon:"Image",component:warmingManager},
    ]

    Loader{
        id:componentloader
       // anchors.fill:parent
        visible: status == Loader.Ready
        sourceComponent: componentModel[controlData.componentIndex].component
        Component.onCompleted: function getCurrentUserName(){
            var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
            var rs;
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT PRIMARY KEY, password TEXT,loginTime DATE)');
                     rs = tx.executeSql('SELECT * FROM UsersInfo ORDER BY loginTime DESC');
//                     for(var i=0;i<rs.rows.length;i++)
//                     {
//                       model.append(
//                           {
//                               "name":rs.rows.item(i).name
//                           }
//                           )
//                     }
                    currentUserName=rs.rows.item(0).name
                    allUserCount=rs.rows.length

                }
            )
        }

    }
    MaterialSnackbar{
        id:tips
    }
    Component{
        id:warmingManager
        Rectangle{
            id:positioningManagementContent
            width:1920
            height:1014
            color:RLSTheme.backgroundColor.C3
            DataBase{
                id:dataBase


            }

            Rectangle{
                id:table
                anchors.left: parent.left
                width:parent.width-rightMenu.width-6

                height: parent.height
//                ScrollIndicator {
//                          id:scrollBar
//                          anchors.right: tableView.right
//                          width: 15
//                          rightPadding: 3
//                      }

                TableControl.TableView{
                   id:tableView
                   anchors.fill:parent
                   Layout.preferredWidth: 1920-370
                   //frameVisible:true
                   //backgroundVisible: true
                   //sortIndicatorVisible: true
                   verticalScrollBarPolicy :Qt.ScrollBarAlwaysOn


//                   TableControl.TableViewColumn {
//                       id: indexColumn
//                       title: qsTr("编号")
//                       role: "number"
//                       movable: false
//                      // resizable: true
//                       horizontalAlignment :Text.AlignHCenter

//                       elideMode :Text.ElideMiddle


//                       width: tableView.viewport.width / 12
//                   }
                   TableControl.TableViewColumn {
                       id: warmingTimeColumn
                       title: qsTr("报警时间")
                       role: "warmingTime2"
                       movable: false
                      // resizable: true
                       elideMode :Text.ElideMiddle

                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("设备名")
                       role: "name"
                       movable: false
                       //resizable: true
                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("报警类型")
                       role: "warmingType"
                       movable: false
                       //resizable: true
                       elideMode :Text.ElideMiddle

                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("严重等级")
                       role: "seriousLevel"
                       movable: false
                       //resizable: true
                       elideMode :Text.ElideMiddle

                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("计数率")
                       role: "countRate"
                       movable: false
                       //resizable: true
                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("剂量当量率")
                       role: "coefDoseRate"
                       movable: false
                       //resizable: true
                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("敏感图片")
                       role: "sensitiveImages"
                       movable: false
                       //resizable: true
                       horizontalAlignment :Text.AlignHCenter
                      width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("报警处理")
                       role: "processType"
                       movable: false
                      // resizable: true
                      horizontalAlignment :Text.AlignHCenter
                      width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("事件处理人")
                       role: "processUser"
                       movable: false
                      // resizable: true
                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("描述")
                       role: "descriptor"
                       movable: false
                       //resizable: true
                       horizontalAlignment :Text.AlignHCenter
                       width: tableView.viewport.width / 11
                   }
                   TableControl.TableViewColumn {
                       title: qsTr("处理时间")
                       role: "processDateTime"
                       movable: false
                       resizable: true
                       horizontalAlignment :Text.AlignHCenter
                      width: tableView.viewport.width/11
                   }

                   model:sourceModel
                  style:TableViewStyle{
                       id:myStyle
                       readonly property bool activateItemOnSingleClick: false
                       readonly property real __alternateBackgroundOpacity: 0.25
                       readonly property real __selectedBackgroundOpacity: 0.25
                       readonly property real __columnMargin:20
                       readonly property color backgroundColor: "transparent"
                       transientScrollBars: true
                       highlightedTextColor:RLSTheme.backgroundColor.C2
                       readonly property color alternateBackgroundColor: RLSTheme.backgroundColor.C5
                       property Component rowDelegate: Item {
                           height: 40
                           readonly property color selectedColor: RLSTheme.backgroundColor.C2
                           readonly property bool selected: tableView.enabled && (styleData.hasActiveFocus || styleData.selected)

                           Rectangle {
                               id: bg
                               color: selected ? selectedColor :
                                      styleData.alternate ? alternateBackgroundColor : backgroundColor
                               opacity: !control.enabled ? (styleData.alternate ? __alternateBackgroundOpacity : 1.0) :
                                        styleData.selected ? (styleData.alternate ? __selectedBackgroundOpacity : __alternateBackgroundOpacity) :
                                        (styleData.alternate ? __alternateBackgroundOpacity : 1.0)
                               anchors.fill: parent
//                               border.color:selected ? RLSTheme.backgroundColor.C2 : "gray"
//                               border.width: selected?1:0.5
                           }

                           Rectangle {
                               // Bottom separator
                               z:1
                               visible: !tableView.alternatingRowColors
                               color: selected ? "red" : "gray"
                               height: 1
                               width: parent.width
                               anchors.bottom: parent.bottom
                           }

                           Rectangle {
                               // Top separator. Only visible if the current row is selected. It hides
                               // the previous row's bottom separator when this row is selected or focused
                               visible: selected && !tableView.alternatingRowColors
                               z:1
                                color: selected ? "red" : "gray"
                               height: 1
                               width: parent.width
                               anchors.bottom: parent.top
                           }
                       }
                       headerDelegate:Item{
                           width: tableView.viewport.width/11
                           height: 40
                           Text {
                               anchors.horizontalCenter: parent.horizontalCenter
                               anchors.verticalCenter: parent.verticalCenter
                               color: "white"
                               text: styleData.value
                               font.pixelSize: 14
                               font.family: "微软雅黑"
                           }
                           Rectangle{
                               width:1
                               height:parent.height
                               color:"gray"
                               anchors.left: parent.left
                           }
                           Rectangle{
                               anchors.fill: parent
                               z:-99
                               color:RLSTheme.backgroundColor.C2
                               opacity: 1
                           }
                           Rectangle{
                               width:1
                               height:parent.height
                               color:"gray"
                               anchors.bottom: parent.bottom
                           }

                       }
                       itemDelegate: Item {

                             Text {
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 anchors.verticalCenter: parent.verticalCenter
                                 color: styleData.selected||styleData.hasActiveFocus?highlightedTextColor:"gray"
                                 elide: styleData.elideMode
                                 id: label
                                 text: styleData.value !== undefined ? styleData.value : ""
                                 font.pixelSize: 14
                                 font.family: "微软雅黑"
                                 MouseArea{
                                     anchors.fill: parent
                                     onClicked: {
                                         if(styleData.column==6&&styleData.row==tableView.currentRow)
                                         {
                                             var time = sourceModel.get(tableView.currentRow).warmingTime2
                                             dataBase.sensitiveTime=time

                                             if(dataBase.getHasSensitive())
                                             {
                                                 rlsSensitiveImages.imageSource=dataBase.getSensitiveFile()
                                                 imagePopup.open()
                                             }
                                         }

                                     }
                                 }
                             }
                         }

                   }




                   RLSPopup{
                       id:imagePopup
                       x:600
                       y:150
                       parent:positioningManagementContent
                       transformOrigin: Item.TopLeft
                       closePolicy: Popup.NoAutoClose
                       RLSSensitiveImages{
                           id:rlsSensitiveImages
                       }
                       Component.onCompleted: rlsSensitiveImages.closePop.connect(imagePopup.close)
                   }
                   Component.onCompleted: console.log(tableView.viewport.width)
                }
                 ListModel {
                    id: sourceModel
                    Component.onCompleted: function getDataInfo(){
                    updateDataBase.start()
                    }
                    }

            }

            Rectangle{
                id:rightMenu
                anchors.right: parent.right
                height: parent.height
                width:370
                color:RLSTheme.backgroundColor.C5

                GridLayout{
                      id:rightMenuGridLayout
                      anchors.left: parent.left
                      anchors.leftMargin: 20
                      anchors.right: parent.right
                      anchors.rightMargin: 20
                      width:370
                      columns: 2
                      rowSpacing: 10
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      Text{
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F4
                          color:RLSTheme.textColor.C11
                          text:qsTr("报警事件搜索")
                          Layout.columnSpan: 2
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("是否自动更新")
                      }
                      RLSSwitch{
                          id:autoUpdateSwitch
                          checked: true
                          anchors.right: parent.right
                          onClicked:{
                              searchButton.enabled=!autoUpdateSwitch.checked
                          }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("起始时间")
                      }
                      RLSTextField{
                         id:startTime

                         readOnly : true
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         color:RLSTheme.textColor.C10
                         text:Qt.formatDateTime(dataBase.keyStartTime,"yyyy-MM-dd")
                         anchors.right: parent.right
                         Layout.preferredWidth: 238
                         imageSource:"../icons/date.png"
                         onPopupOpen:{
                         calendar.open()
                         startTime.focus=true

                            }

                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("终止时间")
                      }
                      RLSTextField{
                          id:endTime
                          readOnly : true
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          text:Qt.formatDateTime(dataBase.keyEndTime,"yyyy-MM-dd")
                          anchors.right: parent.right
                          Layout.preferredWidth: 238
                          imageSource:"../icons/date.png"
                          onPopupOpen:{
                              calendar1.open()
                              endTime.forceActiveFocus()

                             }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("处理员")
                      }
                      RLSTextField{
                         id: searchProcessUser
                         readOnly : true
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         color:RLSTheme.textColor.C10
                         text: currentUserName
                         inputMethodHints: Qt.ImhNoPredictiveText
                         anchors.right: parent.right
                         imageSource:"../icons/down.png"
                         //focusReason:Qt.MouseFocusReason
                         onPopupOpen:{
                             imageRrocessUserMenu.open();

                         }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("处理方式")
                      }
                      RLSTextField{
                         id: searchWarningProcessType
                         text:qsTr("未处理")
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         color:RLSTheme.textColor.C10
                         readOnly : true
                         inputMethodHints: Qt.ImhNoPredictiveText
                         anchors.right: parent.right
                         imageSource:"../icons/down.png"
                         onPopupOpen:{imageWarningProcessTypeMenu.open();}
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("报警类型")
                      }
                      RLSTextField{
                          id:searchWarningType
                          text:qsTr("探测器报警")
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          readOnly : true
                          anchors.right: parent.right
                          imageSource:"../icons/down.png"
                          onPopupOpen:{imageWarningTypeMenu.open();}
                      }

                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("报警级别")
                      }
                      RLSTextField{
                         id:searchWarningLevel
                         text:qsTr("一级")
                         font.family: RLSTheme.fontFamily
                         font.pixelSize: RLSTheme.fontSize.F3
                         color:RLSTheme.textColor.C10
                         readOnly : true
                         anchors.right: parent.right
                         imageSource:"../icons/down.png"
                         onPopupOpen:{imageWarningLevelMenu.open();}
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("敏感图片")
                      }
                      RLSTextField{
                          id:searchSentive
                          text:qsTr("无")
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          readOnly : true
                         anchors.right: parent.right
                         imageSource:"../icons/down.png"
                         onPopupOpen:{imageSensitiveMenu.open();}
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      Timer{
                             id:updateDataBase
                             repeat: true
                             interval: 3000
                             onTriggered: {
                                 if(autoUpdateSwitch.checked)
                                 {
                                     sourceModel.clear()
                                     dataBase.updateDataBase()
                                     for(var i = 0; i<dataBase.warningCount;i++)
                                     {
                                         var strWarningType
                                         if(dataBase.getWarningType(i)==0)
                                             strWarningType="探测器报警"
                                         else
                                             strWarningType="硬盘报警"

                                         var strSeriousLevel
                                         var level=dataBase.getSeriousLevel(i)
                                         if(level==0)
                                             strSeriousLevel="一级"
                                         else if(level==1)
                                             strSeriousLevel="二级"
                                         else if(level==2)
                                             strSeriousLevel="三级"
                                         else if(level==3)
                                             strSeriousLevel="四级"
                                         else if(level==4)
                                             strSeriousLevel="五级"

                                         var strProcessType
                                         var type=dataBase.getProcessType(i)
                                         if(type==0)
                                             strProcessType="未处理"
                                         else if(type==1)
                                             strProcessType="发现已处理"
                                         else if(type==2)
                                             strProcessType="发现正常"
                                         else
                                             strProcessType="其他"

                                         var strHasSensitive;

                                         dataBase.sensitiveTime = dataBase.getCurrentWarningTime(i);
                                         if(dataBase.getHasSensitive()==0)
                                             strHasSensitive=qsTr("无")
                                         else
                                             strHasSensitive=qsTr("有")

//                                        sourceModel.insert(0,{
                                         sourceModel.append({
                                        "name":dataBase.getDeviceName(i),
                                        "warmingTime2":dataBase.getCurrentWarningTime(i),
                                        "countRate":dataBase.getCountRate(i),
                                        "warmingType":strWarningType,
                                        "processUser":dataBase.getStrProcessUser(i),
                                        "seriousLevel":strSeriousLevel,
                                        "coefDoseRate":dataBase.getCoefDoseRate(i).toFixed(4),
                                        "processDateTime":dataBase.getProcessDateTime(i),//new Date(dataBase.getProcessDateTime(i)),
                                        "descriptor":dataBase.getDescriptor(i),
                                        "processType":strProcessType,
                                        "sensitiveImages":strHasSensitive
                                        })
                                     }
                                 }


                             }
                        }

                      RLSButton{
                          id:searchButton
                          enabled: false
                           text:"搜索"
                           Layout.preferredWidth:parent.width
                           onClicked: {
                               sourceModel.clear()
                               dataBase.searchDataBase()
                               for(var i = 0; i<dataBase.warningCount;i++)
                               {
                                   var strWarningType
                                   if(dataBase.getWarningType(i)==0)
                                       strWarningType="探测器报警"
                                   else
                                       strWarningType="硬盘报警"

                                   var strSeriousLevel
                                   var level=dataBase.getSeriousLevel(i)
                                   if(level==0)
                                       strSeriousLevel="一级"
                                   else if(level==1)
                                       strSeriousLevel="二级"
                                   else if(level==2)
                                       strSeriousLevel="三级"
                                   else if(level==3)
                                       strSeriousLevel="四级"
                                   else if(level==4)
                                       strSeriousLevel="五级"

                                   var strProcessType
                                   var type=dataBase.getProcessType(i)
                                   if(type==0)
                                       strProcessType="未处理"
                                   else if(type==1)
                                       strProcessType="发现已处理"
                                   else if(type==2)
                                       strProcessType="发现正常"
                                   else
                                       strProcessType="其他"

                                   dataBase.sensitiveTime = dataBase.getCurrentWarningTime(i);

                                   var strHasSensitive
                                   var hasSensitive = dataBase.getHasSensitive()

                                   if( ( hasSensitive==1 && sensitiveMenuItem2.checked ) ||  ( hasSensitive==0 && sensitiveMenuItem1.checked ) )
                                   {
                                       console.log("sens")
                                        continue;
                                   }


                                   if(hasSensitive==0)
                                       strHasSensitive=qsTr("无")
                                   else
                                       strHasSensitive=qsTr("有")

                                  sourceModel.insert(0,{
//                                  "number":i+1,
                                  "name":dataBase.getDeviceName(i),
                                  "warmingTime2":dataBase.getCurrentWarningTime(i),
                                  "countRate":dataBase.getCountRate(i),
                                  "warmingType":strWarningType,
                                  "processUser":dataBase.getStrProcessUser(i),
                                  "seriousLevel":strSeriousLevel,
                                  "coefDoseRate":dataBase.getCoefDoseRate(i).toFixed(4),
                                  "processDateTime":dataBase.getProcessDateTime(i),//new Date(dataBase.getProcessDateTime(i)),
                                  "descriptor":dataBase.getDescriptor(i),
                                  "processType":strProcessType,
                                  "sensitiveImages":strHasSensitive
                                  })
                               }
                            }

                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                          Layout.preferredHeight: 4
                      }
                      Text{

                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F4
                          color:RLSTheme.textColor.C11
                          text:qsTr("报警事件处理")
                          Layout.columnSpan: 2
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSButton{
                          id:unHandle
                          text:"未处理"
                          enabled: sourceModel.get(tableView.currentRow).processType=="未处理"?false:true
                          Layout.preferredWidth: (parent.width-60)*0.5
                          onClicked: {
                              var processTime=dataBase.getCurrentTimeForModify()
                              sourceModel.set(tableView.currentRow,{
                                                  "processType":"未处理",
                                                  "processUser":currentUserName,
                                                  "processDateTime":processTime
                                              })

                              dataBase.modifyProcessUser =sourceModel.get(tableView.currentRow).processUser

                              var warningType=sourceModel.get(tableView.currentRow).warmingType

                              if(warningType=="探测器报警")
                                  dataBase.modifyWarningType=0;
                              else
                                  dataBase.modifyWarningType=1

                              var processType=sourceModel.get(tableView.currentRow).processType

                              if(processType=="未处理")
                                 dataBase.modifyProcessType=0
                              else if(processType=="发现已处理")
                                  dataBase.modifyProcessType=1
                              else if(processType=="发现正常")
                                  dataBase.modifyProcessType=2
                              else
                                  dataBase.modifyProcessType=3

                              dataBase.modifyDeviceName=sourceModel.get(tableView.currentRow).name
                              dataBase.modifyCurWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
                              dataBase.modifiedDataBase()
                          }
                      }
                      RLSButton{
                          id:handle
                          text:"发现已处理"
                          anchors.right: parent.right
                          enabled: sourceModel.get(tableView.currentRow).processType=="发现已处理"?false:true
                          Layout.preferredWidth: (parent.width-60)*0.5
                          onClicked: {
                              var processTime=dataBase.getCurrentTimeForModify()
                              sourceModel.set(tableView.currentRow,{
                                                  "processType":"发现已处理",
                                                  "processUser":currentUserName,
                                                  "processDateTime":processTime
                                              })

                              dataBase.modifyProcessUser =sourceModel.get(tableView.currentRow).processUser

                              var warningType=sourceModel.get(tableView.currentRow).warmingType

                              if(warningType=="探测器报警")
                                  dataBase.modifyWarningType=0;
                              else
                                  dataBase.modifyWarningType=1

                              var processType=sourceModel.get(tableView.currentRow).processType

                              if(processType=="未处理")
                                 dataBase.modifyProcessType=0
                              else if(processType=="发现已处理")
                                  dataBase.modifyProcessType=1
                              else if(processType=="发现正常")
                                  dataBase.modifyProcessType=2
                              else
                                  dataBase.modifyProcessType=3

                              dataBase.modifyDeviceName=sourceModel.get(tableView.currentRow).name
                              dataBase.modifyCurWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
                              dataBase.modifiedDataBase()
                          }
//                          onClicked: {
//                               sourceModel.set(tableView.currentRow,{
//                                                   "processType":1,
//                                                   "processUser":"yi chuli "
//                                               })
//                              dataBase.strProcessUser=sourceModel.get(tableView.currentRow).processUser
//                              dataBase.processType=sourceModel.get(tableView.currentRow).processType

//                              dataBase.nWarningType=sourceModel.get(tableView.currentRow).warmingType
//                              dataBase.strDeviceName=sourceModel.get(tableView.currentRow).name
//                              dataBase.dtCurrentWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
//                              dataBase.modifiedDataBase()

//                          }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSButton{
                           id:deleteButton
                           text:"删除"
                           enabled: true
                           Layout.preferredWidth: (parent.width-60)*0.5
                           onClicked:{
//                               dataBase.nWarningType=sourceModel.get(tableView.currentRow).warmingType
//                               dataBase.strDeviceName=sourceModel.get(tableView.currentRow).name
//                               dataBase.dtCurrentWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
//                               dataBase.deleteDataBase()
                                 var warningType=sourceModel.get(tableView.currentRow).warmingType
                                 if(warningType=="探测器报警")
                                     dataBase.deleteWarningType=0
                                 else if(warningType=="硬盘报警")
                                     dataBase.deleteWarningType=1

                               dataBase.deleteDeviceName=sourceModel.get(tableView.currentRow).name
                               dataBase.deleteWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
                               dataBase.deleteDataBase()
//                               sourceModel.remove(0,1)
                               sourceModel.remove(tableView.currentRow)
                           }
                      }
                      RLSButton{
                          id:foundNomal
                          text:"发现正常"
                          enabled: sourceModel.get(tableView.currentRow).processType=="发现正常"?false:true
                          anchors.right: parent.right
                          Layout.preferredWidth: (parent.width-60)*0.5
                          onClicked: {
                              var processTime=dataBase.getCurrentTimeForModify()
                              sourceModel.set(tableView.currentRow,{
                                                  "processType":"发现正常",
                                                  "processUser":currentUserName,
                                                  "processDateTime":processTime
                                              })

                              dataBase.modifyProcessUser =sourceModel.get(tableView.currentRow).processUser

                              var warningType=sourceModel.get(tableView.currentRow).warmingType

                              if(warningType=="探测器报警")
                                  dataBase.modifyWarningType=0;
                              else
                                  dataBase.modifyWarningType=1

                              var processType=sourceModel.get(tableView.currentRow).processType

                              if(processType=="未处理")
                                 dataBase.modifyProcessType=0
                              else if(processType=="发现已处理")
                                  dataBase.modifyProcessType=1
                              else if(processType=="发现正常")
                                  dataBase.modifyProcessType=2
                              else
                                  dataBase.modifyProcessType=3

                              dataBase.modifyDeviceName=sourceModel.get(tableView.currentRow).name
                              dataBase.modifyCurWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
                              dataBase.modifiedDataBase()
                          }
//                          onClicked: {
//                               sourceModel.set(tableView.currentRow,{
//                                                   "processType":2,
//                                                   "processUser":"normal"
//                                               })
//                              dataBase.strProcessUser=sourceModel.get(tableView.currentRow).processUser
//                              dataBase.processType=sourceModel.get(tableView.currentRow).processType
//                              dataBase.nWarningType=sourceModel.get(tableView.currentRow).warmingType
//                              dataBase.strDeviceName=sourceModel.get(tableView.currentRow).name
//                              dataBase.dtCurrentWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
//                              dataBase.modifiedDataBase()
//                          }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }
                      RLSButton{
                          id:other
                          text:"其他"
                          enabled: sourceModel.get(tableView.currentRow).processType=="其他"?false:true
                          Layout.preferredWidth: (parent.width-60)*0.5
                          onClicked: {
                              var processTime=dataBase.getCurrentTimeForModify()
                              sourceModel.set(tableView.currentRow,{
                                                  "processType":"其他",
                                                  "processUser":currentUserName,
                                                  "processDateTime":processTime
                                              })

                              dataBase.modifyProcessUser =sourceModel.get(tableView.currentRow).processUser

                              var warningType=sourceModel.get(tableView.currentRow).warmingType

                              if(warningType=="探测器报警")
                                  dataBase.modifyWarningType=0;
                              else
                                  dataBase.modifyWarningType=1

                              var processType=sourceModel.get(tableView.currentRow).processType

                              if(processType=="未处理")
                                 dataBase.modifyProcessType=0
                              else if(processType=="发现已处理")
                                  dataBase.modifyProcessType=1
                              else if(processType=="发现正常")
                                  dataBase.modifyProcessType=2
                              else
                                  dataBase.modifyProcessType=3

                              dataBase.modifyDeviceName=sourceModel.get(tableView.currentRow).name
                              dataBase.modifyCurWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
                              dataBase.modifiedDataBase()
                          }
//                          onClicked: {
//                               sourceModel.set(tableView.currentRow,{
//                                                   "processType":3,
//                                                   "processUser":"qita"
//                                               })
//                              dataBase.strProcessUser=sourceModel.get(tableView.currentRow).processUser
//                              dataBase.processType=sourceModel.get(tableView.currentRow).processType

//                              dataBase.nWarningType=sourceModel.get(tableView.currentRow).warmingType
//                              dataBase.strDeviceName=sourceModel.get(tableView.currentRow).name
//                              dataBase.dtCurrentWarningTime=sourceModel.get(tableView.currentRow).warmingTime2
//                              dataBase.modifiedDataBase()
//                          }
                      }
                      RLSButton{
                          text:"统计"
                          anchors.right: parent.right
                           Layout.preferredWidth: (parent.width-60)*0.5
                           onClicked: {
                               dataBase.StatisticWarningEvent()
                           }
                      }
                      RLSConfigSeparate{
                          Layout.columnSpan: 2
                      }

                }
                ListModel{
                        id:listModel
                        ListElement{
                            name:"全部"
                        }
                        Component.onCompleted: function initListViewModel(){
                            var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                            var rs;
                            db.transaction(
                             function(tx) {
                             tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT PRIMARY KEY, password TEXT,loginTime DATE)');
                             rs = tx.executeSql('SELECT * FROM UsersInfo ORDER BY loginTime DESC');
                             for(var i=0;i<rs.rows.length;i++)
                             {
                              listModel.append(
                               {
                                "name":rs.rows.item(i).name
                               }
                             )
                             }

                             }
                                               )
                                            }//dataBase
                       }
                RLSConfigMenu{
                    id:imageRrocessUserMenu
                    dim:true
                    modal:true
                    focus: false
                    transformOrigin : Popup.Bottom
                    leftPadding:210
                    //height:88*allUserCount
                    y:parent.height-imageRrocessUserMenu.height


                    Column{
                        spacing: 1
                    Repeater{
                        id:menuRepeater
                        model:listModel
                         delegate: RLSConfigMenuItem{
                          id:menuItemDelegate
                          text:name
                          autoExclusive : true
                          checkable:true
                          checked: index==1?true:false
                          onTriggered:{

                                   searchProcessUser.text=menuItemDelegate.text
                                   dataBase.keyProcessUser=menuItemDelegate.text
                                   imageRrocessUserMenu.close()
                                   searchProcessUser.forceActiveFocus();
                                                    }
                      }

                        }
                    }
                    }

//                    RLSConfigMenuItem{
//                        id:warningProcessUserMenuItem1
//                        text:qsTr("admin")
//                        autoExclusive : true
//                        checkable:true
//                        checked:true
//                        onTriggered:{
//                            searchProcessUser.text="admin"
//                            dataBase.keyProcessUser="admin"
//                          }
//                    }
//                    RLSConfigMenuItem{
//                        id:warningProcessUserMenuItem2
//                        text:qsTr("全部")
//                        autoExclusive : true
//                        checkable:true
//                        onTriggered:{
//                            searchProcessUser.text="全部"
//                            dataBase.keyProcessUser="All users"
//                          }
//                    }
//                }
                RLSConfigMenu{
                    id:imageWarningProcessTypeMenu
                    dim:true
                    focus: false
                    modal:true
                    leftPadding:210
                    transformOrigin : Popup.Bottom
                    onClosed:searchWarningProcessType.forceActiveFocus()
                    y:parent.height-imageWarningProcessTypeMenu.height
                    RLSConfigMenuItem{
                        id:warningProcessTypeMenuItem1
                        text:qsTr("未处理")
                        autoExclusive : true
                        checkable:true
                        checked:true

                        onTriggered:{
                            searchWarningProcessType.text= warningProcessTypeMenuItem1.text
                            dataBase.keyWarningProcessType=0

                          }
                    }
                    RLSConfigMenuItem{
                        id:warningProcessTypeMenuItem2
                        text:qsTr("发现已处理")
                        autoExclusive:true
                        checkable:true

                        onTriggered:{
                            searchWarningProcessType.text= warningProcessTypeMenuItem2.text
                            dataBase.keyWarningProcessType=1

                          }
                    }
                    RLSConfigMenuItem{
                        id:warningProcessTypeMenuItem3
                        text:qsTr("发现正常")
                        autoExclusive:true

                        checkable:true
                        onTriggered:{
                            searchWarningProcessType.text= warningProcessTypeMenuItem3.text
                            dataBase.keyWarningProcessType=2

                          }
                    }
                    RLSConfigMenuItem{
                        id:warningProcessTypeMenuItem4
                        text:qsTr("其他")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningProcessType.text= warningProcessTypeMenuItem4.text
                            dataBase.keyWarningProcessType=3

                          }
                    }
                    RLSConfigMenuItem{
                        id:warningProcessTypeMenuItem5
                        text:qsTr("全部")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningProcessType.text= warningProcessTypeMenuItem5.text
                            dataBase.keyWarningProcessType=4

                          }
                    }
                }
                RLSConfigMenu{
                    id:imageWarningTypeMenu
                    dim:true
                    modal:true
                    focus: false
                    leftPadding:210
                    transformOrigin : Popup.Bottom
                    y:parent.height-imageWarningTypeMenu.height
                    onClosed:searchWarningType.forceActiveFocus()
                    RLSConfigMenuItem{
                        id:warningTypeMenuItem1
                        text:qsTr("探测器报警")

                        autoExclusive : true
                        checkable:true
                        checked:true
                        onTriggered:{
                            searchWarningType.text= warningTypeMenuItem1.text
                            dataBase.keyWarningType=0

                          }
                    }
                    RLSConfigMenuItem{
                        id:warningTypeMenuItem2
                        text:qsTr("硬盘报警")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningType.text= warningTypeMenuItem2.text
                            dataBase.keyWarningType=1       
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningTypeMenuItem3
                        text:qsTr("全部")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningType.text= warningTypeMenuItem3.text
                            dataBase.keyWarningType=2
                          }
                    }
                }
                RLSConfigMenu{
                    id:imageWarningLevelMenu
                    dim:true
                    modal:true
                    focus: false
                    leftPadding:210
                    transformOrigin : Popup.Bottom
                    onClosed:searchWarningLevel.forceActiveFocus()
                    y:parent.height-imageWarningProcessTypeMenu.height
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem1
                        text:qsTr("一级")

                        autoExclusive : true
                        checkable:true
                        checked:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem1.text
                            dataBase.keySeriousLevel=0
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem2
                        text:qsTr("二级")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem2.text
                            dataBase.keySeriousLevel=1
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem3
                        text:qsTr("三级")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem3.text
                            dataBase.keySeriousLevel=2
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem4
                        text:qsTr("四级")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem4.text
                            dataBase.keySeriousLevel=3
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem5
                        text:qsTr("五级")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem5.text
                            dataBase.keySeriousLevel=4
                          }
                    }
                    RLSConfigMenuItem{
                        id:warningLevelMenuItem6
                        text:qsTr("全部")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchWarningLevel.text= warningLevelMenuItem6.text
                            dataBase.keySeriousLevel=5
                          }
                    }
                }
                RLSConfigMenu{
                    id:imageSensitiveMenu
                    dim:true
                    modal:true
                    leftPadding:210
                    focus: false
                    transformOrigin : Popup.Bottom
                    onClosed:searchSentive.forceActiveFocus()
                    y:parent.height-imageSensitiveMenu.height
                    RLSConfigMenuItem{
                        id:sensitiveMenuItem1
                        text:qsTr("有")

                        autoExclusive : true
                        checkable:true
                        onTriggered:{
                            searchSentive.text= sensitiveMenuItem1.text
                          }
                    }
                    RLSConfigMenuItem{
                        id:sensitiveMenuItem2
                        text:qsTr("无")

                        autoExclusive:true
                        checkable:true
                        checked:true
                        onTriggered:{
                            searchSentive.text= sensitiveMenuItem2.text
                          }
                    }
                    RLSConfigMenuItem{
                        id:sensitiveMenuItem3
                        text:qsTr("全部")

                        autoExclusive:true
                        checkable:true
                        onTriggered:{
                            searchSentive.text= sensitiveMenuItem3.text
                          }
                    }
                }
                RLSPopup{
                    id:calendar
                    dim:true
                    modal:true
                    leftPadding:10
                    height:searchTime.height
                    transformOrigin : Popup.Bottom
                    y:parent.height-10-searchTime.height
                    TableControl.Calendar{
                       id:searchTime
                       visible: true
                       width:340
                       height:364
                       frameVisible: true
                       property int choice: 1
                       onClicked: {
                           if(choice==1)
                           {
                               startTime.text= Qt.formatDateTime(date,"yyyy-MM-dd")
                               dataBase.keyStartTime=date
                           }
                           else
                           {
                               endTime.text= Qt.formatDateTime(date,"yyyy-MM-dd")
                               dataBase.keyEndTime=date
                           }
                           calendar.close()
                       }
                       style:CalendarStyle{
                          dayDelegate:Rectangle{
                              color: styleData.date !== undefined && styleData.selected ? "#68b5ae" : "transparent"
                              implicitWidth: 48
                              implicitHeight: 48
                              Label {
                                  text: styleData.date.getDate()
                                  font.family:RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F4
                                  anchors.centerIn: parent
                                  color: {
                                      var theColor = RLSTheme.textColor.C9;
                                      if (styleData.valid) {
                                          // Date is within the valid range.
                                          theColor = styleData.visibleMonth ? RLSTheme.textColor.C8 : RLSTheme.textColor.C11;
                                          if (styleData.selected)
                                              theColor = "white";
                                      }
                                      theColor;
                                  }
                              }

                          }//dayDelegate:
                        dayOfWeekDelegate:Rectangle{
                            color: gridVisible ? "white" : "transparent"
                            implicitHeight: 20
                            Label {
                                font.family:RLSTheme.fontFamily
                                font.pixelSize: 12
                                color: RLSTheme.textColor.C8
                                text: control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
                                anchors.centerIn: parent
                            }
                        }

                        navigationBar:Rectangle{
                            height: 48
                            color: "white"
                            Rectangle {
                                color: Qt.rgba(1,1,1,0.6)
                                height: 1
                                width: parent.width
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                height: 1
                                width: parent.width
                                color: "#ddd"
                            }
                            RLSHoverButton{
                                id: previousMonth
                                width: parent.height
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                source: "../icons/secMenuLeft.png"
                                onClicked: control.showPreviousMonth()
                            }
                            Label {
                                id: dateText
                                text: styleData.title
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: RLSTheme.fontSize.F3
                                font.family: RLSTheme.fontFamily
                                //anchors.centerIn: parent
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: previousMonth.right
                                anchors.leftMargin: 2
                                anchors.right: nextMonth.left
                                anchors.rightMargin: 2
                            }
                            RLSHoverButton{
                                id: nextMonth
                                width: parent.height
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                source: "../icons/secMenu.png"
                                onClicked: control.showNextMonth()
                            }

                        }


                       }

                    }
                }
                RLSPopup{
                    id:calendar1
                    dim:true
                    modal:true
                    leftPadding:10
                    height:searchTime.height
                    transformOrigin : Popup.Bottom
                    y:parent.height-10-searchTime1.height
                    TableControl.Calendar{
                       id:searchTime1
                       visible: true
                       frameVisible: true
                       width:340
                       height:364
                       property int choice: 2
                       onClicked: {
                           if(choice==1)
                           {
                               startTime.text= Qt.formatDateTime(date,"yyyy-MM-dd")
                               dataBase.keyStartTime=date
                           }
                           else
                           {
                               endTime.text= Qt.formatDateTime(date,"yyyy-MM-dd")
                               dataBase.keyEndTime=date
                           }

                           calendar1.close()

                       }

                       style:CalendarStyle{
                          dayDelegate:Rectangle{
                              color: styleData.date !== undefined && styleData.selected ? "#68b5ae" : "transparent"
                              implicitWidth: 48
                              implicitHeight: 48
                              Label {
                                  text: styleData.date.getDate()
                                  font.family:RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F4
                                  anchors.centerIn: parent
                                  color: {
                                      var theColor = RLSTheme.textColor.C9;
                                      if (styleData.valid) {
                                          // Date is within the valid range.
                                          theColor = styleData.visibleMonth ? RLSTheme.textColor.C8 : RLSTheme.textColor.C11;
                                          if (styleData.selected)
                                              theColor = "white";
                                      }
                                      theColor;
                                  }
                              }

                          }//dayDelegate:
                        dayOfWeekDelegate:Rectangle{
                            color: gridVisible ? "white" : "transparent"
                            implicitHeight: 20
                            Label {
                                font.family:RLSTheme.fontFamily
                                font.pixelSize: 12
                                color: RLSTheme.textColor.C8
                                text: control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
                                anchors.centerIn: parent
                            }
                        }

                        navigationBar:Rectangle{
                            height: 48
                            color: "white"
                            Rectangle {
                                color: Qt.rgba(1,1,1,0.6)
                                height: 1
                                width: parent.width
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                height: 1
                                width: parent.width
                                color: "#ddd"
                            }
                            RLSHoverButton{
                                id: previousMonth1
                                width: parent.height
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                source: "../icons/secMenuLeft.png"
                                onClicked: control.showPreviousMonth()
                            }
                            Label {
                                id: dateText1
                                text: styleData.title
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: RLSTheme.fontSize.F3
                                font.family: RLSTheme.fontFamily
                                //anchors.centerIn: parent
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: previousMonth1.right
                                anchors.leftMargin: 2
                                anchors.right: nextMonth1.left
                                anchors.rightMargin: 2
                            }
                            RLSHoverButton{
                                id: nextMonth1
                                width: parent.height
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                source: "../icons/secMenu.png"
                                onClicked: control.showNextMonth()
                            }

                        }


                       }

                    }
                }


            }           
        }
  }
}
