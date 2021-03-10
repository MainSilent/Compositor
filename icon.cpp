#include "icon.h"
#include <QDir>
#include <QDebug>
#include <QJsonObject>
#include <QDirIterator>
#include <QJsonDocument>

Icon::Icon(QObject *parent) : QObject(parent)
{

}

QString Icon::getIcon() const
{
    return path;
}

QJsonObject Icon::syncIcons()
{
    // paths are in $XDG_DATA_DIRS [/usr/local/share/, /usr/share/, /var/lib/snapd/desktop, ~/.local/share]
    QJsonObject iconsData;
    QStringList dirs = QString::fromLocal8Bit(qgetenv("XDG_DATA_DIRS")).split(":");

    // get username to check for local path, if it does't exists add it
    QString username = qgetenv("USER");
    QString localPath = "/home/"+username+"/.local/share";
    if (username.isEmpty())
        username = qgetenv("USERNAME");
    if (!dirs.contains("~/.local/share") && !dirs.contains(localPath))
        dirs.append(localPath);

    // Iterate and get .desktop icon and path to a json format in ~/.cache/neo/compositor/icons.cache
    for (QString& dir : dirs) {
        // Set the full path
        dir = dir + (dir[dir.length()-1] == '/' ? "" : "/") + "applications";
        QDirIterator it(dir, QStringList() << "*.desktop", QDir::Files);
        // Read the files insert icon and exec to iconsData
        while (it.hasNext()) {
            QString Exec, Icon;
            QFile file(it.next());
            if (!file.open(QFile::ReadOnly | QFile::Text)) continue;
            QTextStream in(&file);
            QStringList desktopFile = in.readAll().split("\n");

            // Parse the file data
            if (desktopFile.contains("[Desktop Entry]")) {
                for (QString& data : desktopFile) {
                    if (data.contains("[Desktop Action"))
                        break;

                    QStringList KeyVal = data.split("=");
                    if (KeyVal[0] == "Exec") {
                        KeyVal.removeFirst();
                        Exec = KeyVal.join("=");
                    }
                    else if (KeyVal[0] == "Icon") {
                        KeyVal.removeFirst();
                        Icon = KeyVal.join("=");
                    }
                }
            }

            if (!Exec.isEmpty() && !Icon.isEmpty())
                iconsData[Exec] = Icon;

            file.close();
        }
    }

    // Save iconsData in  ~/.cache/neo/compositor/icons.cache
    QDir dir;
    QJsonDocument doc(iconsData);
    QString path = "/home/"+username+"/.cache/neo/compositor/";
    if (!dir.exists(path))
        dir.mkpath(path);

    QFile jsonFile("/home/"+username+"/.cache/neo/compositor/icons.cache");
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());

    return iconsData;
}

void Icon::setIcon(const QString &pid)
{
    QJsonObject data = syncIcons();
    //path = "qrc:/images/dock/defaultApp.png";

    emit iconChanged();
}
