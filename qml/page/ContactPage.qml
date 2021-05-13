import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

import "../js/common.js" as Common
import "../BasicComponent/Others"
import "../BasicComponent/Button"
import "../BasicComponent/Mouse"
import "../"

Page {
    header: Rectangle {
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
            anchors.right: windowControl.left

            Label {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 16
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Conact")
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

        WindowControl {
            id: windowControl
            anchors.top: parent.top
            anchors.right: parent.right

            btnTop.onClicked: console.log("btnTop.onClicked")
        }

    }

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"

        Rectangle {
            id: leftContent
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 250
            color: "#EBE8E7"

            ListView {
                id: listView
                anchors.fill: parent
                model: contactModel
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
                            source: thumbnail
                         }

                        Label {
                            id: text_name
                            anchors.left: image_ico.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 6
                            anchors.rightMargin: 6
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            maximumLineCount:1
                            color: "#000000"
                            text: name
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
    }
}

