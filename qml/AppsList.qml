import QtQuick 2.12

Rectangle {
    height: 50
    width: height
    color: mouseAppsList.containsMouse ? "#22000000" : "transparent"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: 3
    radius: 5

    // Icon logo in dock
    Image {
        anchors.fill: parent
        source: "qrc:/images/dock/AppsList.png"
    }

    // Apps listview
    Rectangle {
        width: 700
        height: 600
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        color: "#55000000"
        radius: 5
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
                        name: "Shutdown"
                        icon: "qrc:/images/dock/shutdown.png"
                    }
                    ListElement {
                        name: "Restart"
                        icon: "qrc:/images/dock/restart.png"
                    }
                    ListElement {
                        name: "Sleep"
                        icon: "qrc:/images/dock/sleep.png"
                    }
                    ListElement {
                        name: "Lock"
                        icon: "qrc:/images/dock/lock.png"
                    }
                }

                Column {
                    anchors.fill: parent

                    Repeater {
                        model: powerList

                        Rectangle {
                            height: 50
                            width: height
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 10
                            color: mouseShutdownActionList.containsMouse ? "#22000000" : "transparent"
                            radius: 5

                            Image {
                                width: parent.width - 10
                                height: width
                                anchors.centerIn: parent
                                source: "qrc:/images/dock/shutdown.png"
                            }

                            MouseArea {
                                id: mouseShutdownActionList
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
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

                Repeater {
                    model: apps

                    Text {
                        text: modelData[1]
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseAppsList
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
