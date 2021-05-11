#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QQuickStyle>
#include "QmlContext.h"
#include "message/messagemodel.h"
#include "contact/contactmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

 #if 1
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("qmlPath", qmlPath);
    engine.rootContext()->setContextProperty("imgPath", imgPath);
    engine.rootContext()->setContextProperty("headPath", headPath);

    engine.rootContext()->setContextProperty("messageModel", new MessageModel());
    engine.rootContext()->setContextProperty("contactModel", new ContactModel());

    //registerQmlProperty(properties, ctx, "localMusicModel", new LocalMusicModel());


    engine.load(QUrl(qmlPath + QStringLiteral("main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
#else
        QQuickView view;
        view.setFlag(Qt::FramelessWindowHint);
        view.setResizeMode(QQuickView::SizeRootObjectToView);
        view.rootContext()->setContextProperty("view", &view);
        view.setSource(QUrl("qrc:/test.qml"));
        view.show();
#endif

    return app.exec();
}
