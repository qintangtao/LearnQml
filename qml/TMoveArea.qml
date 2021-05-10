import QtQuick 2.0

MouseArea {

    property real lastX: 0
    property real lastY: 0
    property bool mask: false
    property var target: parent

    acceptedButtons: Qt.LeftButton
    onPressed: {
        lastX = mouseX
        lastY = mouseY
    }
    onPositionChanged: {
        if (!mask && pressed && target) {
            target.x += mouseX - lastX
            target.y += mouseY - lastY
        }
    }

}
