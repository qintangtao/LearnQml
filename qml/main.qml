import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import "js/common.js" as Common
import "."

FramelessWindow {
    id:  window
    width: 860
    height: 584
    minimumWidth: leftheader.width + leftContent.width + leftContent.width
    minimumHeight: minimumWidth * 0.68
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        radius: 3

        Rectangle {
            id: leftheader
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: 60
            color: "#26292c"

            TMoveArea {
                target: window
                anchors.fill: parent
                anchors.topMargin: 9
                anchors.leftMargin: 9
                anchors.bottomMargin: 9
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

            /*

            RoundImage {
                id: img_account
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.6
                height: width
                anchors.topMargin: (parent.width - width) / 2
                source: headPath + "account.jpg"
             }

            TabBar {
                id: bar
                anchors.top: img_account.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: btn_more.top
                anchors.topMargin: 20

                TabButton {
                    id: btn_msg
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: width

                    icon.source : imgPath + "left_bar/msg_selected.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color : "transparent"
                }

                TabButton {
                    id: btn_contact
                    anchors.top: btn_msg.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: width

                    icon.source: checked ? imgPath + "left_bar/contact_selected.png" : imgPath + "left_bar/contact.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color : "transparent"
                }

            }

*/

            ColumnLayout {
                id: layout_left_tab
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

        }

        Rectangle {
            id: topheader
            anchors.top: parent.top
            anchors.left: leftheader.right
            anchors.right: parent.right
            height: 60
            color: "#f5f5f5"

            Rectangle {
                id: top_left_header
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 250
                color: "#EBE8E7"
            }

            Item {
                id: top_right_header
                anchors.left: top_left_header.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: btn_close.left

                Label {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 16
                    verticalAlignment: Text.AlignVCenter
                    text: Global.appname
                    font.pixelSize: 18
                    font.bold: true
                }
            }

            TMoveArea {
                target: window
                anchors.fill: parent
                anchors.topMargin: 9
                anchors.rightMargin: 9
            }

            TImageButton {
                id: btn_top
                anchors.top: parent.top
                anchors.right: btn_min.left
                width: 30
                height: 30
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
                anchors.top: parent.top
                anchors.right: btn_max.left
                width: 30
                height: 30
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
                anchors.top: parent.top
                anchors.right: btn_close.left
                width: 30
                height: 30
                imageWidth: 16
                imageHeight: 16
                padding: 0
                leftInset: 0
                rightInset: 0
                topInset: 0
                bottomInset: 0
                hoveredColor: "#E5E5E5"
                pressedColor: "#CDCDCD"
                normalUrl: isMaximized() ? imgPath + "max_restore.png" : imgPath + "max.png"
                onClicked: isMaximized() ? window.showNormal() : window.showMaximized()
            }

            TImageButton {
                id: btn_close
                anchors.top: parent.top
                anchors.right: parent.right
                width: 30
                height: 30
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

        Rectangle {
            id: leftContent
            anchors.left: leftheader.right
            anchors.top: topheader.bottom
            anchors.bottom: parent.bottom
            width: 250
            color: "#EBE8E7"

            ListRecordModel {
                id: listRecordModel
            }

            ListView {
                id: listView
                anchors.fill: parent
                model: listRecordModel
                clip: true

                Component {
                    id: highlight
                    Rectangle {
                            width: listView.width
                            height: 50
                            color: "#C4C5C6"
                            radius: 0
                            y: listView.currentItem.y
                            Behavior on y {
                                // 弹簧动画
                                SpringAnimation {
                                    spring: 3
                                    damping: 0.2
                                }
                            }
                        }
                }

                highlight: highlight
                highlightFollowsCurrentItem: true
                focus: true

                delegate: Rectangle {
                    id: wrapper
                    width: listView.width
                    height: 60
                    color: "transparent"

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 9
                        color: "transparent"

                        Image {
                            id: image_ico
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: parent.height
                            source: headPath + ico
                         }

                        Label {
                            id: text_name
                            anchors.left: image_ico.right
                            anchors.top: parent.top
                            anchors.right: text_date.left
                            height:parent.height / 2
                            anchors.leftMargin: 6
                            anchors.rightMargin: 6
                            verticalAlignment: Text.AlignBottom
                            bottomPadding: 3
                            elide: Text.ElideRight
                            maximumLineCount:1
                            color: "#000000"
                            text: name
                        }

                        Label {
                            id: text_desc
                            anchors.top:text_name.bottom
                            anchors.bottom: parent.bottom
                            anchors.left: image_ico.right
                            anchors.right: item_mute.left
                            anchors.leftMargin: 6
                            anchors.rightMargin: 6
                            verticalAlignment: Text.AlignTop
                            topPadding: 6
                            font.pixelSize: 12
                            color: "#999999"
                            elide: Text.ElideRight
                            maximumLineCount:1
                            text: desc
                        }

                        Label {
                            id: text_date
                            anchors.right: parent.right
                            anchors.top: parent.top
                            height: parent.height / 2
                            width: 40
                            verticalAlignment: Text.AlignBottom
                            horizontalAlignment: Text.AlignRight
                            bottomPadding: 6
                            font.pointSize: 9
                            color: "#999999"
                            text: Common.date2string(date)
                        }

                        Item {
                            id: item_mute
                            anchors.top: text_date.bottom
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            width: height

                            Image {
                                id: i
                                width: 16
                                height: 16
                                anchors.centerIn: parent
                                visible: !remind
                                source:  imgPath + "mute.png"
                             }
                        }
                    }


                    MouseArea {
                        id: ma
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {listView.currentIndex = index; wrapper.color = "transparent"}
                        onEntered: {if(!wrapper.ListView.isCurrentItem) wrapper.color = "#DCDBDA"; vScrollBar.visible=true;}
                        onExited: {if(!wrapper.ListView.isCurrentItem) wrapper.color = "transparent"; vScrollBar.visible=false;}
                    }

                    states: [
                        State {
                            name: "NORMAL"
                            PropertyChanges {
                                target: wrapper
                                color: "#EBE8E7"
                            }
                        },

                        State {
                            name: "HOVER"
                            PropertyChanges {
                                target: wrapper
                                color: "#DCDBDA"
                            }
                        },

                        State {
                            name: "SELECTED"
                            PropertyChanges {
                                target: wrapper
                                color: "#C4C5C6"
                            }
                        }
                    ]
                }

                ScrollBar.vertical: ScrollBar {
                    id: vScrollBar
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    width: 8
                    hoverEnabled: true
                    active: hovered || pressed
                    size: 1
                    visible: false
                    topInset: 0
                    rightInset: 0
                    leftInset: 0
                    bottomInset: 0
                    padding: 0

                    contentItem: Rectangle {
                        implicitWidth: vScrollBar.width
                        implicitHeight: 100
                        radius: width / 2
                        color: vScrollBar.pressed ? "#b4b1b0" : "#cbc8c6"
                    }

                }
            }
        }

        Rectangle {
            id: rightContent
            anchors.left: leftContent.right
            anchors.right: parent.right
            anchors.top: topheader.bottom
            anchors.bottom: parent.bottom
            color: "#F5F5F5"


            Component {
                id: highlight2
                Rectangle {
                    width: list.width; height: 40
                    color: "lightsteelblue"; radius: 5
                    y: list.currentItem.y
                    Behavior on y {
                        SpringAnimation {
                            spring: 3
                            damping: 0.2
                        }
                    }
                }
            }

            ListView {
                id: list
                anchors.fill: parent
                clip: true
                model: 5

                delegate: Label {
                    width: list.width
                    height: 40
                    verticalAlignment:Text.AlignVCenter
                    leftPadding: 5
                    text: "name_" + index

                    MouseArea {
                        anchors.fill: parent
                        onClicked: list.currentIndex = index
                    }
                }

                highlight: highlight2
                highlightFollowsCurrentItem: false
                focus: true
            }
        }

    }

    Component.onCompleted:  {
        var len = layout_left_tab.children.length
        if (len > 0)
            layout_left_tab.children[0].checked = true
    }

    function setButtonChcked(btn) {
        var len = layout_left_tab.children.length
        console.log("layout_left_tab.children.lenght=" + len)
        for (var i=0; i<len; i++) {
            if (layout_left_tab.children[i] !== btn)
                layout_left_tab.children[i].checked = false
        }
    }

}
