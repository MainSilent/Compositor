import QtQuick 2.12
import QtQuick.Controls 2.12

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

        AppsList {}

        OpenApps {}
    }
}
