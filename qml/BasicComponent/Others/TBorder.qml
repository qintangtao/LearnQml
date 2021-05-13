import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12

Shape {
    id: root

    anchors.fill: parent

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

    ShapePath {
        id:  shapePathTop
        strokeWidth: borderWidth
        strokeColor: borderColor
        strokeStyle: borderStyle
        startX: 0
        startY: strokeWidth / 2
        onStrokeWidthChanged: if (strokeWidth == 0) strokeColor = "transparent";
        onStrokeColorChanged:  if (strokeWidth == 0) strokeColor = "transparent";
        PathLine {
            x: root.width
            y: shapePathTop.startY
        }
    }


    ShapePath {
        id:  shapePathRight
        strokeWidth: borderWidth
        strokeColor: borderColor
        strokeStyle: borderStyle
        startX: root.width - strokeWidth / 2
        startY: 0
        onStrokeWidthChanged: if (strokeWidth == 0) strokeColor = "transparent";
        onStrokeColorChanged:  if (strokeWidth == 0) strokeColor = "transparent";
        PathLine {
            x: shapePathRight.startX
            y: root.height
        }
    }

    ShapePath {
        id:  shapePathBottom
        strokeWidth: borderWidth
        strokeColor: borderColor
        strokeStyle: borderStyle
        startX: 0
        startY: root.height - strokeWidth / 2
        onStrokeWidthChanged: if (strokeWidth == 0) strokeColor = "transparent";
        onStrokeColorChanged:  if (strokeWidth == 0) strokeColor = "transparent";
        PathLine {
            x: root.width
            y: shapePathBottom.startY
        }
    }

    ShapePath {
        id:  shapePathLeft
        strokeWidth: borderWidth
        strokeColor: borderColor
        strokeStyle: borderStyle
        startX: strokeWidth / 2
        startY: 0
        onStrokeWidthChanged: if (strokeWidth == 0) strokeColor = "transparent";
        onStrokeColorChanged:  if (strokeWidth == 0) strokeColor = "transparent";
        PathLine {
            x: shapePathLeft.startX
            y: root.height
        }
    }

}


