import QtQuick 2.7
import QtQuick.Controls 2.0
import "../RLSTheme"


Rectangle{
    id:root
    implicitWidth: 520
    implicitHeight: 320
    property alias  buttonText:button.text
    property alias   textFieldText:textField.text
    property alias   buttonEnable:button.enabled

    signal closePop()
    signal handlePop()
    signal textChanged()

    property real leftM: 5
    property real topM: 66
    property real bottomM: 20
    property real rightM: 5


    color:RLSTheme.backgroundColor.C1
    radius:RLSTheme.buttonRadius


    Image{
        id:closeButton
        width: 32
        height:32
        fillMode: Image.PreserveAspectFit
        source: "../icons/close.png"
        anchors.top: parent.top
        anchors.topMargin: (topM-closeButton.height)/2
        anchors.right: parent.right
        anchors.rightMargin: bottomM
        smooth: true
        MouseArea{
            anchors.fill: parent
            onClicked: {root.closePop();textField.clear();button.enabled=false}
        }

    }

    RLSLogo{
        anchors.left: parent.left
        anchors.leftMargin:bottomM
        anchors.top: parent.top
        anchors.topMargin: 10


    }
    Label{
        id:title
        text:qsTr("用户权限")
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter

        font.family:RLSTheme.fontFamily
        font.pixelSize: RLSTheme.fontSize.F2
        horizontalAlignment: Text.AlignHCenter
        color:RLSTheme.textColor.C9
    }



    Rectangle{
        id:content
        anchors.left: parent.left
        anchors.leftMargin: leftM
        width:parent.width-leftM-rightM
        anchors.top: parent.top
        anchors.topMargin: topM
        height:parent.height-topM-bottomM
        color:RLSTheme.backgroundColor.C6
        RLSTextField{
            id:textField
            imageSource: ""
            isChoice: false
            activeFocusOnPress : true
            focusReason: Qt.MouseFocusReason
            inputMethodHints : Qt.ImhHiddenText
            echoMode: TextInput.Password
            placeholderText: textField.activeFocus?"":qsTr("请输入管理员权限密码...")
            font.family: RLSTheme.fontFamily
            font.letterSpacing: 1
            font.pixelSize: RLSTheme.fontSize.F3
            color:RLSTheme.textColor.C11
            anchors.horizontalCenter:content.horizontalCenter
            anchors.top: content.top
            anchors.topMargin:(content.height-textField.height-button.height)*0.5
            onTextChanged: root.textChanged()
        }

        RLSButton{
             id:button
             height: 50
             width:textField.width
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 15
             anchors.horizontalCenter: parent.horizontalCenter
             onClicked: {root.handlePop();textField.clear()}

        }
    }

}


