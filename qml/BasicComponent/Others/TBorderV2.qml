import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12

Item {
    id: root

    anchors.fill: parent

    property alias borderTopEnabled: shapeTop.enabled
    property alias borderRightEnabled: shapeRight.enabled
    property alias borderBottomEnabled: shapeBootom.enabled
    property alias borderLeftEnabled: shapeLeft.enabled

    property int borderWidth: 1
    property alias borderTopWidth: shapePathTop.strokeWidth
    property alias borderRightWidth: shapePathRight.strokeWidth
    property alias borderBottomWidth: shapePathBottom.strokeWidth
    property alias borderLeftWidth: shapePathLeft.strokeWidth

    property color borderColor: "#c6c6c6"
    property alias borderTopColor: shapePathTop.strokeColor
    property alias borderRightColor: shapePathRight.strokeColor
    property alias borderBottomColor: shapePathBottom.strokeColor
    property alias borderLeftColor: shapePathLeft.strokeColor

    property int borderStyle: ShapePath.SolidLine
    property alias borderTopStyle: shapePathTop.strokeStyle
    property alias borderRightStyle: shapePathRight.strokeStyle
    property alias borderBottomStyle: shapePathBottom.strokeStyle
    property alias borderLeftStyle: shapePathLeft.strokeStyle



    Shape {
        id: shapeTop
        anchors.fill: parent
        visible: enabled && shapePathTop.strokeWidth > 0

        ShapePath {
            id:  shapePathTop
            strokeWidth: borderWidth
            strokeColor: borderColor
            strokeStyle: borderStyle
            startX: 0
            startY: strokeWidth / 2
            PathLine {
                x: root.width
                y: shapePathTop.startY
            }
        }
    }

    Shape {
        id: shapeRight
        anchors.fill: parent
        visible: enabled && shapePathRight.strokeWidth > 0

        ShapePath {
            id:  shapePathRight
            strokeWidth: borderWidth
            strokeColor: borderColor
            strokeStyle: borderStyle
            startX: root.width - strokeWidth / 2
            startY: 0
            PathLine {
                x: shapePathRight.startX
                y: root.height
            }
        }
    }


    Shape {
        id: shapeBootom
        anchors.fill: parent
        visible: enabled && shapePathBottom.strokeWidth > 0

        ShapePath {
            id:  shapePathBottom
            strokeWidth: borderWidth
            strokeColor: borderColor
            strokeStyle: borderStyle
            startX: 0
            startY: root.height - strokeWidth / 2
            PathLine {
                x: root.width
                y: shapePathBottom.startY
            }
        }
    }



    Shape {
        id: shapeLeft
        anchors.fill: parent
        visible: enabled && shapePathLeft.strokeWidth > 0

        ShapePath {
            id:  shapePathLeft
            strokeWidth: borderWidth
            strokeColor: borderColor
            strokeStyle: borderStyle
            startX: strokeWidth / 2
            startY: 0
            PathLine {
                x: shapePathLeft.startX
                y: root.height
            }
        }
    }
}

