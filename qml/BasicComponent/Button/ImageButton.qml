import QtQuick 2.4
import QtQuick.Controls 2.5

Item {
    id: root

    property bool checkable: false
    property bool cancelable: true
    property bool checked: false

    property url normalUrl
    property url hoveredUrl
    property url pressedUrl
    property url checkedUrl
    property url disabledUrl

    property alias imageItem: img
    property alias imageUrl: img.source

    property alias imageWidth: img.width
    property alias imageHeight: img.height
    property alias imageAnchors: img.anchors

    property alias hoverEnabled: area.hoverEnabled
    property alias hovered: area.containsMouse
    property alias pressed: area.containsPress
    property alias cursorShape: area.cursorShape

    signal clicked();

    Image {
        id: img
        //anchors.fill: parent
        anchors.centerIn: parent
        enabled: parent.enabled
        source: parent.enabled ?  (pressed && !checked ?  (isEmpty(pressedUrl) ? normalUrl : pressedUrl) : (hovered && !checked ? (isEmpty(hoveredUrl ) ? normalUrl : hoveredUrl) : (checked ? checkedUrl :  normalUrl))) : (isEmpty(disabledUrl) ? normalUrl : disabledUrl)
    }

    MouseArea {
        id: area
        anchors.fill: parent
        enabled: parent.enabled
        hoverEnabled: parent.enabled
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (checkable) {
                if (parent.checked && !cancelable)
                    return
                parent.checked = !parent.checked
            }
            parent.clicked()
        }
    }

    function isEmpty(obj){
        if(typeof obj == "undefined" || obj == null || obj == ""){
            return true;
        }else{
            return false;
        }
    }
}

