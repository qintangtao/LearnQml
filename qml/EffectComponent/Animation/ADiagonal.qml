import QtQuick 2.12
import QtQuick.Controls 2.12

ShaderEffect {
    id: r
    enum Direct {
        FromLeftTop = 0,
        FromRightTop = 1,
        FromLeftBottom = 2,
        FromRightBottom = 3
    }

    property int dir: ADiagonal.Direct.FromLeftTop
    property int percent: 0
    property int duration: 1000
    property ShaderEffectSource effectSource: ShaderEffectSource {
            hideSource: true
        }

    opacity: percent > 0 ? 1 : 0
    NumberAnimation {
        id: animation
        target: r
        property: "percent"
        from: 0
        to: 100
        alwaysRunToEnd: true
        loops: 1
        duration: r.duration
    }

    fragmentShader: "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = float(percent) / 100.0;
            float ps[] = float[](2.0 * p - qt_TexCoord0.x - qt_TexCoord0.y,
                                qt_TexCoord0.y - (1.0 - 2.0 *(1.0 -  p)) - qt_TexCoord0.x,
                                qt_TexCoord0.x + (1.0 - 2.0 * p) - qt_TexCoord0.y,
                                qt_TexCoord0.y - 2.0 * (1.0 - p) + qt_TexCoord0.x);
            float alpha = step(0.0f, ps[dir]);
            gl_FragColor = vec4(color.rgb * alpha, alpha);
        }
"

    function restart() {
           animation.restart()
       }
}
