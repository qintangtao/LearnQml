import QtQuick 2.4
import QtQuick.Controls 2.5
Button {
    id: root

    property bool cancelable: true

    property url normalUrl
    property url hoveredUrl
    property url pressedUrl
    property url checkedUrl
    property url disabledUrl

    property color normalColor: "transparent"
    property color hoveredColor: "transparent"
    property color pressedColor: "transparent"
    property color checkedColor: "transparent"
    property color disabledColor: "transparent"

    property alias imageWidth: root.icon.width
    property alias imageHeight: root.icon.height

    property alias cursorShape: area.cursorShape

    hoverEnabled: true
    //icon.source: enabled ?  (pressed && !checked ?  pressedUrl : (hovered && !checked ? hoveredUrl : (checked ? checkedUrl :  normalUrl))) : disabledUrl
    icon.source: enabled ?  (pressed && !checked ?  (isEmpty(pressedUrl) ? normalUrl : pressedUrl) : (hovered && !checked ? (isEmpty(hoveredUrl ) ? normalUrl : hoveredUrl) : (checked ? checkedUrl :  normalUrl))) : (isEmpty(disabledUrl) ? normalUrl : disabledUrl)
    icon.color: "transparent"

    background: Rectangle {
       color: enabled ?  (pressed && !checked ?  (isEmpty(pressedColor) ? normalColor : pressedColor) : (hovered && !checked ? (isEmpty(hoveredColor ) ? normalColor : hoveredColor) : (checked ? checkedColor :  normalColor))) : (isEmpty(disabledColor) ? normalColor : disabledColor)
    }

    MouseArea {
        id: area
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: root.cancelable ? Qt.NoButton : (root.checked ? Qt.AllButtons :  Qt.NoButton)
    }

    /*
    TTransArea {
        id: area
        enabled: parent.enabled
        cursorShape: Qt.PointingHandCursor
        accepted:  cancelable ? false : root.checked
    }*/

    function isEmpty(obj){
        if(typeof obj == "undefined" || obj == null || obj == ""){
            return true;
        }else{
            return false;
        }
    }
}
