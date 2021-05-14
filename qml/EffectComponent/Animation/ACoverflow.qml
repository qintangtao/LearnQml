import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id:coverflow
    color:"black"

    property ListModel model

    property int itemCount: 5
    property int itemWidth: 200
    property int itemHeight: 200

    PathView{
        id:pathView

        anchors.fill: parent
        path:coverFlowPath
        pathItemCount: coverflow.itemCount
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        model:coverflow.model

        delegate: Rectangle {
            id:delegateItem
            width: coverflow.itemWidth
            height: coverflow.itemHeight
            z:PathView.iconZ
            scale:PathView.iconScale

            Image{
                id:image
                source: url
                width: parent.width
                height: parent.height
            }

            //倒影
            ShaderEffect {
                anchors.left: image.left
                anchors.top: image.bottom
                width: image.width
                height: image.height;
                property variant source: image;
                property size sourceSize: Qt.size(0.5 / image.width, 0.5 / image.height);
                fragmentShader: "
                        varying highp vec2 qt_TexCoord0;
                        uniform lowp sampler2D source;
                        uniform lowp vec2 sourceSize;
                        uniform lowp float qt_Opacity;
                        void main() {
                            lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
                            lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize) + texture2D(source, tc- sourceSize)
                            + texture2D(source, tc + sourceSize * vec2(1, -1))
                            + texture2D(source, tc + sourceSize * vec2(-1, 1)));
                            gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.2;
                        }
"
            }

            transform: Rotation{
                origin.x:image.width/2.0
                origin.y:image.height/2.0
                axis{x:0;y:1;z:0}
                angle: delegateItem.PathView.iconAngle
            }
        }

    }

    Path{
        id:coverFlowPath

        startX: 0
        startY: coverflow.height/3
        PathAttribute{name:"iconZ";value: 0}
        PathAttribute{name:"iconAngle";value: 70}
        PathAttribute{name:"iconScale";value: 0.6}

        PathLine{x:coverflow.width/2;y:coverflow.height/3}
        PathAttribute{name:"iconZ";value: 100}
        PathAttribute{name:"iconAngle";value: 0}
        PathAttribute{name:"iconScale";value: 1.0}

        PathLine{x:coverflow.width;y:coverflow.height/3}
        PathAttribute{name:"iconZ";value: 0}
        PathAttribute{name:"iconAngle";value: -70}
        PathAttribute{name:"iconScale";value: 0.6}

        PathPercent{value:1.0}
    }
}
