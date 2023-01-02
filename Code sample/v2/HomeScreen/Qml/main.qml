import QtQuick 2.11
import QtQuick.Window 2.0
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    visibility: "FullScreen"
    width: 1920
    height: 1200
    property bool screenCheck: true
    Image {
        id: background
        width: 1920
        height: 1200
        source: "qrc:/Img/bg_full.png"
    }

    StatusBar {
        id: statusBar
        onBntBackClicked: {
            stackView.pop()
        }
        isShowBackBtn: stackView.depth == 1 ? false : true
    }

    StackView {
        id: stackView
        width: 1920
        anchors.top: statusBar.bottom
        //focus: true
        initialItem: HomeWidget{
            id: homeId
        }
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Keys.onReleased: {
            if(screenCheck){
                switch (event.key){
                case Qt.Key_M:
                    console.log("Key M")
                    homeId.openApplication("qrc:/App/Map/Map.qml")
                    screenCheck = false
                    break
                case Qt.Key_C:
                    console.log("Key C")
                    homeId.openApplication("qrc:/App/Climate/Climate.qml")
                    screenCheck = false
                    break
                case Qt.Key_P:
                    console.log("Key P")
                    homeId.openApplication("qrc:/App/Media/Media.qml")
                    screenCheck = false
                    break
                case Qt.Key_Backspace:
                    console.log("Key Key_Backspace")
                    screenCheck = true
                    stackView.pop()
                    break

                }
            }else{
                switch (event.key){
                case Qt.Key_Backspace:
                    console.log("Key_Backspace")
                    screenCheck = true
                    stackView.pop()
                    break
                }
            }
        }
    }
}
