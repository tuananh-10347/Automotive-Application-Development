import QtQuick 2.12
import QtQuick.Window 2.12
Item {
    id: root
    width: 1920
    height: 1080
    Rectangle {
        id: blockId
        width: root.width
        height: root.height
        Image {
            id: titleBackgroundId
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
            anchors.top: titleBackgroundId.bottom
            anchors.left: blockId.left
            anchors.right: blockId.right
            anchors.bottom: blockId.bottom
            width: 1280
            height: 800
            source: "qrc:/App/Media/Image/Phone.png"
        }

        Rectangle {
            id: systemSettingId

        }

    }
}
