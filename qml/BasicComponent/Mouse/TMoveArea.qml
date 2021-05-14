import QtQuick 2.0

MouseArea {

    property real lastX: 0
    property real lastY: 0
    property var target: parent
    property bool moveEnabled: true

    //限制
    property bool collisionEnabled: false
    property int collisionLeft: 0
    property int collisionRight: collisionEnabled && target ? target.parent.width : 0
    property int collisionTop: 0
    property int collisionBottom: collisionEnabled && target ? target.parent.height : 0

    acceptedButtons: Qt.LeftButton
    onPressed: {
        lastX = mouseX
        lastY = mouseY
    }
    onPositionChanged: {
        if (moveEnabled && pressed && target) {

            var x = target.x + mouseX - lastX
            var y = target.y + mouseY - lastY

            if(collisionEnabled) {
                if (x < collisionLeft)
                    x = collisionLeft
                if (x + target.width > collisionRight)
                    x = collisionRight - target.width

                if (y < collisionTop)
                    y = collisionTop
                if(y + target.height > collisionBottom)
                    y = collisionBottom - target.height
            }

            target.x = x
            target.y = y
        }
    }

}
