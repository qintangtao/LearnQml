import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Button {
    id: root

    property color color: "#4E5BF2"
    property color hoverColor: Qt.darker(color, 1.1)
    property color pressedColor: Qt.darker(color, 1.2)
    property color textColor: "white"

    contentItem: Text {
        text: root.text
        color: root.textColor
        font.pixelSize: 15
        font.family: "Arial"
        font.weight: Font.Thin
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id:rect_bg
        implicitWidth: 83
        implicitHeight: 37
        color: root.color
        radius: 3
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: rect_bg.color
            samples: 20
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: rect_bg.color = hoverColor
        onExited: rect_bg.color = color
        onPressed:  rect_bg.color = pressedColor
        onReleased: rect_bg.color = hoverColor
    }
}
