import QtQuick 2.0
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    implicitWidth: 635
    implicitHeight: 570
    //focus: false
    property bool isFocus: false
    Rectangle {
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10
        y:10
        width: 615
        height: 550
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        text: "USB Music"
        color: "white"
        font.pixelSize: 34
    }
    Image {
        id: bgInner
        x:201
        y:119
        width: 258
        height: 258
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:201
        y:119
        width: 258
        height: 258
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42
        y: 56+343
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {

            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
        }

        color: "white"
        font.pixelSize: 30
    }
    Text {
        id: txtTitle
        x: 42
        y: 56+343+55
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 48
    }
    Image{
        id: imgDuration
        x: 62
        y: 56+343+55+62
        width: 551
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62
        y: 56+343+55+62
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }
//Animation{

//}
    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Focus"
    }
    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
    onIsFocusChanged: {
        if(root.isFocus == true){
            root.state = "Focus"
        }else{
            root.state = "Normal"
        }
}
    Connections{
        target: player.playlist
        onCurrentIndexChanged:{
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex) {
                bgBlur.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                bgInner.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                txtSinger.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
                txtTitle.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511);
        }
    }
}
