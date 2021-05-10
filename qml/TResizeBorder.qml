import QtQuick 2.4
import QtQuick.Controls 2.5

Item {
    id: root
    //controller 要控制大小的目标，可以是Item，也可以是view，只要提供x、y、width、height等属性的修改
    //默认值为parent
    property var control: parent

    property int minWidth: control.minimumWidth
    property int minHeight: control.minimumHeight
    property int border: 8

    //左上角的拖拽
    TDragItem {
        id: leftTopHandle
        posType: posLeftTop
        width: border
        height: border
        onPosChange: {
            if (control.width - xOffset >= minWidth) {
                control.width-= xOffset;
                if (control.x + xOffset < control.x + control.width)
                    control.x += xOffset;
            }
            if (control.height -yOffset >= minHeight) {
                control.height -= yOffset;
                if (control.y + yOffset < control.y + control.height)
                    control.y += yOffset;
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
        onPosChange: {
            //向左拖动时，xOffset为负数
            if (control.width + xOffset >= minWidth)
                control.width += xOffset;
            if (control.height - yOffset >= minHeight) {
                control.height -= yOffset;
                if (control.y + yOffset < control.y + control.height)
                    control.y += yOffset;
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
        onPosChange: {
            if (control.width - xOffset >= minWidth) {
                control.width-= xOffset;
                if (control.x + xOffset < control.x + control.width)
                    control.x += xOffset;
            }
            if (control.height + yOffset >= minHeight)
                control.height += yOffset;
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
        onPosChange: {
            if (control.width + xOffset >= minWidth)
                control.width += xOffset;
            if (control.height + yOffset >= minHeight)
                control.height += yOffset;
        }
    }
    //上边拖拽
    TDragItem {
        posType: posTop
        width: parent.width - leftTopHandle.width - rightTopHandle.width
        height: border
        x: leftBottomHandle.width
        onPosChange: {
            if (control.height - yOffset >= minHeight) {
                control.height -= yOffset;

                if (control.y + yOffset < control.y + control.height)
                    control.y += yOffset;
            }
        }
    }

    //左边拖拽
    TDragItem {
        posType: posLeft
        width: border
        height: parent.height - leftTopHandle.height - leftBottomHandle.height
        y: leftTopHandle.height
        onPosChange: {
            if (control.width - xOffset >= minWidth) {
                control.width-= xOffset;
                if (control.x + xOffset < control.x + control.width)
                    control.x += xOffset;
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
        onPosChange: {
            if (control.width + xOffset >= minWidth)
                control.width += xOffset;
        }
    }
    //下边拖拽
    TDragItem {
        posType: posBottom
        x: leftBottomHandle.width
        y: parent.height - height
        width: parent.width - leftBottomHandle.width - rightBottomHandle.width
        height: border
        onPosChange: {
            if (control.height + yOffset >= minHeight)
                control.height += yOffset;
        }
    }

}
