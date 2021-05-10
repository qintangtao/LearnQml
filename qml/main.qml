import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import "."
import "page"

FramelessWindow {
    id:  window
    width: 860
    height: 584
    minimumWidth: 600
    minimumHeight: minimumWidth * 0.68
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        radius: 3

        MainBar {
            id: leftheader
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: 60
            color: "#26292c"
        }

        SwipeView {
            id: swipView
            anchors.top: parent.top
            anchors.left: leftheader.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            orientation: Qt.Vertical
            interactive: false
            clip: true
            currentIndex: leftheader.currentIndex

            MessagePage {
                id: msgPage

            }

            MessagePage {
                id: contactPage
            }

            Page {
                id: collectPage
                Label {
                    anchors.fill: parent
                    text: qsTr("collect page")
                }
            }

            Page {
                id: folderPage
                Label {
                    anchors.fill: parent
                    text: qsTr("folder page")
                }
            }

            Page {
                id: lookPage
                Label {
                    anchors.fill: parent
                    text: qsTr("look page")
                }
            }

            Component.onCompleted:{
                contentItem.highlightMoveDuration = 0       //将移动时间设为0
            }
        }
    }

}
