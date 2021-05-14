import QtQuick 2.4
import QtQuick.Controls 2.5

Item {
    id: root
    //target 要控制大小的目标，可以是Item，也可以是view，只要提供x、y、width、height等属性的修改
    //默认值为parent
    anchors.fill: parent

    property var target: parent

    property int minWidth: 0
    property int minHeight: 0
    property int border: 8

    //左上角的拖拽
    TDragItem {
        id: leftTopHandle
        posType: posLeftTop
        width: border
        height: border
        onPosChanged: {
            if (target.width - xOffset >= minWidth) {
                target.width-= xOffset;
                if (target.x + xOffset < target.x + target.width)
                    target.x += xOffset;
            }
            if (target.height -yOffset >= minHeight) {
                target.height -= yOffset;
                if (target.y + yOffset < target.y + target.height)
                    target.y += yOffset;
            }
        }
    }
    //右上角拖拽
    TDragItem {
        id: rightTopHandle
        posType: posRightTop
        width: border
        height: border
        x: parent.width - width
        onPosChanged: {
            //向左拖动时，xOffset为负数
            if (target.width + xOffset >= minWidth)
                target.width += xOffset;
            if (target.height - yOffset >= minHeight) {
                target.height -= yOffset;
                if (target.y + yOffset < target.y + target.height)
                    target.y += yOffset;
            }
        }
    }
    //左下角拖拽
    TDragItem {
        id: leftBottomHandle
        posType: posLeftBottom
        width: border
        height: border
        y: parent.height - height
        onPosChanged: {
            if (target.width - xOffset >= minWidth) {
                target.width-= xOffset;
                if (target.x + xOffset < target.x + target.width)
                    target.x += xOffset;
            }
            if (target.height + yOffset >= minHeight)
                target.height += yOffset;
        }
    }
    //右下角拖拽
    TDragItem {
        id: rightBottomHandle
        posType: posRightBottom
        width: border
        height: border
        x: parent.width - width
        y: parent.height - height
        onPosChanged: {
            if (target.width + xOffset >= minWidth)
                target.width += xOffset;
            if (target.height + yOffset >= minHeight)
                target.height += yOffset;
        }
    }
    //上边拖拽
    TDragItem {
        posType: posTop
        width: parent.width - leftTopHandle.width - rightTopHandle.width
        height: border
        x: leftBottomHandle.width
        onPosChanged: {
            if (target.height - yOffset >= minHeight) {
                target.height -= yOffset;

                if (target.y + yOffset < target.y + target.height)
                    target.y += yOffset;
            }
        }
    }

    //左边拖拽
    TDragItem {
        posType: posLeft
        width: border
        height: parent.height - leftTopHandle.height - leftBottomHandle.height
        y: leftTopHandle.height
        onPosChanged: {
            if (target.width - xOffset >= minWidth) {
                target.width-= xOffset;
                if (target.x + xOffset < target.x + target.width)
                    target.x += xOffset;
            }
        }
    }
    //右边拖拽
    TDragItem {
        posType: posRight
        x: parent.width - width
        width: border
        height: parent.height - rightTopHandle.height - rightBottomHandle.height
        y: rightTopHandle.height
        onPosChanged: {
            if (target.width + xOffset >= minWidth)
                target.width += xOffset;
        }
    }
    //下边拖拽
    TDragItem {
        posType: posBottom
        x: leftBottomHandle.width
        y: parent.height - height
        width: parent.width - leftBottomHandle.width - rightBottomHandle.width
        height: border
        onPosChanged: {
            if (target.height + yOffset >= minHeight)
                target.height += yOffset;
        }
    }

}
