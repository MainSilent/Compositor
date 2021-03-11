import QtQuick 2.12
import QtWayland.Compositor 1.3
import Backend 1.0

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

        // Thumbnail
        Rectangle {
            x: -75
            y: -210
            height: 200
            width: 200
            color: "#55000000"
            radius: 5
            clip: true
            visible: mouseDockIcon.containsMouse

            WaylandQuickItem {
                height: 170
                width: parent.width
                sizeFollowsSurface: false
                touchEventsEnabled: false
                surface: modelData.surface
            }

            Text {
                text: title
                y: 175
                anchors.left: parent.left
                anchors.leftMargin: 5
                color: "#aaffffff"
            }
        }

        // Mouse Hover, Double click close
        MouseArea {
            id: mouseDockIcon
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            // onClick should enable focus
            onClicked: console.log("focus")
            onDoubleClicked: modelData.toplevel.sendClose()
        }
    }
}
