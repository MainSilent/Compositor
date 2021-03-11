import QtQuick 2.12
import Backend 1.0

Rectangle {
    height: 50
    width: height
    color: mouseAppsList.containsMouse ? "#22000000" : "transparent"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: 3
    radius: 5

    Image {
        anchors.fill: parent
        source: "qrc:/images/dock/AppsList.png"
    }

    MouseArea {
        id: mouseAppsList
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: console.log(Apps.apps)
    }
}
