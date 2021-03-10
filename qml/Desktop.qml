import QtQuick 2.12
import QtQuick.Controls 2.12
import Backend 1.0

Rectangle {
    property ListModel shellSurfaces: []
    anchors.fill: parent
    color: "gray"

    // Dock
    Rectangle {
        id: dock
        width: parent.width
        height: 60
        anchors.bottom: parent.bottom
        color: "#55000000"

        Row {
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: shellSurfaces
                // Dock item
                Rectangle {
                    property int pid: modelData.surface.client.processId
                    property string title: modelData.toplevel.title

                    height: 50
                    width: height
                    color: mouseDockIcon.containsMouse ? "#22000000" : "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 5

                    // Icon
                    Image {
                        width: parent.width - 10
                        height: width
                        anchors.centerIn: parent
                        source: appIcon.path

                        Icon { id: appIcon }

                        Component.onCompleted: appIcon.setIcon(pid)
                    }

                    MouseArea {
                        id: mouseDockIcon
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }
}
