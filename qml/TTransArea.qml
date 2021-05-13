import QtQuick 2.12
import QtQuick.Controls 2.12

MouseArea {

    property bool accepted: false

    anchors.fill: parent
    hoverEnabled: true
    propagateComposedEvents: true
    onDoubleClicked: mouse.accepted = accepted
    onPositionChanged: mouse.accepted = accepted
    onPressed:  mouse.accepted = accepted
    onPressAndHold: mouse.accepted = accepted
    onClicked:  mouse.accepted = accepted
    onReleased: mouse.accepted = accepted
    onWheel: wheel.accepted = accepted
}
