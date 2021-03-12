#include "backend.h"
#include <QDebug>
#include <QProcess>

Backend::Backend(QObject *parent) : QObject(parent)
{

}

void Backend::run(QString path)
{
    QProcess::startDetached(path);
}

void Backend::power(QString action)
{
    if (action == "Shutdown")
        QProcess::execute("shutdown -h now");
    else if (action == "Restart")
        QProcess::execute("reboot");
    else if (action == "Sleep")
        QProcess::execute("systemctl suspend");
    else if (action == "Lock")
        QProcess::execute("xdg-screensaver lock");
}
