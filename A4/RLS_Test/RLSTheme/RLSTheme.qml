import QtQuick 2.0
pragma Singleton
QtObject {
    id:theme
    //界面颜色
    property var backgroundColor:{
        'C1':"#464646",
        'C2':"#68b5ae",
        'C3':"#353434",
        'C4':"#000000",
        'C5':"#e3e2e2",
        'C6':"#e9e9e9"
    }

    //文本相关
    property var textColor:{
        'C7':"#68b5ae",
        'C8':"#333333",
        'C9':"#ffffff",
        'C10':"#666666",
        'C11':"#999999",
        'C12':"#cccccc",
        'C13':"#d3d2d2"
    }
    property string fontFamily:"微软雅黑"
    property var fontSize: {
        'F1':30,
        'F2':24,
        'F3':18,
        'F4':14
    }
    //界面按钮
    property var buttonStateColor:{
        'buttonColor':"#757676",
        'buttonPressColor':"#4e4e4e",
        'buttonDisabledColor':"#bbbbbb"
    }
    property real buttonRadius: 5
   //文本框
    property var textFieldBorder: {
        'borderWidth':1,
        'isFocusActiveColor':"#68b5ae",
        'isBorderColor':'#333333'
    }


    property var scrollBarColor: {
        'S1':"#bbbbbb",
        'S2':"#868686"
    }

}
