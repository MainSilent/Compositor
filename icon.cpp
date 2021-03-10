#include "icon.h"
#include <QDebug>

Icon::Icon(QObject *parent) : QObject(parent)
{

}

QString Icon::getIcon() const
{
    return path;
}

void Icon::setIcon(const QString &pid)
{
    path = "qrc:/images/dock/defaultApp.png";

    emit iconChanged();
}
