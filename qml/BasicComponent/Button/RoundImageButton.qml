import QtQuick 2.0
import QtGraphicalEffects 1.12

ImageButton {
    id: img

    property bool rounded: true
    property bool adapt: true

    imageWidth: width
    imageHeight: height

    layer.enabled: rounded
    layer.effect: OpacityMask {
        maskSource: Item {
            width: img.width
            height: img.height
            Rectangle {
                anchors.centerIn: parent
                width: img.adapt ? img.width : Math.min(img.width, img.height)
                height: img.adapt ? img.height : width
                radius: Math.min(width, height)
            }
        }
    }
 }
