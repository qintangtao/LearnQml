QT += quick quickcontrols2
CONFIG += c++11

TARGET = LearnQml
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0



HEADERS += \
    QmlContext.h

SOURCES += \
        main.cpp \
    QmlContext.cpp

DEFINES += headPath=\\\"file:///$$PWD/images/head/\\\"

CONFIG(debug, debug|release) {
    #debug模式直接用本地qml文件,不要qrc资源文件。这样调试快一些。
    RESOURCES += \
        $$PWD/qmld.qrc

    DEFINES += qmlPath=\\\"file:///$$PWD/qml/\\\"
    DEFINES += imgPath=\\\"file:///$$PWD/images/\\\"
} else {
    #release模式用qrc、走资源文件。这样发布不会携带源码。
    RESOURCES += \
        $$PWD/qml.qrc \
        $$PWD/image.qrc

    DEFINES += qmlPath=\\\"qrc:/qml/\\\"
    DEFINES += imgPath=\\\"qrc:/images/\\\"
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


