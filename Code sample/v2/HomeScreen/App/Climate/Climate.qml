import QtQuick 2.0
Item {
    id:root
    width: 1920
    height: 1200
    //Header
    Image {
        id: headerItem
        source: "qrc:/App/Media/Image/title.png"
        Text {
            id: headerTitleText
            text: qsTr("Climate")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 40
        }
    }
    //Outside
    Text{
        id: outsideText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: headerItem.bottom
        anchors.topMargin: 50
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: "OUTSIDE"
        color: "white"
        font.pixelSize: 26
    }
    Text{
        id: outsideTemp
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: outsideText.bottom
        anchors.topMargin: 10
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: climateModel.outside_temp + "°C"
        color: "white"
        font.pixelSize: 38
    }
    //Temperature driver
    Text {
        id: driverTitle
        text: qsTr("DRIVER")
        font.pixelSize: 46
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: rec1.top
        anchors.horizontalCenter: rec1.horizontalCenter
        anchors.bottomMargin: 20
    }
    Text {
        id: driverTemp
        anchors.top: driverTitle.bottom
        anchors.horizontalCenter: rec1.horizontalCenter
        anchors.topMargin: 50
        text: climateModel.driver_temp <= 16.5 ? "LOW" : (climateModel.driver_temp >= 31.5 ? "HIGH" : (climateModel.driver_temp + "°C"))
        font.pixelSize: 50
        color: "white"
    }
    Rectangle {
        id: rec1
        width: 300
        height: 450
        color: "transparent"
        radius: width/5
        border.color: "gray"
        border.width: 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 450
    }
    Item{
        id: driverSeat
        width: 110+80 +60
        height: 80+80 + 50
        anchors.centerIn: rec1
        Image {
            id: seatId
            x: 90
            y: 50
            width: 160
            height: 170
            source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
        }
        Image {
            id: arrow1Id
            x: 40
            y: 70
            width: 120
            height: 100
            source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
        }
        Image {
            id: arrow2Id
            y: 110
            width: 120
            height: 100
            source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
        }
    }
    //Temperature passenger
    Rectangle {
        id: rec2
        width: 300
        height: 450
        color: "transparent"
        radius: width/5
        border.color: "gray"
        border.width: 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: rec1.anchors.leftMargin
    }
    Text {
        id: passengerTitle
        text: qsTr("PASSENGER")
        font.pixelSize: 46
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: rec2.top
        anchors.horizontalCenter: rec2.horizontalCenter
        anchors.bottomMargin: 20
    }
    Text {
        id: passengerTemp
        anchors.top: passengerTitle.bottom
        anchors.horizontalCenter: rec2.horizontalCenter
        anchors.topMargin: 50
        text: climateModel.passenger_temp <= 16.5 ? "LOW" : (climateModel.passenger_temp >= 31.5 ? "HIGH" : (climateModel.passenger_temp + "°C"))
        font.pixelSize: 50
        color: "white"
    }
    Item{
        id: passengerSeat

        width: 110+80 +60
        height: 80+80 + 50
        anchors.centerIn: rec2
        Image {
            x: 90
            y: 50
            width: 160
            height: 170
            source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
        }
        Image {
            x: 40
            y: 70
            width: 120
            height: 100
            source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
        }
        Image {
            y: 110
            width: 120
            height: 100
            source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
        }
    }
    //Fan level
    Item{
        width: fanIcon.width + fanLevel.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: rec1.verticalCenter
        Image {
            id: fanIcon
            x: 50
            y: 50
            source: "qrc:/Img/Climate/ico_wind_level.png"
            width: sourceSize.width*2
            height: sourceSize.height*2
        }
        Image {
            id: fanLevel
            anchors.left: fanIcon.right
            anchors.bottomMargin: 30

            source: climateModel.fan_level <= 0 ? "" : "qrc:/Img/Climate/wind_level_cool_" + climateModel.fan_level + ".png"
            width: 132*2.5
            height: 59*1.5


        }
    }
        //Animation
        NumberAnimation on x {
            from: root.width
            to: 0
            duration: 500
        }
}




















