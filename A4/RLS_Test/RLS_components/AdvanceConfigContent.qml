import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import AdvanceConfig 1.0
import QtQuick.Dialogs 1.2
import QtQuick.VirtualKeyboard 2.1
import UserManager 1.0
import QtQuick.LocalStorage 2.0
import "../RLSTheme"
import "../Lib/MaterialUI/Interface"
Item {
    anchors.fill: parent
    property int leftMargin: 20
    property int rightMargin: 20
    property var componentModel: [
        {name:qsTr("用户管理"),icon:"accountAD",component:accountManagement},
        {name:qsTr("定位仪"),icon:"positioningAD",component:positioningManagement},
        {name:qsTr("报警参数"),icon:"CautionAD",component:cautionManagement},
        {name:qsTr("系统恢复"),  icon:"RestoreAD",component:systemRestore}
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
        id:accountManagement
        Rectangle{
            id:accountManagementContent
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
            function addNewUser(){
                 var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                db.transaction(
                            function(tx){
                                tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT, password TEXT,loginTime DATE)');
                                 tx.executeSql('INSERT INTO UsersInfo VALUES(?, ?, ?)', [ userManager.name, userManager.password,new Date(new Date().setFullYear(1970)) ]);

                            }
                            )
            }

            function listAllUser(){
                var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
               db.transaction(
                           function(tx){
                               tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT, password TEXT,loginTime DATE)');
                                //tx.executeSql('INSERT INTO Greeting VALUES(?, ?)', [ userManager.name, userManager.password ]);
                               var rs = tx.executeSql('SELECT * FROM UsersInfo');

                                                    var r = ""
                                                    for(var i = 0; i < rs.rows.length; i++) {
                                                        r += rs.rows.item(i).name + ", " + rs.rows.item(i).password + "\n"
                                                        console.log(r)
                                                    }

                           }
                           )

            }
            function deleteUser(){
                var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                db.transaction(
                            function(tx){
                                tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT, password TEXT,loginTime DATE)');
                                 tx.executeSql('DELETE FROM UsersInfo WHERE name=?',userManager.name);
                                var rs = tx.executeSql('SELECT * FROM UsersInfo');

                                                     var r = ""
                                                     for(var i = 0; i < rs.rows.length; i++) {
                                                         r += rs.rows.item(i).name + ", " + rs.rows.item(i).password + "\n"
                                                         console.log(r)
                                                     }

                            }
                            )
            }
            function modifyUser(){
                var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                db.transaction(
                            function(tx){
                                tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT, password TEXT,loginTime DATE)');
                                tx.executeSql('UPDATE UsersInfo SET password=? WHERE name=?',[userManager.password,userManager.name]);
                                var rs = tx.executeSql('SELECT * FROM UsersInfo');

                                                     var r = ""
                                                     for(var i = 0; i < rs.rows.length; i++) {
                                                         r += rs.rows.item(i).name + ", " + rs.rows.item(i).password + "\n"
                                                         console.log(r)
                                                     }

                            }
                            )
            }
            UserManager{
                id:userManager

            }
            GridLayout{
                  id:cameraInfoPopupGridLayout
                  anchors.left: parent.left
                  anchors.leftMargin: 20
                  width:560
                  columns: 2
                  rowSpacing: 22
                  RLSConfigSeparate{
                       Layout.columnSpan: 2
                  }
                 RLSConfigLabel{
                     text:qsTr("添加新用户")
                     Layout.columnSpan: 2
                  }
                 RLSConfigSeparate{
                      Layout.columnSpan: 2
                 }
                  RLSConfigLabel{
                      text:qsTr("用户名")
                  }
                  RLSConfigTextInput{
                      id:userName
                      font.family: RLSTheme.fontFamily
                      font.pixelSize: RLSTheme.fontSize.F3
                      color:RLSTheme.textColor.C10
                      Layout.preferredWidth:370
                      anchors.right: parent.right
                      onEditingFinished: {
                          var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                          db.transaction(
                                      function(tx){
                                         tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT, password TEXT,loginTime DATE)');
                                          var rs = tx.executeSql('SELECT name FROM UsersInfo WHERE name=?',userName.text);
                                          if( rs.rows.length>0){
                                                 newButton.enabled=false
                                                 tips.open(qsTr("用户已存在，只可修改密码"))
                                                 modifyButton.enabled=true
                                          }
                                      }
                                      )
                      }
                  }
                  RLSConfigSeparate{
                       Layout.columnSpan: 2
                  }
                  RLSConfigLabel{
                      text:qsTr("密码")
                  }
                  RLSConfigTextInput{
                      font.family: RLSTheme.fontFamily
                      font.pixelSize: RLSTheme.fontSize.F3
                       color:RLSTheme.textColor.C10
                      id:password
                      Layout.preferredWidth:370
                      anchors.right: parent.right
                      validator: RegExpValidator { regExp: /^[A-Za-z0-9]+$/ }


                  }
                  RLSConfigSeparate{
                       Layout.columnSpan: 2
                  }
                  RLSButton{
                      id:newButton
                      text:qsTr("新建")
                      enabled:userName.length>0&& password.length>0
                      anchors.left: parent.left
                      onClicked:{
                          userManager.name=userName.text
                          userManager.password=password.text
                          addNewUser()
                          tips.open(qsTr("用户已创建!!"))
                          userName.clear()
                          password.clear()
                      }
                  }
                  RLSButton{
                      id:modifyButton
                      text:qsTr("修改")
                      enabled: false
                      anchors.right: parent.right
                      onClicked:{
                           userManager.name=userName.text
                           userManager.password=password.text
                           modifyUser()
                           tips.open(qsTr("用户密码已修改!!"))
                          userName.clear()
                          password.clear()
                      }

                  }
                  RLSConfigSeparate{
                       Layout.columnSpan: 2
                  }
                 RLSConfigLabel{
                     text:qsTr("删除用户")
                     Layout.columnSpan: 2
                  }
                 RLSConfigSeparate{
                      Layout.columnSpan: 2
                 }
                 RLSConfigLabel{
                     text:qsTr("用户名")
                 }
                 RLSConfigTextInput{
                     font.family: RLSTheme.fontFamily
                     font.pixelSize: RLSTheme.fontSize.F3
                     color:RLSTheme.textColor.C10
                     id:deleteName
                     Layout.preferredWidth:370
                     anchors.right: parent.right
                 }
                 RLSConfigSeparate{
                      Layout.columnSpan: 2
                 }
                 RLSButton{
                     text:qsTr("删除")
                     anchors.left: parent.left
                     onClicked: {
                         userManager.name=deleteName.text
                         deleteUser()
                         tips.open(qsTr("用户已删除!!"))
                         userName.clear()
                         password.clear()

                     }
                 }
                 RLSButton{
                     text:qsTr("取消")
                     anchors.right: parent.right
                 }
                 RLSConfigSeparate{
                      Layout.columnSpan: 2
                 }


            }

            InputPanel {
                id: inputPanelUserInfoInfoSetting //cameraInfoPopup
                z: 99
                y: accountManagementContent.height
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
                    when: inputPanelUserInfoInfoSetting.active
                    PropertyChanges {
                        target: inputPanelUserInfoInfoSetting
                        y: accountManagementContent.height - inputPanelUserInfoInfoSetting.height
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
    Component{
        id:positioningManagement
        Rectangle{
            id:positioningManagementContent
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
            AdvanceConfig{
                id:advanceConfig
            }

            ColumnLayout{
                spacing:0
                RLSConfigButton{
                    id:cameraInfo
                    text:qsTr("摄像头")
                    checkable: true
                    //checked: true
                    autoExclusive : true
                   onClicked:cameraInfoPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
                RLSConfigButton{
                    id:dectorInfo
                    text:qsTr("探测器")
                    checkable: true
                    autoExclusive : true
                    onClicked:dectorInfoPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
            }
        RLSPopup{
            id:cameraInfoPopup
            width:600
            height: 1014
            x:parent.width
            leftPadding: 1
            transformOrigin: Popup.TopLeft
            Rectangle{
                anchors.fill: parent
                color:RLSTheme.backgroundColor.C6
                GridLayout{
                      id:cameraInfoPopupGridLayout
                      anchors.left: parent.left
                      anchors.leftMargin: 20
                      width:560
                      columns: 2
                      rowSpacing: 22
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("IP地址")
                      }
                      RLSConfigTextInput{

                          id:cameraIP
                          validator: RegExpValidator { regExp: /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/ }
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          Layout.preferredWidth:370
                          anchors.right: parent.right
                           inputMethodHints: Qt.ImhDigitsOnly
                          placeholderText :cameraIP.activeFocus?"":advanceConfig.cameraIP
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:cameraIP.length>0||cameraIP.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              cameraIP.focus=false
                              advanceConfig.cameraIP=cameraIP.text
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")

                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("用户名")
                      }
                      RLSConfigTextInput{
                          id:cameraUserName
                          Layout.preferredWidth:370
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          placeholderText :cameraUserName.activeFocus?"":advanceConfig.cameraUserName
                         // inputMethodHints: Qt.ImhFormattedNumbersOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:cameraUserName.length>0||cameraUserName.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              cameraUserName.focus=false
                              advanceConfig.cameraUserName=cameraUserName.text
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("密码")
                      }
                      RLSConfigTextInput{
                          id:cameraPassword
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          Layout.preferredWidth:370
                          anchors.right: parent.right
                          placeholderText :cameraPassword.activeFocus?"":advanceConfig.cameraPassword
                          inputMethodHints: Qt.ImhHiddenText
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:cameraPassword.length>0||cameraPassword.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              cameraPassword.focus=false
                              advanceConfig.cameraPassword=cameraPassword.text
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("端口设置")
                      }
                      RLSConfigTextInput{
                          id:cameraPort
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          placeholderText :cameraPort.activeFocus?"":advanceConfig.cameraPort
                          inputMethodHints: Qt.ImhDigitsOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:cameraPort.length>0||cameraPort.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              cameraPort.focus=false
                              advanceConfig.cameraPort=Number(cameraPort.text)
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("可见光宽度")
                          }
                          RLSConfigTextInput{
                              id:cameraWidth
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              placeholderText :cameraWidth.activeFocus?"":advanceConfig.cameraWidth
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:cameraWidth.length>0||cameraWidth.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  cameraPort.focus=false
                                  advanceConfig.cameraWidth=Number(cameraWidth.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("可见光高度")
                          }
                          RLSConfigTextInput{
                              id:cameraHeight
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              placeholderText :cameraHeight.activeFocus?"":advanceConfig.cameraHeight
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:cameraHeight.length>0||cameraHeight.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  cameraHeight.focus=false
                                  advanceConfig.cameraHeight=Number(cameraHeight.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("可见光频率")
                      }
                      RowLayout{
                          spacing: 6
                          anchors.right: parent.right
                          RLSConfigTextInput{
                              id:cameraFrameRate
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              placeholderText :cameraFrameRate.activeFocus?"":advanceConfig.cameraFrameRate
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:cameraFrameRate.length>0||cameraFrameRate.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  cameraFrameRate.focus=false
                                  advanceConfig.cameraFrameRate=Number(cameraFrameRate.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                          RLSConfigLabel{
                              text:qsTr("帧/秒")
                          }
                     }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("可见光延迟")
                      }
                      RowLayout{
                          spacing: 6
                          anchors.right: parent.right
                          RLSConfigTextInput{
                              id:cameraDelay
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              placeholderText :cameraDelay.activeFocus?"":advanceConfig.cameraDelay
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:cameraDelay.length>0||cameraDelay.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  cameraDelay.focus=false
                                  advanceConfig.cameraDelay=Number(cameraDelay.text)
                                  advanceConfig.updateAllConfig()
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
           }
            InputPanel {
                id: inputPanelcameraInfoSetting //cameraInfoPopup
                z: 99
                y: cameraInfoPopup.height
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
                    when: inputPanelcameraInfoSetting.active
                    PropertyChanges {
                        target: inputPanelcameraInfoSetting
                        y: cameraInfoPopup.height - inputPanelcameraInfoSetting.height
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
     }//popup

        RLSPopup{
            id:dectorInfoPopup
            width:600
            height: 1014
            x:parent.width
            leftPadding: 1
            transformOrigin: Popup.TopLeft
            Rectangle{
                anchors.fill: parent
                color:RLSTheme.backgroundColor.C6
                GridLayout{
                      id:dectorInfoPopupGridLayout
                      anchors.left: parent.left
                      anchors.leftMargin: 20
                      width:560
                      columns: 2
                      rowSpacing: 22
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("IP地址")
                      }
                      RLSConfigTextInput{
                          Layout.preferredWidth:370
                          anchors.right: parent.right
                          id:spectIP
                           inputMethodHints:Qt.ImhDigitsOnly
                          validator: RegExpValidator {
                              regExp:/^((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d)(\.((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d)){3}$/
                             // regExp: /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
                          }
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          placeholderText :spectIP.activeFocus?"":advanceConfig.spectIP
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:spectIP.length>0||spectIP.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              spectIP.focus=false
                              advanceConfig.spectIP=spectIP.text
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("数据端口")
                      }
                      RLSConfigTextInput{
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          id:spectDataPort
                          placeholderText :spectDataPort.activeFocus?"":advanceConfig.spectDataPort
                          inputMethodHints: Qt.ImhDigitsOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:spectDataPort.length>0||spectDataPort.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              spectDataPort.focus=false
                              advanceConfig.spectDataPort=Number(spectDataPort.text)
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("命令端口")
                      }
                      RLSConfigTextInput{
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          id:spectCmdPort
                          placeholderText :spectCmdPort.activeFocus?"":advanceConfig.spectCmdPort
                          inputMethodHints: Qt.ImhDigitsOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:spectCmdPort.length>0||spectCmdPort.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              spectCmdPort.focus=false
                              advanceConfig.spectCmdPort=Number(spectCmdPort.text)
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("工程师端口")
                      }
                      RLSConfigTextInput{
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          id:spectEngineerPort
                          placeholderText :spectEngineerPort.activeFocus?"":advanceConfig.spectEngineerPort
                          inputMethodHints: Qt.ImhDigitsOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:spectEngineerPort.length>0||spectEngineerPort.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              spectEngineerPort.focus=false
                              advanceConfig.spectEngineerPort=Number(spectEngineerPort.text)
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RLSConfigLabel{
                          text:qsTr("缓冲区长度")
                      }
                      RLSConfigTextInput{
                          font.family: RLSTheme.fontFamily
                          font.pixelSize: RLSTheme.fontSize.F3
                          color:RLSTheme.textColor.C10
                          anchors.right: parent.right
                          id:spectBufLen
                          placeholderText :spectBufLen.activeFocus?"":advanceConfig.spectBufLen
                          inputMethodHints: Qt.ImhDigitsOnly
                          EnterKeyAction.actionId:EnterKeyAction.Next
                          EnterKeyAction.enabled:spectBufLen.length>0||spectBufLen.inputMethodComposing?true:false
                          onEnterKeyClicked:{
                              spectBufLen.focus=false
                              advanceConfig.spectBufLen=Number(spectBufLen.text)
                              advanceConfig.updateAllConfig()
                              tips.open("设置已保存！！")
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("重建图像宽度")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:reconImageWidth
                              placeholderText :reconImageWidth.activeFocus?"":advanceConfig.reconImageWidth
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:reconImageWidth.length>0||reconImageWidth.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  reconImageWidth.focus=false
                                  advanceConfig.reconImageWidth=Number(reconImageWidth.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("重建图像长度")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:reconImageHeight
                              placeholderText :reconImageHeight.activeFocus?"":advanceConfig.reconImageHeight
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:reconImageHeight.length>0||reconImageHeight.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  reconImageHeight.focus=false
                                  advanceConfig.reconImageHeight=Number(reconImageHeight.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("能窗低值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              Layout.fillWidth: true
                              id:energyLow
                              placeholderText :energyLow.activeFocus?"":advanceConfig.energyLow
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:energyLow.length>0||energyLow.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  energyLow.focus=false
                                  advanceConfig.energyLow=Number(energyLow.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("能窗高值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:energyHigh
                              placeholderText :energyHigh.activeFocus?"":advanceConfig.energyHigh
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:energyHigh.length>0||energyHigh.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  energyHigh.focus=false
                                  advanceConfig.energyHigh=Number(energyHigh.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }

                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("X+低阈值")

                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              Layout.fillWidth: true
                              id:x1LowThreshold
                              placeholderText :x1LowThreshold.activeFocus?"":advanceConfig.x1LowThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:x1LowThreshold.length>0||x1LowThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  x1LowThreshold.focus=false
                                  advanceConfig.x1LowThreshold=Number(x1LowThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("X+高阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:x1HighThreshold
                              placeholderText :x1HighThreshold.activeFocus?"":advanceConfig.x1HighThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:x1HighThreshold.length>0||x1HighThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  x1HighThreshold.focus=false
                                  advanceConfig.x1HighThreshold=Number(x1HighThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("X-低阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              Layout.fillWidth: true
                              id:x2LowThreshold
                              placeholderText :x2LowThreshold.activeFocus?"":advanceConfig.x2LowThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:x2LowThreshold.length>0||x2LowThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  x2LowThreshold.focus=false
                                  advanceConfig.x2LowThreshold=Number(x2LowThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("X-高阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:x2HighThreshold
                              placeholderText :x2HighThreshold.activeFocus?"":advanceConfig.x2HighThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:x2HighThreshold.length>0||x2HighThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  x2HighThreshold.focus=false
                                  advanceConfig.x2HighThreshold=Number(x2HighThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("Y+低阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              Layout.fillWidth: true
                              id:y1LowThreshold
                              placeholderText :y1LowThreshold.activeFocus?"":advanceConfig.y1LowThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:y1LowThreshold.length>0||y1LowThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  y1LowThreshold.focus=false
                                  advanceConfig.y1LowThreshold=Number(y1LowThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("Y+高阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:y1HighThreshold
                              placeholderText :y1HighThreshold.activeFocus?"":advanceConfig.y1HighThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:y1HighThreshold.length>0||y1HighThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  y1HighThreshold.focus=false
                                  advanceConfig.y1HighThreshold=Number(y1HighThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }
                      RowLayout{
                          anchors.left: parent.left
                          RLSConfigLabel{
                              text:qsTr("Y-低阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              Layout.fillWidth: true
                              id:y2LowThreshold
                              placeholderText :y2LowThreshold.activeFocus?"":advanceConfig.y2LowThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:y2LowThreshold.length>0||y2LowThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  y2LowThreshold.focus=false
                                  advanceConfig.y2LowThreshold=Number(y2LowThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RowLayout{
                          anchors.right: parent.right
                          RLSConfigLabel{
                              text:qsTr("y-高阈值")
                          }
                          RLSConfigTextInput{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              id:y2HighThreshold
                              placeholderText :y2HighThreshold.activeFocus?"":advanceConfig.y2HighThreshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:y2HighThreshold.length>0||y2HighThreshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  y2HighThreshold.focus=false
                                  advanceConfig.y2HighThreshold=Number(y2HighThreshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
                              }
                          }
                      }
                      RLSConfigSeparate{
                           Layout.columnSpan: 2
                      }

                }
            }
            InputPanel {
                id: inputPaneldectorInfoSetting //dectorInfoPopup
                z: 99
                y: dectorInfoPopup.height
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
                    when: inputPaneldectorInfoSetting.active
                    PropertyChanges {
                        target: inputPaneldectorInfoSetting
                        y: dectorInfoPopup.height - inputPaneldectorInfoSetting.height
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
   }//rectangle
}
    Component{
        id:cautionManagement
        Rectangle{
            id:cautionManagementContent
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
            AdvanceConfig{
                id:advanceConfig
                onCurrentModelModifiedChanged: console.log("CurrentModelModifiedChanged!!")
            }

            ColumnLayout{
                spacing:0
                RLSConfigButton{
                    id:alarmModeConfig
                    text:qsTr("报警模式参数")
                    checkable: true
                    //checked: true
                    autoExclusive : true
                   onClicked:alarmModeConfigPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
                RLSConfigButton{
                    id:alarmLevel
                    text:qsTr("报警级别")
                    checkable: true
                    autoExclusive : true
                    onClicked:alarmLevelPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
                RLSConfigButton{
                    id:alarmSoundControl
                    text:qsTr("报警时间控制")
                    checkable: true
                    autoExclusive : true
                    onClicked:alarmSoundPopup.open()
                }
                RLSConfigSeparate{
                    Layout.preferredWidth : parent.width
                }
            }
            RLSPopup{
                id:alarmModeConfigPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    anchors.fill: parent
                    color:RLSTheme.backgroundColor.C6
                    GridLayout{
                          id:dectorInfoPopupGridLayout
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
                               id:currentModel
                               readOnly: true
                               Layout.preferredWidth: 370
                               anchors.right: parent.right
                               cursorVisible: false
                               font.family: RLSTheme.fontFamily
                               font.pixelSize: RLSTheme.fontSize.F3
                               color:RLSTheme.textColor.C10
                               imageSource:"../icons/down.png"
                               onPopupOpen: currentModelMenu.open()
                               Component.onCompleted: {
                                   advanceConfig.setCurrentModelModify(1)
                                   currentModel.text=menuItem1.text
                               }
                          }
                          RLSConfigSeparate{
                               Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("计数率模式")
                          }

                          RLSTextField{
                              id:countRateModel
                              readOnly: true
                               Layout.preferredWidth: 370
                              anchors.right: parent.right
                              cursorVisible: false
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              imageSource:"../icons/down.png"
                              //placeholderText: advanceConfig.countRateType
                              onPopupOpen: countRateModelMenu.open()
                              Component.onCompleted: function initText(){
                                  switch(advanceConfig.countRateType)
                                  {
                                  case 0:
                                      countRateModel.text=qsTr("实时计数率");break;
                                  case 1:
                                      countRateModel.text=qsTr("平均计数率");break;
                                  case 2:
                                      countRateModel.text=qsTr("全部计数率");break;
                                  }
                                  advanceConfig.setCurrentModelModify(1)
                                  currentModel.text=menuItem6.text

                              }

                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("报警计数率")
                          }
                          RowLayout{
                              anchors.right: parent.right
                              spacing: 6
                              RLSConfigTextInput{
                                  validator: IntValidator{bottom: 0; top: 10000000;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  color:RLSTheme.textColor.C10
                                 id:warningCountRate
                                 placeholderText :warningCountRate.activeFocus?"":advanceConfig.warningCountRate
                                 inputMethodHints: Qt.ImhDigitsOnly
                                 EnterKeyAction.actionId:EnterKeyAction.Next
                                 EnterKeyAction.enabled:warningCountRate.length>0||warningCountRate.inputMethodComposing?true:false
                                 onEnterKeyClicked:{
                                     warningCountRate.focus=false
                                     advanceConfig.warningCountRate=Number(warningCountRate.text)
                                     advanceConfig.updateAllConfig()
                                     tips.open("设置已保存！！")
                                     warningCountRate.clear()
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
                              anchors.right: parent.right
                              spacing: 6
                              RLSConfigTextInput{
                                  validator: IntValidator{bottom: 0; top: 10000000;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  color:RLSTheme.textColor.C10
                                  id:trackCountRate
                                  placeholderText :trackCountRate.activeFocus?"":advanceConfig.trackCountRate
                                  inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:EnterKeyAction.Next
                                  EnterKeyAction.enabled:trackCountRate.length>0||trackCountRate.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      trackCountRate.focus=false
                                      advanceConfig.trackCountRate=Number(trackCountRate.text)
                                      advanceConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                      trackCountRate.clear()
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
                              anchors.right: parent.right
                              spacing: 6
                              RLSConfigTextInput{
                                  validator: IntValidator{bottom: 0; top: 3600000;}
                                  font.family: RLSTheme.fontFamily
                                  font.pixelSize: RLSTheme.fontSize.F3
                                  color:RLSTheme.textColor.C10
                                  id:countRateTime
                                  enabled:advanceConfig.countRateType==0?false:true
                                  placeholderText :countRateTime.activeFocus?"":advanceConfig.countRateTime
                                  inputMethodHints: Qt.ImhDigitsOnly
                                  EnterKeyAction.actionId:EnterKeyAction.Next
                                  EnterKeyAction.enabled:countRateTime.length>0||countRateTime.inputMethodComposing?true:false
                                  onEnterKeyClicked:{
                                      countRateTime.focus=false
                                      advanceConfig.countRateTime=Number(countRateTime.text)
                                      advanceConfig.updateAllConfig()
                                      tips.open("设置已保存！！")
                                      countRateTime.clear()
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
                        id:currentModelMenu
                        dim:true
                        modal:true
                        focus:false
                        transformOrigin : Popup.Bottom
                        y:parent.height-10-currentModelMenu.height
                        x:parent.x+11
                        RLSConfigMenuItem{
                            id:menuItem1
                            text:qsTr("旅检模式")
                            autoExclusive : true
                            checkable:true
                            checked: true
                            onTriggered: {
                                currentModel.text=menuItem1.text
                                advanceConfig.setCurrentModelModify(1)
                                switch(advanceConfig.countRateType)
                                {
                                case 0:
                                    countRateModel.text=qsTr("实时计数率");break;
                                case 1:
                                    countRateModel.text=qsTr("平均计数率");break;
                                case 2:
                                    countRateModel.text=qsTr("全部计数率");break;
                                }

                                tips.open(qsTr("已选择")+menuItem1.text+qsTr("模式"))
                            }
                        }
                        RLSConfigMenuItem{
                            id:menuItem2
                            text:qsTr("核爆模式")
                            autoExclusive : true
                            checkable:true
                            onTriggered: {
                                currentModel.text=menuItem2.text
                                advanceConfig.setCurrentModelModify(4)
                                switch(advanceConfig.countRateType)
                                {
                                case 0:
                                    countRateModel.text=qsTr("实时计数率");break;
                                case 1:
                                    countRateModel.text=qsTr("平均计数率");break;
                                case 2:
                                    countRateModel.text=qsTr("全部计数率");break;
                                }

                                tips.open(qsTr("已选择")+menuItem2.text+qsTr("模式"))
                            }
                        }
                        RLSConfigMenuItem{
                            id:menuItem3
                            text:qsTr("演示模式")
                            autoExclusive : true
                            checkable:true
                            onTriggered:{
                                currentModel.text=menuItem3.text
                                advanceConfig.setCurrentModelModify(5)
                                switch(advanceConfig.countRateType)
                                {
                                case 0:
                                    countRateModel.text=qsTr("实时计数率");break;
                                case 1:
                                    countRateModel.text=qsTr("平均计数率");break;
                                case 2:
                                    countRateModel.text=qsTr("全部计数率");break;
                                }

                                tips.open(qsTr("已选择")+menuItem3.text+qsTr("模式"))
                            }
                        }
                        RLSConfigMenuItem{
                            id:menuItem4
                            text:qsTr("核电模式")
                            autoExclusive : true
                            checkable:true
                            onTriggered: {
                                currentModel.text=menuItem4.text
                                advanceConfig.setCurrentModelModify(3)
                                switch(advanceConfig.countRateType)
                                {
                                case 0:
                                    countRateModel.text=qsTr("实时计数率");break;
                                case 1:
                                    countRateModel.text=qsTr("平均计数率");break;
                                case 2:
                                    countRateModel.text=qsTr("全部计数率");break;
                                }

                                tips.open(qsTr("已选择")+menuItem4.text+qsTr("模式"))
                            }
                        }
                        RLSConfigMenuItem{
                            id:menuItem5
                            text:qsTr("货检模式")
                            autoExclusive : true
                            checkable:true
                            onTriggered:{
                                currentModel.text=menuItem5.text
                                advanceConfig.setCurrentModelModify(2)
                                switch(advanceConfig.countRateType)
                                {
                                case 0:
                                    countRateModel.text=qsTr("实时计数率");break;
                                case 1:
                                    countRateModel.text=qsTr("平均计数率");break;
                                case 2:
                                    countRateModel.text=qsTr("全部计数率");break;
                                }

                                tips.open(qsTr("已选择")+menuItem5.text+qsTr("模式"))
                            }
                        }
                        onOpened: currentModel.imageSource="../icons/up.png"
                        onClosed: {currentModel.imageSource="../icons/down.png";currentModel.forceActiveFocus();}
                    }
                    RLSConfigMenu{
                        id:countRateModelMenu
                        dim:true
                        modal:true
                        focus:false
                        transformOrigin : Popup.Bottom
                        y:parent.height-10-countRateModelMenu.height
                        x:parent.x+11
                        RLSConfigMenuItem{
                            id:menuItem6
                            text:qsTr("实时计数率")
                            autoExclusive : true
                            checkable:true
                            checked: advanceConfig.countRateType==0?true:false
                            onTriggered: {
                                countRateModel.text=menuItem6.text
                                advanceConfig.countRateType=0
                                advanceConfig.updateAllConfig()
                                tips.open("设置已保存！！")
                                }
                        }
                        RLSConfigMenuItem{
                            id:menuItem7
                            text:qsTr("平均计数率")
                            autoExclusive : true
                            checkable:true
                            checked: advanceConfig.countRateType==1?true:false
                            onTriggered: {
                                countRateModel.text=menuItem7.text
                                advanceConfig.countRateType=1
                                advanceConfig.updateAllConfig()
                                tips.open("设置已保存！！")
                                }
                        }
                        RLSConfigMenuItem{
                            id:menuItem8
                            text:qsTr("全部计数率")
                            autoExclusive : true
                            checkable:true
                            checked: advanceConfig.countRateType==2?true:false
                            onTriggered: {
                                countRateModel.text=menuItem8.text
                                advanceConfig.countRateType=2
                                advanceConfig.updateAllConfig()
                                tips.open("设置已保存！！")
                                }
                        }
                        onOpened: countRateModel.imageSource="../icons/up.png"
                        onClosed: {countRateModel.imageSource="../icons/down.png";countRateModel.forceActiveFocus();}
                    }
           }
                InputPanel {
                    id: inputPanelalarmModeConfigSetting //alarmModeConfigPopup
                    z: 99
                    y: alarmModeConfigPopup.height
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
                        when: inputPanelalarmModeConfigSetting.active
                        PropertyChanges {
                            target: inputPanelalarmModeConfigSetting
                            y: alarmModeConfigPopup.height - inputPanelalarmModeConfigSetting.height
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
                id:alarmLevelPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    anchors.fill: parent
                    color:RLSTheme.backgroundColor.C6
                    GridLayout{
                          id:alarmLevelPopupGridLayout
                          anchors.left: parent.left
                          anchors.leftMargin: 20
                          width:560
                          columns: 2
                          rowSpacing: 10
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          Text{
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F4
                              color:RLSTheme.textColor.C11
                              text:qsTr("一级报警")
                              Layout.columnSpan: 2
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              anchors.left: parent.left
                              text:qsTr("报警计数率大于")
                          }
                          RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 10000000;}
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              anchors.right: parent.right                              
                              id:warningLevel1Threshold
                              placeholderText :warningLevel1Threshold.activeFocus?"":advanceConfig.warningLevel1Threshold
                              inputMethodHints: Qt.ImhDigitsOnly
                              EnterKeyAction.actionId:EnterKeyAction.Next
                              EnterKeyAction.enabled:warningLevel1Threshold.length>0||warningLevel1Threshold.inputMethodComposing?true:false
                              onEnterKeyClicked:{
                                  warningLevel1Threshold.focus=false
                                  advanceConfig.warningLevel1Threshold=Number(warningLevel1Threshold.text)
                                  advanceConfig.updateAllConfig()
                                  tips.open("设置已保存！！")
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
                              text:qsTr("二级报警")
                              Layout.columnSpan: 2
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                               anchors.left: parent.left
                              text:qsTr("报警计数率大于")
                          }
                          RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 10000000;}
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              anchors.right: parent.right
                               id:warningLevel2Threshold
                               placeholderText :warningLevel2Threshold.activeFocus?"":advanceConfig.warningLevel2Threshold
                               inputMethodHints: Qt.ImhDigitsOnly
                               EnterKeyAction.actionId:EnterKeyAction.Next
                               EnterKeyAction.enabled:warningLevel2Threshold.length>0||warningLevel2Threshold.inputMethodComposing?true:false
                               onEnterKeyClicked:{
                                   warningLevel2Threshold.focus=false
                                   advanceConfig.warningLevel2Threshold=Number(warningLevel2Threshold.text)
                                   advanceConfig.updateAllConfig()
                                   tips.open("设置已保存！！")
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
                              text:qsTr("三级报警")
                              Layout.columnSpan: 2
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                               anchors.left: parent.left
                              text:qsTr("报警计数率大于")
                          }
                          RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 10000000;}
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              anchors.right: parent.right
                               id:warningLevel3Threshold
                               placeholderText :warningLevel3Threshold.activeFocus?"":advanceConfig.warningLevel3Threshold
                               inputMethodHints: Qt.ImhDigitsOnly
                               EnterKeyAction.actionId:EnterKeyAction.Next
                               EnterKeyAction.enabled:warningLevel3Threshold.length>0||warningLevel3Threshold.inputMethodComposing?true:false
                               onEnterKeyClicked:{
                                   warningLevel3Threshold.focus=false
                                   advanceConfig.warningLevel3Threshold=Number(warningLevel3Threshold.text)
                                   advanceConfig.updateAllConfig()
                                   tips.open("设置已保存！！")
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
                              text:qsTr("四级报警")
                              Layout.columnSpan: 2
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              anchors.left: parent.left
                              text:qsTr("报警计数率大于")
                          }
                          RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 10000000;}
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              anchors.right: parent.right
                               id:warningLevel4Threshold
                               placeholderText :warningLevel4Threshold.activeFocus?"":advanceConfig.warningLevel4Threshold
                               inputMethodHints: Qt.ImhDigitsOnly
                               EnterKeyAction.actionId:EnterKeyAction.Next
                               EnterKeyAction.enabled:warningLevel4Threshold.length>0||warningLevel4Threshold.inputMethodComposing?true:false
                               onEnterKeyClicked:{
                                   warningLevel4Threshold.focus=false
                                   advanceConfig.warningLevel4Threshold=Number(warningLevel4Threshold.text)
                                   advanceConfig.updateAllConfig()
                                   tips.open("设置已保存！！")
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
                              text:qsTr("五级报警")
                              Layout.columnSpan: 2
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              anchors.left: parent.left
                              text:qsTr("报警计数率大于")
                          }
                          RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 10000000;}
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F3
                              color:RLSTheme.textColor.C10
                              anchors.right: parent.right
                               id:warningLevel5Threshold
                               placeholderText :warningLevel5Threshold.activeFocus?"":advanceConfig.warningLevel5Threshold
                               inputMethodHints: Qt.ImhDigitsOnly
                               EnterKeyAction.actionId:EnterKeyAction.Next
                               EnterKeyAction.enabled:warningLevel5Threshold.length>0||warningLevel5Threshold.inputMethodComposing?true:false
                               onEnterKeyClicked:{
                                   warningLevel5Threshold.focus=false
                                   advanceConfig.warningLevel5Threshold=Number(warningLevel5Threshold.text)
                                   advanceConfig.updateAllConfig()
                                   tips.open("设置已保存！！")
                               }
                          }
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                              Layout.preferredHeight: 4
                          }

                    }
                }



                InputPanel {
                    id: inputPanelalarmLevelSetting //alarmLevelPopup
                    z: 99
                    y: alarmLevelPopup.height
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
                        when: inputPanelalarmLevelSetting.active
                        PropertyChanges {
                            target: inputPanelalarmLevelSetting
                            y: alarmLevelPopup.height - inputPanelalarmLevelSetting.height
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
                id:alarmSoundPopup
                width:600
                height: 1014
                x:parent.width
                leftPadding: 1
                transformOrigin: Popup.TopLeft
                Rectangle{
                    anchors.fill: parent
                    color:RLSTheme.backgroundColor.C6
                    GridLayout{
                          id:alarmSoundPopupGridLayout
                          anchors.left: parent.left
                          anchors.leftMargin: 20
                          width:560
                          columns: 2
                          rowSpacing: 10
                          RLSConfigSeparate{
                              Layout.columnSpan: 2
                          }
                          RLSConfigLabel{
                              text:qsTr("是否自动停止报警")
                          }
                          RLSSwitch{
                              id:autoStopWarning
                               checked:  advanceConfig.autoStopWarning
                               anchors.right: parent.right
                               onClicked: {
                                  advanceConfig.autoStopWarning=autoStopWarning.checked
                                   advanceConfig.updateAllConfig()
                                    tips.open("设置已保存！！")
                               }
                           }
                           RLSConfigSeparate{
                               Layout.columnSpan: 2
                           }
                           RLSConfigLabel{
                               text:qsTr("停止报警时间")
                           }
                           RLSConfigTextInput{
                               validator: IntValidator{bottom: 0; top: 30;}
                               font.family: RLSTheme.fontFamily
                               font.pixelSize: RLSTheme.fontSize.F3
                               color:RLSTheme.textColor.C10
                               anchors.right: parent.right
                                id:warningKeepTime
                                enabled: autoStopWarning.checked
                                placeholderText :warningKeepTime.activeFocus?"":advanceConfig.warningKeepTime
                                inputMethodHints: Qt.ImhDigitsOnly
                                EnterKeyAction.actionId:EnterKeyAction.Next
                                EnterKeyAction.enabled:warningKeepTime.length>0||warningKeepTime.inputMethodComposing?true:false
                                onEnterKeyClicked:{
                                    warningKeepTime.focus=false
                                    advanceConfig.warningKeepTime=Number(warningKeepTime.text)
                                    advanceConfig.updateAllConfig()
                                    tips.open("设置已保存！！")
                                }
                           }
                           RLSConfigSeparate{
                               Layout.columnSpan: 2
                           }
                    }
                }
                InputPanel {
                    id: inputPanelalarmSoundSetting //alarmSoundPopup
                    z: 99
                    y: alarmSoundPopup.height
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
                        when: inputPanelalarmSoundSetting.active
                        PropertyChanges {
                            target: inputPanelalarmSoundSetting
                            y: alarmSoundPopup.height - inputPanelalarmSoundSetting.height
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
    Component{
        id:systemRestore
        Rectangle{
            id:content
            width:600
            height:1014
            color:RLSTheme.backgroundColor.C6
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
                      text:qsTr("保存当前配置")
                  }
                  RLSButton{
                      anchors.right: parent.right
                      text:qsTr("保存")
                      onClicked: saveDialog.open()
                  }
                  RLSConfigSeparate{
                      Layout.columnSpan: 2
                  }
                  RLSConfigLabel{
                      text:qsTr("恢复指定配置")
                  }
                  RLSButton{
                      anchors.right: parent.right
                      text:qsTr("恢复")
                      onClicked: {
                          dateDialog.open()
                      }
                  }
                  RLSConfigSeparate{
                      Layout.columnSpan: 2
                  }
                  RLSConfigLabel{
                      text:qsTr("恢复出厂配置")
                  }
                  RLSButton{
                      anchors.right: parent.right
                      text:qsTr("恢复")
                      onClicked: function loadDefault(){
                          var path=new String(imagesPath)
                           advanceConfig.setXmlDir(path.slice(8).concat("/Config/FactoryConfig/DeviceFactory.xml"))
                          console.log(path.slice(8).concat("/Config/FactoryConfig/DeviceFactory.xml"))
                           tips.open("配置已恢复出厂设置");
                      }
                  }
                  RLSConfigSeparate{
                      Layout.columnSpan: 2
                  }
            }
            FileDialog {
                id: saveDialog
                //visible: true
                title: "Choose a Xml Path"
                folder: shortcuts.documents
                //nameFilters: [ "Xml files (*.xml)", "All files (*)" ]
               // modality:Qt.WindowModal
                selectFolder : true
                onAccepted:{
                     saveConfigXml();
                     tips.open("配置已保存");
                     Qt.quit();}
                 onRejected: {
                          Qt.quit()
                      }
            }

            FileDialog {
                id: dateDialog
                //visible: true
                title: "Choose a Xml File"
                folder: shortcuts.documents
                nameFilters: [ "Xml files (*.xml)", "All files (*)" ]
               // modality:Qt.WindowModal
                onAccepted:{
                     loadConfigXml();
                     tips.open("正在恢复中....");
                     Qt.quit();}
                 onRejected: {
                          Qt.quit()
                      }
            }
            function loadConfigXml(){
                    var path=new String(dateDialog.fileUrls)
                    advanceConfig.setXmlDir(path.slice(8))

            }
            function saveConfigXml(){

                var path=new String(saveDialog.fileUrls)
                 advanceConfig.saveXmlDir(path.slice(8))

            }

        }//rectangle
  }

}
