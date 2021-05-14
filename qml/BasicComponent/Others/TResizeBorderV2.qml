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

    //限制
    property bool collisionEnabled: false
    property int collisionLeft: 0
    property int collisionRight: collisionEnabled && target ? target.parent.width : 0
    property int collisionTop: 0
    property int collisionBottom: collisionEnabled && target ? target.parent.height : 0

    signal targetXChanged(int x)
    signal targetYChanged(int y)
    signal targetWidthChanged(int width)
    signal targetHeightChanged(int height)

    //左上角的拖拽
    TDragItem {
        id: leftTopHandle
        posType: posLeftTop
        width: border
        height: border
        onPosChanged: {
            leftPosChanged(xOffset)
            topPosChanged(yOffset)
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
            rightPosChanged(xOffset)
            topPosChanged(yOffset)
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
            leftPosChanged(xOffset)
            bottomPosChanged(yOffset)
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
            rightPosChanged(xOffset)
            bottomPosChanged(yOffset)
        }
    }
    //上边拖拽
    TDragItem {
        posType: posTop
        width: parent.width - leftTopHandle.width - rightTopHandle.width
        height: border
        x: leftBottomHandle.width
        onPosChanged: topPosChanged(yOffset)
    }
    //左边拖拽
    TDragItem {
        posType: posLeft
        width: border
        height: parent.height - leftTopHandle.height - leftBottomHandle.height
        y: leftTopHandle.height
        onPosChanged: leftPosChanged(xOffset)
    }
    //右边拖拽
    TDragItem {
        posType: posRight
        x: parent.width - width
        width: border
        height: parent.height - rightTopHandle.height - rightBottomHandle.height
        y: rightTopHandle.height
        onPosChanged: rightPosChanged(xOffset)
    }
    //下边拖拽
    TDragItem {
        posType: posBottom
        x: leftBottomHandle.width
        y: parent.height - height
        width: parent.width - leftBottomHandle.width - rightBottomHandle.width
        height: border
        onPosChanged: bottomPosChanged(yOffset)
    }

    function topPosChanged(yOffset) {
        if (target.height - yOffset >= minHeight) {
            if (collisionEnabled) {
                if (target.y + yOffset < collisionTop)
                    yOffset = collisionTop - target.y
            }
            targetHeightChanged(target.height - yOffset);
            if (target.y + yOffset < target.y + target.height)
                targetYChanged(target.y + yOffset);
        }
    }

   function leftPosChanged(xOffset)  {
        if (target.width - xOffset >= minWidth) {
            if (collisionEnabled) {
                if (target.x + xOffset < collisionLeft)
                    xOffset = collisionLeft - target.x
            }
            targetWidthChanged(target.width - xOffset);
            if (target.x + xOffset < target.x + target.width)
                targetXChanged(target.x + xOffset);
        }
    }

   function rightPosChanged(xOffset){
       if (target.width + xOffset >= minWidth) {
           if (collisionEnabled) {
               if (target.x + target.width + xOffset > collisionRight)
                   xOffset = collisionRight - target.x - target.width
           }
           targetWidthChanged(target.width + xOffset);
        }
   }

   function bottomPosChanged(yOffset){
       if (target.height + yOffset >= minHeight) {
           if (collisionEnabled) {
               if (target.y + target.height + yOffset > collisionBottom)
                   yOffset = collisionBottom - target.y - target.height
           }
           targetHeightChanged(target.height + yOffset);
       }
   }

}
