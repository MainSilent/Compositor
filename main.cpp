#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <backend.h>
#include <apps.h>
#include <icon.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    Icon icon;
    qmlRegisterType<Icon>("Backend", 1, 0, "Icon");
    qmlRegisterType<Backend>("Backend", 1, 0, "Backend");

    QQmlApplicationEngine engine;
    Apps apps;
    engine.rootContext()->setContextProperty("apps", apps.getApps());

    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
