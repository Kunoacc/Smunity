import QtQuick 2.6
import Qt.labs.controls 1.0

Pane {
    id: pane

    Item {
        id: loader
        anchors.fill: parent
        visible: portal.loadProgress < 1

        BusyIndicator {
            id: busy
            height: parent.height / 4
            width: parent.width / 4
            anchors.centerIn: parent
        }

        Text {
            text: "loading Quickteller..."
            anchors.top: busy.bottom
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
