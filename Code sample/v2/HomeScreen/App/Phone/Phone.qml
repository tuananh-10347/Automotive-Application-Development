import QtQuick 2.12
import QtQuick.Window 2.12
Item {
    id: root
    width: 1920
    height: 1080
    //header
    Rectangle {
        id: headerItem
        width: root.width
        height: root.height
        Image {
            id: titleBackground
            source: "qrc:/App/Media/Image/title.png"
            Text {
                id: titleId
                text: qsTr("Phone")
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 46
            }
        }
        Image {
            id: backgroundId
            anchors.top: titleBackground.bottom
            anchors.left: headerItem.left
            anchors.right: headerItem.right
            anchors.bottom: headerItem.bottom
            width: 1280
            height: 800
            source: "qrc:/App/Phone/Phone.jpg"
        }
    }        //Animation
    NumberAnimation on x {
        from: root.width
        to: 0
        duration: 500
    }
}
