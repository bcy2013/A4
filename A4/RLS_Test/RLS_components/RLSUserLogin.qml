import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.VirtualKeyboard 2.1
//import "Decode.js" as MingWen
import QtQuick.LocalStorage 2.0
Window {
    id:root
    width: 720
    height: 1080
    x:(1920-720)/2
    modality: Qt.WindowModal
    flags:Qt.Window|Qt.FramelessWindowHint|Qt.WindowSystemMenuHint
    color:"transparent"

    signal login_In();

    Rectangle{
        id:userLogin
        //anchors.top: parent.top
        //anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 430
        implicitHeight: 330
        anchors.centerIn: parent
        radius: RLSTheme.buttonRadius
        color:RLSTheme.backgroundColor.C1



        Image {
            id: closeLogin
            source: "../icons/exit_black.png"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 20
            MouseArea{
                anchors.fill: parent
                onClicked: {root.close();Qt.quit()}
            }
        }



        Rectangle {
            id:logoLogin
            anchors.top: parent.top
            anchors.topMargin: 29
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset:0
            width:Math.max(logoImage.width,labelText.contentWidth)
            height:logoImage.height+6+labelText.height
            color:"transparent"
            FontLoader { id: webFont; source: "lan.TTF" }
            Image{
                id:logoImage
                fillMode: Image.PreserveAspectFit
                source: "../icons/LogoLogin.png"
            }
            Label{
                id:labelText
                anchors.top: logoImage.bottom
                anchors.topMargin: 6
                text:qsTr("放射性物质定位系统")
                font.family: webFont.name
                font.pixelSize: 16
                font.letterSpacing : 1
                color:RLSTheme.textColor.C9
            }
        }




        Rectangle{
            id:contentLogin
            width: parent.width
            color:RLSTheme.backgroundColor.C6
            anchors.top:parent.top
            anchors.topMargin: 116
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30





            Column{
                id:mainLayout
                anchors.fill:parent
                spacing: 15
                leftPadding:110
                topPadding: 15


                 Column{
                     spacing:5



                           RowLayout{

                            RLSTextField{
                                id:account
                                focus:false
                                isChoice: false
                                imageSource:"../icons/select-box.png"
                                cursorVisible: activeFocus
                                placeholderText:focus?" ":qsTr("用户名")
                                font.family: RLSTheme.fontFamily
                                font.letterSpacing: 1
                                font.pixelSize: RLSTheme.fontSize.F4

                                onPopupOpen:{userInfoListViewPopup.open();}
                                //validator: RegExpValidator { regExp: /^[0-9\+\-\#\*\ ]{6,}$/ }
                                //inputMethodHints: Qt.ImhDialableCharactersOnly
                            }
                            Image{
                                source: "../icons/account.png"
                                anchors.right: account.left
                                anchors.rightMargin: 10
                            }
                           }
                           RowLayout{
                            RLSTextField{
                                id:password
                                focus:false
                                isChoice: false

                                //imageSource: "../icons/textbox.png"
                                inputMethodHints : Qt.ImhHiddenText
                                echoMode: TextInput.Password
                                cursorVisible: activeFocus
                                placeholderText:focus?" ":qsTr("密码")
                                font.family: RLSTheme.fontFamily
                                font.letterSpacing: 1
                                font.pixelSize: RLSTheme.fontSize.F4


                            }
                            Image{
                                  source: "../icons/password.png"
                                  anchors.right: password.left
                                  anchors.rightMargin: 10
                             }
                         }
                        }

                       RLSButton{
                           id:loginButton
                           text:qsTr("登  录")
                           width:240
                           height:54
                           enabled: account.length&&password.length
                           onClicked:{
                               var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                               db.transaction(
                                           function(tx){
                                               var rs = tx.executeSql('SELECT * FROM UsersInfo WHERE name=?',account.text);
                                               if(rs.rows.length>0)
                                               {
                                                     if(rs.rows.item(0).password==password.text)
                                                       {
                                                         root.login_In()
                                                         tx.executeSql('UPDATE UsersInfo SET loginTime=? WHERE name=?',[new Date(),account.text]);

                                                     }
                                                     else
                                                     {
                                                         setLoginLabelPassword()
                                                     }

                                               }else{

                                                   setLoginLabelAccount()
                                               }
                                           }
                                           )
                           }
                           }
                       }
               }

//User listView
           RLSPopup{
                  id:userInfoListViewPopup
                  y:account.height+132
                  x:110
                  width: 240
                  height:160
                  transformOrigin: Popup.TopLeft
                  ListView{
                      id:mainViewArea
                      anchors.fill: parent
                      focus: true
                      //spacing:1
                      clip:true
                      delegate:Rectangle{
                          id:wrapper
                           property bool isSelected: mainViewArea.currentIndex===index
                          implicitWidth: 240
                          implicitHeight: 54
                          border.width: 1
                          color:isSelected?RLSTheme.backgroundColor.C6:RLSTheme.textColor.C9
                          border.color: RLSTheme.backgroundColor.C2
                          Label{
                              id:label
                              text:model.name
                              font.family: RLSTheme.fontFamily
                              font.pixelSize: RLSTheme.fontSize.F4
                              color:RLSTheme.textColor.C8
                              anchors.left: wrapper.left
                              anchors.leftMargin: 10
                              anchors.verticalCenter:parent.verticalCenter
                              elide: Text.ElideRight

                          }
                          MouseArea{
                              anchors.fill:wrapper
                              onClicked:
                             {

                                      mainViewArea.currentIndex=index
                                      account.text=model.name
                                      userInfoListViewPopup.close()

                              }
                          }
                          ListView.onAdd: SequentialAnimation {
                              PropertyAction { target: wrapper; property: "height"; value: 0 }
                              NumberAnimation { target: wrapper; property: "height"; to: 54; duration: 500; easing.type: Easing.InOutQuad }
                          }

                      }
                      model:ListModel{
                          id:model
                          Component.onCompleted: function initListViewModel(){
                              var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
                              var rs;
                             db.transaction(
                                 function(tx) {
                                     tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT PRIMARY KEY, password TEXT,loginTime DATE)');
                                      rs = tx.executeSql('SELECT * FROM UsersInfo ORDER BY loginTime DESC');
                                      for(var i=0;i<rs.rows.length;i++)
                                      {
                                        model.append(
                                            {
                                                "name":rs.rows.item(i).name
                                            }
                                            )
                                      }

                                 }
                             )
                          }
                      }
                      ScrollIndicator.vertical: ScrollIndicator { width: 10}


                  }

                  onOpened:account.imageSource="../icons/select-box-b.png"
                  onClosed:account.imageSource="../icons/select-box.png"
           }





//       //!->虚拟键盘




        InputPanel{
            id:inputPanel          
            z:10
            width:720
            opacity:0
           // visible: account.activeFocusOnPress||password.activeFocusOnPress
            anchors.top: parent.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            states: State {
                name: "visible"
                /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                    but then the handwriting input panel and the keyboard input panel can be visible
                    at the same time. Here the visibility is bound to InputPanel.active property instead,
                    which allows the handwriting panel to control the visibility when necessary.
                */
                when: account.activeFocus||password.activeFocus
                PropertyChanges {
                    target: inputPanel
                    opacity: 1
                }
            }
            transitions: Transition {
                from: ""
                to: "visible"
                reversible: true
                ParallelAnimation {
                    NumberAnimation {
                        properties: "opacity"
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }
            }


        }

//        //!<-虚拟键盘
        Rectangle{
            id:loginBottom
            width:parent.width
            height:30
            color:"transparent"
            anchors.bottom: parent.bottom

        Label{
            id:loginLabel
            text:qsTr("RLS-1000C-A3")
            anchors.centerIn: parent
            font.family: RLSTheme.fontFamily
            font.pixelSize: RLSTheme.fontSize.F4
            font.letterSpacing : 1
            color:RLSTheme.textColor.C9
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        }
    }
        Timer{
            id:timer
            interval: 1000
            repeat: false
            onTriggered:  {

                loginLabel.text=qsTr("RLS-1000C-A3");
                loginBottom.color="transparent";
                account.clear();
                password.clear();
            }

        }

    function setLoginLabelPassword(){
         loginLabel.text="密码错误";
         loginBottom.color="#e60012";
         timer.running=true;
    }
    function setLoginLabelAccount(){
         loginLabel.text="用户不存在";
         loginBottom.color="#e60012";
         timer.running=true;
    }
    function initUserDataBase(){
         var db=LocalStorage.openDatabaseSync("UsersInfo","1.0","User Managerment",10000000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS UsersInfo(name TEXT PRIMARY KEY, password TEXT,loginTime DATE)');
                 var rs = tx.executeSql('SELECT * FROM UsersInfo');
                if(rs.rows.length==0)
                {
                  tx.executeSql('INSERT INTO UsersInfo VALUES(?, ?,?)', [ 'admin', 'admin',new Date() ]);


                }

                tx.executeSql('CREATE TABLE IF NOT EXISTS ChartSettings(name TEXT PRIMARY KEY,color Text)');
                 var rt = tx.executeSql('SELECT * FROM ChartSettings');
                if(rs.rows.length==0)
                {
                  tx.executeSql('INSERT INTO ChartSettings VALUES(?,?)', [ 'countRate','#68b5ae' ]);



                }

            }            
        )
    }
    Component.onCompleted: {
               initUserDataBase()
               visible=true
               //VirtualKeyboardSettings.styleName ="retro"
           }

}
