import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    id:  mainWindow
    visible: true
    width: 940
    height: 480
    title: qsTr("Hello World")
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: leftheader
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 70
        color: "#26282c"

        TMoveArea {
            target: mainWindow
            anchors.fill: parent
        }
    }

    Rectangle {
        id: topheader
        anchors.top: parent.top
        anchors.left: leftheader.right
        anchors.right: parent.right
        height: 60
        color: "#f5f5f5"

        TMoveArea {
            target: mainWindow
            anchors.fill: parent
        }
    }

    /*
    ListModel{
           id:model
           ListElement{url:"qrc:/images/flow/01.png"}
           ListElement{url:"qrc:/images/flow/02.png"}
           ListElement{url:"qrc:/images/flow/03.png"}
           ListElement{url:"qrc:/images/flow/04.png"}
           ListElement{url:"qrc:/images/flow/05.png"}
       }

    Coverflow {
            id:flow
            width: parent.width
            height: 300
            anchors.top: parent.top
            model:model
            itemWidth: 300
            itemHeight: 300
    }


    Rectangle {
        id: test21
        width: 100
        height: 30
        anchors.top: flow.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#FF0000"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.color = "#00FF00"
                a2.restart()
            }
        }
    }

    Rectangle {
        id: flashingblob
        anchors.top: flow.bottom
        anchors.topMargin: 10
        anchors.left:test21.right
        width: 75; height: 75
        color: "blue"
        opacity: 1.0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                animateColor.start()
                animateOpacity.start()
                a2.restart()
            }
        }

        PropertyAnimation {id: animateColor; target: flashingblob; properties: "color"; to: "green"; duration: 1000}

        NumberAnimation {
            id: animateOpacity
            target: flashingblob
            properties: "opacity"
            from: 0.09
            to: 1.0
            loops: Animation.Infinite
            easing {type: Easing.OutBack; overshoot: 500}
       }
    }

    Rectangle {
        id: rect
        anchors.top: flashingblob.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 100; height: 100
        color: "red"

        Behavior on width {
            NumberAnimation { duration: 1000 }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: rect.width = 50
        }
    }
*/

    Column {
        anchors.top: topheader.bottom
        anchors.left: leftheader.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 20

        Row {
            width: parent.width
            height: 100
            spacing: 10

            AGrad {
                    id: a2
                    width: 320
                    height: 100
                    effectSource.sourceItem: Image {
                        anchors.fill: parent
                        source: "qrc:/images/aboutBackground.png"
                    }
                }
            Rectangle {
                width: 50
                height: parent.height
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    onClicked: a2.restart()
                }
            }

            ACleavage {
                id: idACleavage
                width: 320
                height: 100
                dir: ACleavage.Direct.HorizonToOuter
                effectSource.sourceItem: Image {
                    anchors.fill: parent
                    source: "qrc:/images/aboutBackground.png"
                }
            }
            Rectangle {
                width: 50
                height: parent.height
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    onClicked: idACleavage.restart()
                }
            }
        }

        Row {
            width: parent.width
            height: 100
            spacing: 10

            ADiagonal {
                    id: idADiagonal
                    width: 320
                    height: 100
                    effectSource.sourceItem: Image {
                        anchors.fill: parent
                        source: "qrc:/images/aboutBackground.png"
                    }
                }
            Rectangle {
                width: 50
                height: parent.height
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    onClicked: idADiagonal.restart()
                }
            }

            ACircle {
                    id: idACircle
                    width: 320
                    height: 100
                    dir: ACircle.Direct.FromOuter
                    effectSource.sourceItem: Image {
                        anchors.fill: parent
                        source: "qrc:/images/aboutBackground.png"
                    }
                }
            Rectangle {
                width: 50
                height: parent.height
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    onClicked: idACircle.restart()
                }
            }

        }


        Row {
            width: parent.width
            height: 100
            spacing: 10

            AWheel {
                    id: idAWheel
                    width: 320
                    height: 100
                    effectSource.sourceItem: Image {
                        anchors.fill: parent
                        source: "qrc:/images/aboutBackground.png"
                    }
                }
            Rectangle {
                width: 50
                height: parent.height
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    onClicked: idAWheel.restart()
                }
            }
        }

    }
}

/*
   Control {
       id: shadowWindow
       anchors.fill: parent
       padding: 8

       contentItem:  Rectangle {
           color: "#f5f5f5"
           radius: 3

           Rectangle {
               id: leftheader
               anchors.top: parent.top
               anchors.bottom: parent.bottom
               anchors.left: parent.left
               width: 70
               color: "#26282c"

               TMouseArea {
                   control: mainWindow
                   anchors.fill: parent
               }
           }

           Rectangle {
               id: topheader
               anchors.top: parent.top
               anchors.left: leftheader.right
               anchors.right: parent.right
               height: 60
               color: "#f5f5f5"

               TMouseArea {
                   control: mainWindow
                   anchors.fill: parent
               }

               Rectangle {
                   anchors.top: parent.top
                   anchors.right: parent.right
                   width: 30
                   height: 30
                   color: "#787878"
                   MouseArea {
                       anchors.fill: parent
                       onClicked: mainWindow.close()
                   }
               }
           }
       }
   }

   DropShadow {
       anchors.fill: shadowWindow
       radius: 8
       samples: 16
       color: "#80000000"
       source: shadowWindow
   }
*/
