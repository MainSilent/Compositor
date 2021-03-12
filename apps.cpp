#include "apps.h"
#include <QDir>
#include <QTextStream>
#include <QDirIterator>

Apps::Apps(QObject *parent) : QObject(parent)
{

}

QJsonArray Apps::getApps() const
{
    // paths are in $XDG_DATA_DIRS [/usr/local/share/, /usr/share/, /var/lib/snapd/desktop, ~/.local/share]
    QJsonArray appsData;
    QStringList dirs = QString::fromLocal8Bit(qgetenv("XDG_DATA_DIRS")).split(":");

    // get username to check for local path, if it does't exists add it
    QString username = qgetenv("USER");
    QString localPath = "/home/"+username+"/.local/share";
    if (username.isEmpty())
        username = qgetenv("USERNAME");
    if (!dirs.contains("~/.local/share") && !dirs.contains(localPath))
        dirs.append(localPath);

    // Iterate and get .desktop name, icon and path to a json format in ~/.cache/neo/compositor/apps.cache
    for (QString& dir : dirs) {
        // Set the full path
        dir = dir + (dir[dir.length()-1] == '/' ? "" : "/") + "applications";
        QDirIterator it(dir, QStringList() << "*.desktop", QDir::Files);
        // Read the files insert name, icon and exec to appsData
        while (it.hasNext()) {
            QString Name, Exec, Icon;
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
                    if (KeyVal[0] == "Name") {
                        KeyVal.removeFirst();
                        Name = KeyVal.join("=");
                    }
                    else if (KeyVal[0] == "Exec") {
                        KeyVal.removeFirst();
                        Exec = KeyVal.join("=");
                    }
                    else if (KeyVal[0] == "Icon") {
                        KeyVal.removeFirst();
                        //Icon = KeyVal.join("=");
                    }
                }
            }

            // Check the icon
            if (Icon.isEmpty())
                Icon = "qrc:/images/dock/defaultApp.png";
            else
                getIcon(Icon);

            if (!Name.isEmpty() && !Exec.isEmpty())
                appsData.append(QJsonValue(QJsonArray({Name, Exec, Icon})));

            file.close();
        }
    }

    return appsData;
}

void Apps::getIcon(QString &iconName) const
{
    QFileInfoList hitList;
    QString directory = "/usr/share/icons/"; // Where to search
    QDirIterator it(directory, QDirIterator::Subdirectories);

    while (it.hasNext()) {
        QString filename = it.next();
        QFileInfo file(filename);

        if (file.isDir()) continue;
        if (file.fileName().contains(iconName, Qt::CaseInsensitive))
            hitList.append(file);
    }

    foreach (QFileInfo hit, hitList) {
        iconName = "file:/"+hit.absoluteFilePath();
        break;
    }

    if (hitList.length() == 0)
        iconName = "qrc:/images/dock/defaultApp.png";
}

void Apps::setApps(const QJsonArray &newApps)
{
    apps = newApps;

    emit appsChanged();
}
