import QtQuick 2.12
import QtQuick.Controls 2.12
import Backend 1.0

Rectangle {
    height: 60
    width: height
    color: mouseAppsList.containsMouse ? "#22000000" : "transparent"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    // Icon logo in dock
    Image {
        anchors.fill: parent
        source: "qrc:/images/dock/AppsList.png"
    }

    // Apps listview
    Rectangle {
        id: appsListView
        width: 700
        height: 600
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 65
        color: "#55000000"
        visible: false
        clip: true

        Row {
            anchors.fill: parent

            // Action list
            Rectangle {
                height: parent.height
                width: 60
                color: "transparent"
                clip: true

                ListModel {
                    id: powerList

                    ListElement {
                        name: "Lock"
                        icon: "qrc:/images/dock/lock.png"
                    }
                    ListElement {
                        name: "Sleep"
                        icon: "qrc:/images/dock/sleep.png"
                    }
                    ListElement {
                        name: "Restart"
                        icon: "qrc:/images/dock/restart.png"
                    }
                    ListElement {
                        name: "Shutdown"
                        icon: "qrc:/images/dock/shutdown.png"
                    }
                }

                Column {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 10
                    spacing: 7

                    Repeater {
                        model: powerList

                        Rectangle {
                            height: 50
                            width: height
                            color: mousePowerActionList.containsMouse ? "#22ffffff" : "transparent"
                            radius: 5

                            Image {
                                width: parent.width - 10
                                height: width
                                anchors.centerIn: parent
                                source: icon
                            }

                            MouseArea {
                                id: mousePowerActionList
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: backend.power(name)
                            }
                        }
                    }
                }
            }

            // Seperator
            Rectangle {
                height: parent.height - 20
                width: 1
                anchors.verticalCenter: parent.verticalCenter
                color: "#44ffffff"
            }

            // Apps list
            Rectangle {
                height: parent.height
                width: parent.width - 61
                color: "transparent"

                TextInput {
                    id: search
                    x: 26; y: 14
                    width: parent.width - 40
                    height: 40
                    color: "#55ffffff"
                    font.pixelSize: 20
                    selectionColor: "#55000000"
                    focus: true
                    onVisibleChanged: visible === false ? text = "" : none
                }

                GridView {
                    id: appsListGrid
                    x: 20
                    width: parent.width
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        margins: 8
                        topMargin: 40
                    }
                    model: apps.filter(data => data[0].toLowerCase().includes(search.text.toLowerCase()))
                    clip: true

                    // App
                    delegate: Item {
                        width: appsListGrid.cellWidth
                        height: appsListGrid.cellHeight

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            color: mouseApp.containsMouse ? "#22ffffff" : "transparent"
                            border.color: "#55000000"
                            border.width: 2
                            radius: 4
                            clip: true

                            Image {
                                y: 5
                                width: parent.width - 28
                                height: parent.height - 28
                                anchors.horizontalCenter: parent.horizontalCenter
                                source: modelData[2]
                            }

                            Text {
                                text: modelData[0]
                                anchors {
                                    left: parent.left
                                    bottom: parent.bottom
                                    leftMargin: 4
                                    bottomMargin: 3
                                }
                                font.pixelSize: 13
                                color: "#aaffffff"
                            }

                            MouseArea {
                                id: mouseApp
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onClicked: backend.run(modelData[1])
                            }
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseAppsList
        anchors.fill: parent
        hoverEnabled: true
        onClicked: appsListView.visible = appsListView.visible ? false : true
        onEntered: appsListView.visible = true
    }

    Backend {
        id: backend
    }
}
