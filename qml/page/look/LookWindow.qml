import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12

import CppLookInfo 1.0
import "../../"
import "../../js/common.js" as Common

Item {
    id: root
    x: 100
    y: 100
    width: 200
    height: 300

    property alias text: labelName.text
    property LookInfo info

    TMoveArea {
         anchors.fill: parent

         onPressed: {
            root.z = ++root.parent.childZ
         }
    }

    Rectangle {
        id: rectHead
        width: parent.width
        height: 30
        color: "#c6c6c6"

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
            padding: 0
            leftInset: 0
            rightInset: 0
            topInset: 0
            bottomInset: 0
            hoveredColor: "#FA5151"
            pressedColor: "#DC4848"
            normalUrl: imgPath + "close.png"
            hoveredUrl: imgPath + "close_hover.png"
            pressedUrl: hoveredUrl
            onClicked: {
                console.log("close " + info.id)
                Common.isNull(info) ? root.destroy() :  lookMgr.closeWindow(info.id)
            }
        }
    }

    Rectangle {
        id: rectContent
        width: parent.width
        anchors.top: rectHead.bottom
        anchors.bottom: parent.bottom
        color: "#e0e0e0"
        opacity: 0.5

        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 1
                strokeColor: "#c6c6c6"
                strokeStyle: ShapePath.SolidLine
                startX: 1
                startY: 0
                PathLine {
                    x: 1
                    y: rectContent.height
                }
                PathLine {
                    x: rectContent.width
                    y: rectContent.height
                }
                PathLine {
                    x: rectContent.width
                    y: 0
                }
            }
        }
    }

    TResizeBorder {
        id: resizeBorder
        minWidth: 100
        minHeight: 100
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
        onXChanged: {
            root.x = x
            console.log("info.id " + info.id + ", info.x " + info.x)
        }
        onYChanged: {
            root.y = y
            console.log("info.id " + info.id + ", info.y " + info.y)
        }
        onWidthChanged: {
            root.width = width
            console.log("info.id " + info.id + ", info.width " + info.width)
        }
        onHeightChanged: {
            root.height = height
            console.log("info.id " + info.id + ", info.height " + info.height)
        }
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

