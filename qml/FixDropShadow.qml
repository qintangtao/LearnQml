import QtQuick 2.12
import QtGraphicalEffects.private 1.12
import QtGraphicalEffects 1.12

Item {
    id: root

    property variant source
    property real radius: Math.floor(samples / 2)
    property int samples: 9
    property color color: "black"
    property real horizontalOffset: 0
    property real verticalOffset: 0
    property real spread: 0.0
    property bool transparentBorder: true

    GaussianBlur {
        id: blur
        width: parent.width
        height: parent.height
        x: Math.round(horizontalOffset)
        y: Math.round(verticalOffset)
        source: root.source
        radius: root.radius
        samples: root.samples
        _thickness: root.spread
        transparentBorder: root.transparentBorder

        _color: root.color;
        _alphaOnly: true
        // ignoreDevicePixelRatio: root.ignoreDevicePixelRatio

        ShaderEffect {
            x: blur._outputRect.x - parent.x
            y: blur._outputRect.y - parent.y
            width: transparentBorder ? blur._outputRect.width : blur.width
            height: transparentBorder ? blur._outputRect.height : blur.height
            property variant source: blur._output;
        }

    }


}
