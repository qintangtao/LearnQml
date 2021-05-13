import QtQuick 2.0

MouseArea {

    enum MouseType {
        Other = 0,
        Left  = 1,
        Right = 2,
        Top = 3,
        Bottom = 4,
        LeftTop = 5,
        RightTop = 6,
        LeftBottom = 7,
        RightBottom = 8
    }

    property bool mask: false
    property var target: parent
    property int mouseType: TResizeArea.MouseType.Other
    property int border: 12
    property int minWidth: 0
    property int minHeight: 0

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton

    onPositionChanged: {
        if(mask || !target)
            return

        if (pressed) {
            resize(target.x + mouseX,  target.y + mouseY)
        } else {
            update(mouseX, mouseY)
        }
    }

    function update(offsetX, offsetY)
    {
        //console.log("update " + offsetX + " , " + offsetY);
        if(offsetX <= border)
        {
            if (offsetY <= border) {
                // ↖
                mouseType = TResizeArea.MouseType.LeftTop
                cursorShape = Qt.SizeFDiagCursor
            } else if (Math.abs(offsetY- target.height) <= border) {
                // ↙
                mouseType = TResizeArea.MouseType.LeftBottom
                cursorShape = Qt.SizeBDiagCursor
            } else {
                // ←
                mouseType = TResizeArea.MouseType.Left
                cursorShape = Qt.SizeHorCursor
            }
        } else if (Math.abs(offsetX-target.width) <= border) {
            if (offsetY <= border) {
                // ↗
                mouseType = TResizeArea.MouseType.RightTop
                cursorShape = Qt.SizeBDiagCursor
            } else if (Math.abs(offsetY-target.height) <= border) {
                // ↘
                mouseType = TResizeArea.MouseType.RightBottom
                cursorShape = Qt.SizeFDiagCursor
            } else {
                // →
                mouseType = TResizeArea.MouseType.Right
                cursorShape = Qt.SizeHorCursor
            }
        }
        else
        {
            if (offsetY <= border) {
                // ↑
                mouseType = TResizeArea.MouseType.Top;
                cursorShape = Qt.SizeVerCursor
            } else if (Math.abs(offsetY-target.height) <= border) {
                // ↓
                mouseType = TResizeArea.MouseType.Bottom;
                cursorShape = Qt.SizeVerCursor
            } else {
                mouseType = TResizeArea.MouseType.Other
                cursorShape = Qt.ArrowCursor
            }
        }
    }

    function resize(offsetX, offsetY)
    {
        var left = target.x
        var top = target.y
        var right = target.x+target.width
        var bottom = target.y + target.height

        switch(mouseType)
        {
        case TResizeArea.MouseType.LeftTop:
            left = offsetX
            top = offsetY
        break
        case TResizeArea.MouseType.LeftBottom:
            left = offsetX
            bottom = offsetY
        break
        case TResizeArea.MouseType.Left:
            left = offsetX
        break
        case TResizeArea.MouseType.RightTop:
            right = offsetX
            top = offsetY
        break
        case TResizeArea.MouseType.RightBottom:
            right = offsetX
            bottom = offsetY
        break
        case TResizeArea.MouseType.Right:
            right = offsetX
        break
        case TResizeArea.MouseType.Top:
            top = offsetY
        break
        case TResizeArea.MouseType.Bottom:
            bottom = offsetY
        break
        }

        if (left <= right && top <= bottom)
        {
            if (minWidth > (right - left))
            {
                if (left != target.x)
                    left = target.x
                else
                    right = target.x + target.width
            }

            if (minHeight > (bottom - top))
            {
                if (top != target.y)
                    top = target.y
                else
                    bottom = target.y + target.height
            }

            target.x = left
            target.y = top
            target.width = right - left
            target.height = bottom - top
        }
    }

}
