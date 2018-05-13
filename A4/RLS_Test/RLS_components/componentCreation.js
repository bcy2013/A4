
var component;
var sprite;

function createSpriteObjects(qmlname) {
    component = Qt.createComponent(qmlname);              //  这个可以理解为预加载qml文件
    if (component.status == Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);           // c++里面的connect在qml里面的用法之一
}

function finishCreation() {
    if (component.status == Component.Ready) {
        sprite = component.createObject(null, {"x": 800, "y": 330});            //  这个才是关键地方， 在内存中生成qml对象
        if (sprite == null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
