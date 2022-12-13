import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4

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
                text: qsTr("Radio")
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
            source: "qrc:/Img/bg_full.png"
        }

        Rectangle {
            id: btnAmId
            width: 400
            height: 250
            color: "lightblue"
            opacity: 0.5
            anchors.left: blockId.left
            anchors.leftMargin: 20
            anchors.top: titleBackgroundId.bottom
            anchors.topMargin: 20
            Text {
                id: txtAm
                text: qsTr("AM")
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    txtChannel1.text = "10 GHz"
                    txtChannel2.text = "100 GHz"
                    txtChannel3.text = "103 GHz"
                    txtChannel4.text = "205 GHz"
                    txtChannel5.text = "11 GHz"
                }
            }
        }

        Rectangle {
            id: btnFmId
            width: btnAmId.width
            height: btnAmId.height
            anchors.left: blockId.left
            anchors.leftMargin: 20
            anchors.top: btnAmId.bottom
            anchors.topMargin: 20
            color: "lightblue"
            opacity: 0.5
            Text {
                id: txtFm
                text: qsTr("FM")
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    txtChannel1.text = "200 GHz"
                    txtChannel2.text = "101 GHz"
                    txtChannel3.text = "102 GHz"
                    txtChannel4.text = "188 GHz"
                    txtChannel5.text = "11 GHz"
                }
            }
        }

        Rectangle {
            id: btnDabId
            width: btnFmId.width
            height: btnFmId.height
            anchors.left: blockId.left
            anchors.leftMargin: 20
            anchors.top: btnFmId.bottom
            anchors.topMargin: 20
            color: "lightblue"
            opacity: 0.5
            Text {
                id: txtDab
                text: qsTr("DAB")
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    txtChannel1.text = "199 GHz"
                    txtChannel2.text = "200 GHz"
                    txtChannel3.text = "20 GHz"
                    txtChannel4.text = "99 GHz"
                    txtChannel5.text = "110 GHz"
                }
            }
        }

        Rectangle {
            id: channel1Id
            width: blockId.width
            height: 100
            color: "lightblue"
            anchors.top: titleBackgroundId.bottom
            anchors.topMargin: 20
            anchors.left: btnAmId.right
            anchors.leftMargin: 20
            anchors.right: blockId.right
            anchors.rightMargin: 20
            opacity: 0.5
            Text {
                id: txtChannel1
                anchors.centerIn: channel1Id
                text: "10 GHz"
                color: "white"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    btnAmId.visible = false
                    btnFmId.visible = false
                    btnDabId.visible = false
                    channel1Id.visible = false
                    channel2Id.visible = false
                    channel3Id.visible = false
                    channel4Id.visible = false
                    channel5Id.visible = false
                    channelSettingId.visible = true
                    txtChannelSettingId.text = txtChannel1.text

                }
            }
        }

        Rectangle {
            id: channel2Id
            width: blockId.width
            height: 100
            color: "lightblue"
            anchors.top: channel1Id.bottom
            anchors.topMargin: 20
            anchors.left: btnAmId.right
            anchors.leftMargin: 20
            anchors.right: blockId.right
            anchors.rightMargin: 20
            opacity: 0.5
            Text {
                id: txtChannel2
                anchors.centerIn: channel2Id
                text: "100 GHz"
                color: "white"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    btnAmId.visible = false
                    btnFmId.visible = false
                    btnDabId.visible = false
                    channel1Id.visible = false
                    channel2Id.visible = false
                    channel3Id.visible = false
                    channel4Id.visible = false
                    channel5Id.visible = false
                    channelSettingId.visible = true
                    txtChannelSettingId.text = txtChannel2.text

                }
            }
        }

        Rectangle {
            id: channel3Id
            width: blockId.width
            height: 100
            color: "lightblue"
            anchors.top: channel2Id.bottom
            anchors.topMargin: 20
            anchors.left: btnAmId.right
            anchors.leftMargin: 20
            anchors.right: blockId.right
            anchors.rightMargin: 20
            opacity: 0.5
            Text {
                id: txtChannel3
                anchors.centerIn: channel3Id
                text: "103 GHz"
                color: "white"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    btnAmId.visible = false
                    btnFmId.visible = false
                    btnDabId.visible = false
                    channel1Id.visible = false
                    channel2Id.visible = false
                    channel3Id.visible = false
                    channel4Id.visible = false
                    channel5Id.visible = false
                    channelSettingId.visible = true
                    txtChannelSettingId.text = txtChannel3.text
                }
            }
        }

        Rectangle {
            id: channel4Id
            width: blockId.width
            height: 100
            color: "lightblue"
            anchors.top: channel3Id.bottom
            anchors.topMargin: 20
            anchors.left: btnAmId.right
            anchors.leftMargin: 20
            anchors.right: blockId.right
            anchors.rightMargin: 20
            opacity: 0.5
            Text {
                id: txtChannel4
                anchors.centerIn: channel4Id
                text: "205 GHz"
                color: "white"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    btnAmId.visible = false
                    btnFmId.visible = false
                    btnDabId.visible = false
                    channel1Id.visible = false
                    channel2Id.visible = false
                    channel3Id.visible = false
                    channel4Id.visible = false
                    channel5Id.visible = false
                    channelSettingId.visible = true
                    txtChannelSettingId.text = txtChannel4.text

                }
            }
        }

        Rectangle {
            id: channel5Id
            width: blockId.width
            height: 100
            color: "lightblue"
            anchors.top: channel4Id.bottom
            anchors.topMargin: 20
            anchors.left: btnAmId.right
            anchors.leftMargin: 20
            anchors.right: blockId.right
            anchors.rightMargin: 20
            opacity: 0.5
            Text {
                id: txtChannel5
                anchors.centerIn: channel5Id
                text: "11 GHz"
                color: "white"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    btnAmId.visible = false
                    btnFmId.visible = false
                    btnDabId.visible = false
                    channel1Id.visible = false
                    channel2Id.visible = false
                    channel3Id.visible = false
                    channel4Id.visible = false
                    channel5Id.visible = false
                    channelSettingId.visible = true
                    txtChannelSettingId.text = txtChannel5.text

                }
            }
        }

        Rectangle {
            id:channelSettingId
            width: backgroundId.width
            height: backgroundId.height
            anchors.top: titleBackgroundId.bottom
            visible: false
            Text {
                id: txtChannelSettingId
                anchors.centerIn: parent
                color: "white"
                //text:
                font.pointSize: 80
            }

            Slider{
                id: channelSliderId
                width: 900
                anchors.top: channelSettingId.top
                anchors.topMargin: 450
                anchors.left: channelSettingId.left
                anchors.leftMargin: 500
                from: 0
                to: 300
                value: txtChannel1.text.slice(0 , 3)
            }

            Rectangle {
                id: btnSaveId
                width: 260
                height: 180
                anchors.top: channelSettingId.top
                anchors.topMargin: 550
                anchors.left: channelSettingId.left
                anchors.leftMargin: 600
                color: "gray"
                opacity: 0.8
                Text {
                    id: txtSaveId
                    text: "Save"
                    color: "white"
                    font.pointSize: 20
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        txtChannel1.text = Math.floor(channelSliderId.value.toString()) + " GHz"
                        btnAmId.visible = true
                        btnFmId.visible = true
                        btnDabId.visible = true
                        channel1Id.visible = true
                        channel2Id.visible = true
                        channel3Id.visible = true
                        channel4Id.visible = true
                        channel5Id.visible = true
                        channelSettingId.visible = false
                    }
                }
            }


            Rectangle {
                id: btnCancelId
                width: 260
                height: 180
                anchors.top: channelSettingId.top
                anchors.topMargin: 550
                anchors.left: btnSaveId.right
                anchors.leftMargin: 200
                color: "gray"
                opacity: 0.8
                Text {
                    id: txtCancelId
                    text: "Cancel"
                    color: "white"
                    font.pointSize: 20
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        btnAmId.visible = true
                        btnFmId.visible = true
                        btnDabId.visible = true
                        channel1Id.visible = true
                        channel2Id.visible = true
                        channel3Id.visible = true
                        channel4Id.visible = true
                        channel5Id.visible = true
                        channelSettingId.visible = false

                    }
                }
            }
        }

    }
}
