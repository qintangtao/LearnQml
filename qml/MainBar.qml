import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "./BasicComponent/Button"
import "./BasicComponent/Others"
import "./BasicComponent/Mouse"

Rectangle {
    id: root

    property int currentIndex: 0

    TMoveArea {
        target: window
        anchors.fill: parent
        anchors.topMargin: 9
        anchors.leftMargin: 9
        anchors.bottomMargin: 9
        enabled: !(window.isMaximized() || window.isFullScreen())
    }

    RoundImageButton {
        id: img_account
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.6
        height: width
        anchors.topMargin: 20
        normalUrl: headPath + "account.jpg"
     }

    ColumnLayout {
        id: columnLayout
        anchors.top: img_account.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 12
        spacing: 0

        TImageButton {
            id: btn_msg
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.width * 0.85
            checkable: true
            cancelable: false
            imageWidth: 32
            imageHeight: 32

            normalUrl: imgPath + "left_bar/msg.png"
            hoveredUrl: imgPath + "left_bar/msg_hover.png"
            pressedUrl: imgPath + "left_bar/msg_selected.png"
            checkedUrl: pressedUrl

            onClicked: setButtonChcked(this)
        }


        TImageButton {
            id: btn_contact
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.width * 0.85
            checkable: true
            cancelable: false
            imageWidth: 32
            imageHeight: 32

            normalUrl: imgPath + "left_bar/contact.png"
            hoveredUrl: imgPath + "left_bar/contact_hover.png"
            pressedUrl: imgPath + "left_bar/contact_selected.png"
            checkedUrl: pressedUrl

            onClicked: setButtonChcked(this)
        }

        TImageButton {
            id: btn_collect
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.width * 0.85
            checkable: true
            cancelable: false
            imageWidth: 32
            imageHeight: 32

            normalUrl: imgPath + "left_bar/collect.png"
            hoveredUrl: imgPath + "left_bar/collect_hover.png"
            pressedUrl: imgPath + "left_bar/collect_selected.png"
            checkedUrl: pressedUrl

            onClicked: setButtonChcked(this)
        }

        TImageButton {
            id: btn_folder
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.width * 0.85
            checkable: true
            cancelable: false
            imageWidth: 32
            imageHeight: 32

            normalUrl: imgPath + "left_bar/folder.png"
            hoveredUrl: imgPath + "left_bar/folder_hover.png"
            pressedUrl: imgPath + "left_bar/folder_selected.png"
            checkedUrl: pressedUrl

            onClicked: setButtonChcked(this)
        }

        TImageButton {
            id: btn_look
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.width * 0.85
            checkable: true
            cancelable: false
            imageWidth: 32
            imageHeight: 32

            normalUrl: imgPath + "left_bar/look.png"
            hoveredUrl: imgPath + "left_bar/look_hover.png"
            pressedUrl: imgPath + "left_bar/look_selected.png"
            checkedUrl: pressedUrl

            onClicked: setButtonChcked(this)
        }
    }

    ImageButton {
        id: btn_more
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: 32
        height: width
        imageWidth: width - 9
        imageHeight: width - 9
        normalUrl: imgPath + "left_bar/more.png"
        hoveredUrl: imgPath + "left_bar/more_hover.png"
        pressedUrl: imgPath + "left_bar/more_selected.png"
        checkedUrl: pressedUrl
    }

    Component.onCompleted:  {
        var len = columnLayout.children.length
        if (len > currentIndex)
            columnLayout.children[currentIndex].checked = true
    }

    function setButtonChcked(btn) {
        var len = columnLayout.children.length
        console.log("columnLayout.children.lenght=" + len)
        for (var i=0; i<len; i++) {
            if (columnLayout.children[i] !== btn)
                columnLayout.children[i].checked = false
            else
                currentIndex = i
        }
    }
}
