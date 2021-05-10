import QtQuick 2.0

Item {

    /*
    enum MouseType {
        Other = Qt.ArrowCursor,
        Left  = Qt.SizeHorCursor,
        Right = Qt.SizeHorCursor,
        Top = Qt.SizeVerCursor,
        Bottom = Qt.SizeVerCursor,
        LeftTop = Qt.SizeFDiagCursor,
        RightTop = Qt.SizeBDiagCursor,
        LeftBottom = Qt.SizeBDiagCursor,
        RightBottom = Qt.SizeFDiagCursor
    }
*/

    readonly property int posLeftTop: Qt.SizeFDiagCursor
    readonly property int posLeft: Qt.SizeHorCursor
    readonly property int posLeftBottom: Qt.SizeBDiagCursor
    readonly property int posTop: Qt.SizeVerCursor
    readonly property int posBottom: Qt.SizeVerCursor
    readonly property int posRightTop: Qt.SizeBDiagCursor
    readonly property int posRight: Qt.SizeHorCursor
    readonly property int posRightBottom: Qt.SizeFDiagCursor

    property int posType: Qt.ArrowCursor

    property alias containsMouse: area.containsMouse
    //property alias containsPress: area.containsPress

    signal posChange(int xOffset, int yOffset)

    implicitWidth: 12
    implicitHeight: 12


    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        property int lastX: 0
        property int lastY: 0

        onContainsMouseChanged: {
            console.log("onContainsMouseChanged " + pressed)
            if(!pressed)
                cursorShape = containsMouse ? posType : Qt.ArrowCursor
        }

        onPressedChanged: {
            if (pressed) {
                lastX = mouseX
                lastY = mouseY
            }
        }

        onPositionChanged: {
            if (pressed) {
                parent.posChange(mouseX-lastX, mouseY - lastY)
            }
        }
    }
}
