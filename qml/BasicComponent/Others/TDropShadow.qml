import QtQuick 2.12
import QtGraphicalEffects.private 1.12

Item {
    id: root

    TDropShadowBase {
        id: dbs
        anchors.fill: parent
    }

    property alias source: dbs.source
    property alias radius: dbs.radius;
    property alias samples: dbs.samples
    property alias color: dbs.color
    property alias horizontalOffset: dbs.horizontalOffset
    property alias verticalOffset: dbs.verticalOffset
    property alias spread: dbs.spread
    property bool fast: false
    property alias cached: dbs.cached
    property alias transparentBorder: dbs.transparentBorder
}
