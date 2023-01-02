import QtQuick 2.0

MouseArea {
    id: root
    implicitWidth: 316
    implicitHeight: 604
    property string icon
    property string title
    property bool isFocus: false
    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: icon + "_n.png"
    }
    Text {
        id: appTitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 350
        text: title
        font.pixelSize: 36
        color: "white"
    }
    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        }
    ]
    onPressed: state = "Pressed"
    onReleased: {
        focus = true
        state = "Focus"
    }
    onIsFocusChanged: {
        console.log("onIsFocusChanged: " + isFocus)
        if (isFocus == true )
            state = "Focus"
        else
            state = "Normal"
    }
    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}
