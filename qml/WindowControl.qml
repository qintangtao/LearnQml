import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "."

RowLayout {
    spacing: 0

    property alias btnTop: btn_top
    property alias btnMin: btn_min
    property alias btnMax: btn_max
    property alias btnClose: btn_close

    TImageButton {
        id: btn_top
        Layout.preferredWidth: 30
        Layout.preferredHeight: 30
        imageWidth: 12
        imageHeight: 12
        padding: 0
        leftInset: 0
        rightInset: 0
        topInset: 0
        bottomInset: 0
        hoveredColor: "#E5E5E5"
        pressedColor: "#CDCDCD"
        normalUrl: imgPath + "top.png"
    }

    TImageButton {
        id: btn_min
        Layout.preferredWidth: 30
        Layout.preferredHeight: 30
        imageWidth: 16
        imageHeight: 16
        padding: 0
        leftInset: 0
        rightInset: 0
        topInset: 0
        bottomInset: 0
        hoveredColor: "#E5E5E5"
        pressedColor: "#CDCDCD"
        normalUrl: imgPath + "min.png"
        onClicked: window.showMinimized()
    }

    TImageButton {
        id: btn_max
        Layout.preferredWidth: 30
        Layout.preferredHeight: 30
        imageWidth: 16
        imageHeight: 16
        padding: 0
        leftInset: 0
        rightInset: 0
        topInset: 0
        bottomInset: 0
        hoveredColor: "#E5E5E5"
        pressedColor: "#CDCDCD"
        normalUrl: window.isMaximized() ? imgPath + "max_restore.png" : imgPath + "max.png"
        onClicked: window.isMaximized() ? window.showNormal() : window.showMaximized()
    }

    TImageButton {
        id: btn_close
        Layout.preferredWidth: 30
        Layout.preferredHeight: 30
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
        onClicked: window.close()
    }

}
