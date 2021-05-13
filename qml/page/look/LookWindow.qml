import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12

import CppLookInfo 1.0
import "../../js/common.js" as Common
import "../../BasicComponent/Others"
import "../../BasicComponent/Button"
import "../../BasicComponent/Mouse"

Item {
    id: root
    x: 100
    y: 100
    width: 200
    height: 300
    clip: true

    property alias text: labelName.text
    property LookInfo info
    property bool hoverEnabled: false

    TMoveArea {
         anchors.fill: parent
         collision: true

         onPressed: {
             if (!hoverEnabled)
                root.z = ++root.parent.childZ

             root.parent.currentInfo = root.info
         }
    }

    Rectangle {
        id: rectContent
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#e0e0e0"
        opacity: 0.5

        TBorderV2 {
            borderTopEnabled: !rectHead.visible
        }
    }

    Rectangle {
        id: rectHead
        width: parent.width
        height: 30
        color: "#c6c6c6"
        y: hoverEnabled ? -height : 0
        visible: !hoverEnabled
        //z: 2

        Label {
           id: labelName
           height: parent.height
           anchors.left: parent.left
           anchors.leftMargin: 6
           verticalAlignment: Text.AlignVCenter
        }

        TImageButton {
            id: btn_close
            anchors.right: parent.right
            height: parent.height
            width: height
            imageWidth: 16
            imageHeight: 16
            hoveredColor: "#FA5151"
            pressedColor: "#DC4848"
            normalUrl: imgPath + "close.png"
            hoveredUrl: imgPath + "close_hover.png"
            pressedUrl: hoveredUrl
            onClicked:  Common.isNull(info) ? root.destroy() :  lookMgr.closeWindow(info.id)
        }
    }

    TResizeBorder {
        id: resizeBorder
        minWidth: 100
        minHeight: 100
    }

    TTransArea {
        id: area
        anchors.fill: parent
        enabled: false
        visible: enabled
        hoverEnabled: root.hoverEnabled
        onEntered: showHead();
        onExited: hideHead()
        onPressed: root.z = ++root.parent.childZ
        onPositionChanged: console.log("onPositionChanged mouseX " + mouseX + ", mouseY " + mouseY)
    }

    Timer {
          interval: 2000;
          running: false;
          repeat: true
          onTriggered: {
              //console.log("containsMouse is " + area.containsMouse)
             console.log("Timer id " + info.id + ", mouseX " + area.mouseX + ", mouseY " + area.mouseY)
              if(area.mouseX == 0 && area.mouseY)
                  hideHead()
          }
      }

    PropertyAnimation {
        id: animation
        target: rectHead
        properties: "y"
        duration: 300
        easing.type: Easing.Linear
        onStarted: {
            if (target.y === -target.height)
                target.visible = true
        }

        onFinished: {
            if (target.y === -target.height)
                target.visible = false

           // if (target.visible)
           //     area.hoverEnabled = false
        }
    }

    function showHead() {
        if (animation.running)
            animation.running = false

        animation.from = rectHead.y == -rectHead.height ? -rectHead.height : rectHead.y
        animation.to = 0
        animation.running = true
    }

    function hideHead() {
        if (animation.running)
            animation.running = false

        animation.from = rectHead.y == 0 ? 0 : rectHead.y
        animation.to = -rectHead.height
        animation.running = true
    }


    onInfoChanged: {
        if(Common.isNull(info))
            return
        console.log("onInfoChanged id " + info.id)
        root.text = info.name
        root.x = info.x
        root.y = info.y
        root.width = info.width
        root.height = info.height
    }

    onXChanged: if (!Common.isNull(info)) info.setX(x)
    onYChanged: if (!Common.isNull(info)) info.setY(y)
    onWidthChanged:  if (!Common.isNull(info)) info.setWidth(width)
    onHeightChanged:  if (!Common.isNull(info)) info.setHeight(height)

    Connections {
        target: info
        onXChanged: root.x = x
        onYChanged: root.y = y
        onWidthChanged: root.width = width
        onHeightChanged: root.height = height
    }

    /*
    Canvas {
        id: mycanvas
        anchors.fill: parent
        enabled: false
        visible: enabled

          onPaint: {
              var ctx = getContext("2d");
              ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
              //ctx.fillRect(0, 0, width, height);
              ctx.setLineDash([2])
              ctx.lineWidth = 4
              ctx.strokeStyle = '#c4c5c6'
              ctx.beginPath()
              ctx.moveTo(0, 0)
              ctx.lineTo(width, 0)
              ctx.lineTo(width, height)
              ctx.lineTo(0, height)
              ctx.lineTo(0, 0)
              ctx.stroke()
          }
      }
*/
}

