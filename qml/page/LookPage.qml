import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import CppLookInfo 1.0

import "../js/common.js" as Common
import "./look/look.js" as JsLook
import "../BasicComponent/Others"
import "../BasicComponent/Button"
import "../BasicComponent/Mouse"
import "../"
import "look"

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
                text: qsTr("Look")
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

        Dialog {
            id: dlgUpdate
            implicitWidth: 160
            implicitHeight: implicitWidth
            anchors.centerIn: parent

            property alias text: labelText.text

            contentItem: Rectangle {
                Label {
                    id: labelText
                    anchors.fill: parent
                }
            }
        }

        Rectangle {
            id: rectRight
            anchors.left: leftContent.right
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            property int childZ: 0
            property LookInfo currentInfo

            Component.onCompleted: {
                if (rectRight.currentInfo)
                    console.log("currentInfo true")
                else
                    console.log("currentInfo false " + currentInfo)
            }

            onCurrentInfoChanged: {
                textInputId.text = currentInfo.id
                textInputX.text = currentInfo.x
                textInputY.text = currentInfo.y
                textInputW.text = currentInfo.width
                textInputH.text = currentInfo.height
            }

            Connections {
                target: rectRight.currentInfo
                onXChanged: textInputX.text = x
                onYChanged: textInputY.text = y
                onWidthChanged: textInputW.text = width
                onHeightChanged: textInputH.text = height
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 6

                Rectangle {
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 30
                    color: "#d6d6d6"

                    Label {
                        id: labelId
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("id: ")
                    }

                    TextInput {
                        id: textInputId
                        anchors.left: labelId.right
                        anchors.right: parent.right
                        enabled: false
                        height: parent.height
                        font.pixelSize: 18
                        leftPadding: 3
                        rightPadding: 3
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true

                        validator: IntValidator{
                            bottom: 0; top: 35;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 30
                    color: "#d6d6d6"

                    Label {
                        id: labelX
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("x: ")
                    }

                    TextInput {
                        id: textInputX
                        anchors.left: labelX.right
                        anchors.right: parent.right
                        height: parent.height
                        font.pixelSize: 18
                        leftPadding: 3
                        rightPadding: 3
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true

                        validator: IntValidator{
                            bottom: 0; top: rectRight.width;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 30
                    color: "#d6d6d6"

                    Label {
                        id: labelY
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("y: ")
                    }

                    TextInput {
                        id: textInputY
                        anchors.left: labelY.right
                        anchors.right: parent.right
                        height: parent.height
                        font.pixelSize: 18
                        leftPadding: 3
                        rightPadding: 3
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true

                        validator: IntValidator{
                            bottom: 0; top: rectRight.height;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 30
                    color: "#d6d6d6"

                    Label {
                        id: labelW
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("w: ")
                    }

                    TextInput {
                        id: textInputW
                        anchors.left: labelW.right
                        anchors.right: parent.right
                        height: parent.height
                        font.pixelSize: 18
                        leftPadding: 3
                        rightPadding: 3
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true

                        validator: IntValidator{
                            bottom: 0; top: rectRight.width;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 30
                    color: "#d6d6d6"

                    Label {
                        id: labelH
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("h: ")
                    }

                    TextInput {
                        id: textInputH
                        anchors.left: labelH.right
                        anchors.right: parent.right
                        height: parent.height
                        font.pixelSize: 18
                        leftPadding: 3
                        rightPadding: 3
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true

                        validator: IntValidator{
                            bottom: 0; top: rectRight.height;
                        }
                    }
                }

                Button {
                    text: "ok"
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 30
                    padding: 0
                    topInset: 0
                    bottomInset: 0
                    onClicked: {
                        //lookMgr.setLookInfoX(textInputId.text, textInputX.text)
                        //lookMgr.setLookInfoY(textInputId.text, textInputY.text)

                        if(!textInputId.acceptableInput)
                        {
                            dlgUpdate.title = qsTr("warn")
                            dlgUpdate.text = qsTr("invalid id ") + textInputId.text
                            dlgUpdate.open()
                            return
                        }
                        if(!textInputX.acceptableInput)
                        {
                            dlgUpdate.title = qsTr("warn")
                            dlgUpdate.text = qsTr("invalid x ") + textInputX.text
                            dlgUpdate.open()
                            return
                        }
                        if(!textInputY.acceptableInput)
                        {
                            dlgUpdate.title = qsTr("warn")
                            dlgUpdate.text = qsTr("invalid y ") + textInputY.text
                            dlgUpdate.open()
                            return
                        }
                        if(!textInputW.acceptableInput)
                        {
                            dlgUpdate.title = qsTr("warn")
                            dlgUpdate.text = qsTr("invalid w ") + textInputW.text
                            dlgUpdate.open()
                            return
                        }
                        if(!textInputH.acceptableInput)
                        {
                            dlgUpdate.title = qsTr("warn")
                            dlgUpdate.text = qsTr("invalid h ") + textInputH.text
                            dlgUpdate.open()
                            return
                        }

                        lookMgr.setLookInfoRect(textInputId.text, textInputX.text, textInputY.text, textInputW.text, textInputH.text);
                    }
                }
            }

        }
    }

    Component.onCompleted:  {
        lookMgr.load()
    }

    // C++ 信号监听
    Connections {
        target: lookMgr
        onAdd: {
            //console.log("addLookWindow " + info.id)
            JsLook.addLookWindow(rectRight, info)
        }

        onDel: {
            //console.log("delLookWindow " + id)
            JsLook.delLookWindow(id)
        }
    }
}

