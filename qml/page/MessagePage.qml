import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import "../js/common.js" as Common
import "."
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

            ListRecordModel {
                id: listRecordModel
            }

            ListView {
                id: listView
                anchors.fill: parent
                model: messageModel
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

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    console.log("id is " + id)

                                }
                            }
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
                        onClicked: {listView.currentIndex = index; wrapper.color = "transparent";
                            console.log("id is " + id)
                            //messageModel.setName(id, name + ",add")
                            messageModel.setDesc(id, desc + ",add")
                        }
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
            anchors.top: parent.top
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
}

