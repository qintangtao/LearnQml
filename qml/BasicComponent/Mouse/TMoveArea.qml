import QtQuick 2.0

MouseArea {

    property real lastX: 0
    property real lastY: 0
    property bool mask: false
    property bool collision: false
    property var target: parent

    acceptedButtons: Qt.LeftButton
    onPressed: {
        lastX = mouseX
        lastY = mouseY
    }
    onPositionChanged: {
        if (!mask && pressed && target) {
            if(collision) {
                var x = target.x + mouseX - lastX
                var y = target.y + mouseY - lastY

                if (x < 0)
                    x = 0
                if (x + target.width > target.parent.width)
                    x = target.parent.width - target.width
               target.x = x

                if (y < 0)
                    y = 0
                if(y + target.height > target.parent.height)
                    y = target.parent.height - target.height
                 target.y = y
            } else {
                target.x += mouseX - lastX
                target.y += mouseY - lastY
            }
        }
    }

}
