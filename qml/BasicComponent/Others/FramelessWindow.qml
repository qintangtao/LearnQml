import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

import "."

Window {
    id:  window
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    default property alias content: shadowWindow.contentItem

    property alias enabledShadow: ds.enabled
    property alias samples: ds.samples
    property alias horizontalOffset: ds.horizontalOffset
    property alias verticalOffset: ds.verticalOffset

    /*
    TResizeArea {
        id: resizeArea
        anchors.fill: parent
        target: window
        minWidth: minimumWidth
        minHeight: minimumHeight
        visible: false
    }
*/

    Control {
        id: shadowWindow
        anchors.fill: parent
        anchors.margins: ds.enabled ?  resizeBorder.border : 0
        smooth: true
    }

    DropShadow {
        id: ds
        anchors.fill: shadowWindow
        enabled: !(isMinimized() || isMaximized() || isFullScreen())
        radius: 8.0
        samples: 20
        color: "#80000000"
        source: shadowWindow
    }

    TResizeBorder {
        id: resizeBorder
        anchors.fill: parent
        anchors.margins: ds.enabled ?  resizeBorder.border : 0
        control: window
        minWidth: window.minimumWidth
        minHeight: window.minimumHeight
        enabled: !(window.isMaximized() || window.isFullScreen())
        visible: true
    }

    function isMinimized() {
        return (window.visibility === Window.Minimized)
    }

    function isMaximized() {
        return (window.visibility === Window.Maximized)
    }

    function isFullScreen() {
        return (window.visibility === Window.FullScreen)
    }
}
