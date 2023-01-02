import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

Item {
    id: root
    width: 1920
    height: 1096

    property var itemFocus // Detect focus on List app OR widget
    property var widgetFocusItem //using for set focus to widet item

    function openApplication(url){
        parent.push(url) // call function of Stackview
    }

    onActiveFocusChanged: {
        console.log("Root onActiveFocusChanged")
        console.log("Item focus: "+itemFocus)

        if(activeFocus && itemFocus){
            itemFocus.focus = true
        }
    }

    RowLayout {
        id: lvWidget
        width: 1920
        height: 570
        spacing: 5

        MapWidget{
            id: mapWidget
            onClicked: {
                itemFocus = mapWidget
                openApplication("qrc:/Qml/App/Map/Map.qml")
                widgetFocusItem = mapWidget
            }
            onActiveFocusChanged:  {

                console.log("mapWidget onActiveFocusChanged")
                itemFocus = mapWidget

            }
            Keys.onPressed: {
                console.log("mapWidget press key")
                switch (event.key){
                case Qt.Key_Right:
                    console.log("focus on climateWidget")
                    climateWidget.focus = true
                    widgetFocusItem = climateWidget
                    break
                case Qt.Key_Enter:
                case Qt.Key_Return:
                    openApplication("qrc:/Qml/App/Map/Map.qml")
                    break
                case Qt.Key_Down:
                    console.log("key down from mapWidget")
                    mapWidget.focus = false
                    itemFocus = listApp
                    listApp.focus = true
                    visualModel.items.get(listApp.currentIndex).focus = true
                    visualModel.items.get(listApp.currentIndex).state = "Focus"
                    break
                }
            }
        }
        ClimateWidget {
            id: climateWidget
            onClicked: {
                itemFocus = climateWidget
                openApplication("qrc:/Qml/App/Climate/Climate.qml")
                widgetFocusItem = climateWidget
            }
            onActiveFocusChanged:  {
                console.log("climateWidget onActiveFocusChanged")
                itemFocus = climateWidget
            }
            Keys.onPressed: {
                switch (event.key){
                case Qt.Key_Left:
                    console.log("focus on Map")
                    mapWidget.focus = true
                    widgetFocusItem = mapWidget
                    break
                case Qt.Key_Right:
                    console.log("focus on Media")
                    mediaWidget.focus = true
                    widgetFocusItem = mediaWidget
                    break
                case Qt.Key_Enter:
                case Qt.Key_Return:
                    openApplication("qrc:/Qml/App/Climate/Climate.qml")
                    break
                case Qt.Key_Down:
                    console.log("key down from mapWidget")
                    itemFocus = listApp
                    listApp.focus = true
                    visualModel.items.get(listApp.currentIndex).focus = true
                    visualModel.items.get(listApp.currentIndex).state = "Focus"
                    break
                }

            }
        }
        MediaWidget{
            id: mediaWidget
            onClicked: {
                itemFocus = mediaWidget
                openApplication("qrc:/Qml/App/Media/Media.qml")
                widgetFocusItem = mediaWidget
            }
            onActiveFocusChanged:  {
                console.log("mediaWidget onActiveFocusChanged")
                itemFocus = mediaWidget
            }
            Keys.onPressed: {
                switch (event.key){
                case Qt.Key_Left:
                    console.log("focus on Climate")
                    climateWidget.focus = true
                    widgetFocusItem = climateWidget
                    break
                case Qt.Key_Enter:
                case Qt.Key_Return:
                    openApplication("qrc:/Qml/App/Media/Media.qml")
                    break
                case Qt.Key_Down:
                    console.log("key down from mapWidget")
                    itemFocus = listApp
                    listApp.focus = true
                    visualModel.items.get(listApp.currentIndex).focus = true
                    visualModel.items.get(listApp.currentIndex).state = "Focus"
                    break
                }
            }
        }

        Component.onCompleted: {
            lvWidget.forceActiveFocus()
            mapWidget.focus = true // Set Map focus when start app
            widgetFocusItem = mapWidget
        }
    }
    ListView {
        id: listApp
        width: 1920
        height: 604
        anchors.left: lvWidget.left
        anchors.top: lvWidget.bottom
        orientation: ListView.Horizontal
        interactive: visualModel.items.count > 6
        spacing: 5
        //model: visualModel
        ScrollBar.horizontal: ScrollBar{
            id: scrollBarId
            policy: visualModel.items.count > 6 ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            size: listApp.width / listApp.contentWidth
            active: true
            anchors {
                top: lvWidget.bottom
                right: parent.right
                left: parent.left
                bottom: parent.top
                leftMargin: 5
                topMargin: 0
            }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }
        onFocusChanged: {
            // tro ve trang thai Normal khi focus vao Widget
            console.log("ListView----> Focus: "+focus)
            if(!focus){
                listApp.currentItem.appItem.focus = false
                listApp.currentItem.appItem.state = "Normal"
            }else{
                listApp.currentItem.appItem.focus = true
                listApp.currentItem.appItem.state = "Focus"
            }
        }

        model : DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316
                height: 604
                keys: "AppButton"
                property alias appItem: app

                Keys.onPressed: {
                    switch (event.key){
                    case Qt.Key_Enter:
                    case Qt.Key_Return:
                        openApplication(model.url)
                        itemFocus = listApp
                        break
                    case Qt.Key_Up:
                        widgetFocusItem.focus = true
                    }
                }

                onEntered: {
                    //Changes UI reoder
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                }
                onExited:{
                    console.log("List app onExited")
                    listApp.focus= true
                }
                onActiveFocusChanged:{
                    console.log("List app onActiveFocusChanged")
                    app.focus = true
                    app.state = "Focus"
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 316
                    height: 604
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }
                    AppButton{
                        id: app
                        //anchors.fill: parent
                        title: model.title
                        icon: model.iconPath
                        drag.axis: Drag.XAxis
                        drag.target: parent
                        onClicked: {
                            //open application when click:
                            openApplication(model.url)
                        }
                        onPressed: {
                            //thao tac tren vung nay focus thay doi
                            app.focus = true
                            app.state = "Pressed"
                            listApp.focus =  true
                            itemFocus = listApp

                            //Reset focus on listview
                            console.log("count: "+visualModel.items.count)
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex){
                                    visualModel.items.get(index).focus = false
                                }
                                else {
                                    visualModel.items.get(index).focus = true
                                    listApp.currentIndex = index
                                }
                            }
                        }

                        onReleased: {
                            //app.focus = true
                            //app.state = "Focus"

                            //clear file before write new file:
                            xmlWriter.clearFile();

                            //changes focus of item in listview
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex)
                                    visualModel.items.get(index).focus = false
                                else{
                                    visualModel.items.get(index).focus = true

                                }
                                //writer.setData(index+1,visualModel.items.get(index).model.title, visualModel.items.get(index).model.url, visualModel.items.get(index).model.iconPath)
                                xmlWriter.saveModelData(visualModel.items.get(index).model.idApp, visualModel.items.get(index).model.title, visualModel.items.get(index).model.url, visualModel.items.get(index).model.iconPath)
                            }

                            listApp.forceActiveFocus()

                            //Write file XML:
                            xmlWriter.writeXmlFile();
                        }
                    }

                    Drag.source: icon
                    Drag.active: app.drag.active
                    Drag.hotSpot.x: width/2
                    Drag.hotSpot.y: height/2
                    Drag.keys: "AppButton"
                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: listApp
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
