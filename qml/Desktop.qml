import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    property ListModel shellSurfaces: []
    anchors.fill: parent

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.jpg"
    }

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
