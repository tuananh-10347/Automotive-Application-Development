import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1
import QtQuick.XmlListModel 2.0

Item {
    id: root
    width: 1920
    height: 1096
    property int indexFocus: 0
    function openApplication(url){
        parent.push(url)
    }

    ListView {
        id: lvWidget
        spacing: 5
        orientation: ListView.Horizontal
        width: 1920
        height: 570
        interactive: false
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModelWidget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }

            delegate: DropArea {
                id: delegateRootWidget
                width: 635; height: 570

                keys: ["widget"]

                onEntered: {
                    visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex)
                    iconWidget.item.enabled = false

                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: iconWidget; property: "visualIndex"; value: visualIndex }
                onExited: iconWidget.item.enabled = true
                onDropped: {
                    drop.source.visualIndex
                }
                Loader {
                    id: iconWidget
                    property int visualIndex: 0
                    width: 635; height: 570

                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                    Drag.active: iconWidget.item.drag.active
                    Drag.keys: "widget"
                    Drag.hotSpot.x: delegateRootWidget.width/2
                    Drag.hotSpot.y: delegateRootWidget.height/2

                    states: [
                        State {
                            when: iconWidget.Drag.active
                            ParentChange {
                                target: iconWidget
                                parent: root
                            }

                            AnchorChanges {
                                target: iconWidget
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                onClicked: openApplication("qrc:/App/Map/Map.qml")
                onReleased: indexFocus = 0
                isFocus: root.indexFocus === 0 ? true : false
                onIsFocusChanged: {
                    if(root.isFocus === true){
                        root.state = "Focus"
                    }else{
                        root.state = "Normal"
                    }
                }

            }
        }

        Component {
            id: climateWidget
            ClimateWidget {
                onClicked: openApplication("qrc:/App/LocalClimate/LocalClimate.qml")
                onReleased: indexFocus = 1
                isFocus: root.indexFocus === 1 ? true : false
                onIsFocusChanged: {
                    if(root.isFocus === true){
                        root.state = "Focus"
                    }else{
                        root.state = "Normal"
                    }
                }

            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                onClicked: openApplication("qrc:/App/Media/Media.qml")
                onReleased: indexFocus = 2
                isFocus: root.indexFocus === 2 ? true : false
                onIsFocusChanged: {
                    if(root.isFocus === true){
                        root.state = "Focus"
                    }else{
                        root.state = "Normal"
                    }
                }
            }
        }

    }

    ListView {
        id: lvApp
        anchors.left: lvWidget.left
        anchors.top: lvWidget.bottom
        width: 1920
        height: 604
        focus: true
        orientation: ListView.Horizontal
        interactive: false
        spacing: 5

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        ScrollBar.horizontal: ScrollBar {
            id: listAppScrollbarId
            active: true
            size: lvApp.width / lvApp.contentWidth
            position: lvApp.currentItem
            policy: {
                if(visualModel.items.count > 6){
                    ScrollBar.AlwaysOn
                }else{
                    ScrollBar.AlwaysOff
                }
            }
            anchors.top: lvWidget.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.bottom: parent.top
        }

        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316; height: 604
                keys: "AppButton"
                onEntered:{
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex )
                    if(icon.visualIndex >= 5){
                        listAppScrollbarId.increase()
                    }else{
                        listAppScrollbarId.decrease()
                    }
                }

                property int visualIndex: DelegateModel.itemsIndex

                Binding { target: icon; property: "visualIndex"; value: visualIndex }
                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 316; height: 604
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: model.title
                        icon: model.iconPath
                        drag.target: parent
                        onClicked: openApplication(model.url)

                        onPressed: {
                            app.focus = true
                            app.state = "Focus"
                        }

                        onReleased: {
                            app.focus = true
                            app.state = "Focus"
                            indexFocus = -1
                            var indexs = [];
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex){
                                    visualModel.items.get(index).focus = false
                                }
                                else{
                                    visualModel.items.get(index).focus = true
                                }
                                indexs[index] = (visualModel.items.get(index).model);
                                appsModel.writeDataToXml(index+1, indexs[index].title , indexs[index].url, indexs[index].iconPath)
                            }

                        }


                        isFocus: indexFocus !== -1 ? true : false


                        onIsFocusChanged: {
                            if(root.isFocus === true)
                                root.state = "Normal"
                        }


                    }

                    onFocusChanged: app.focus = icon.focus
                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }
    }
}
