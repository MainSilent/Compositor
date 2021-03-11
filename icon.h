#ifndef ICON_H
#define ICON_H

#include <QObject>
#include <QDir>
#include <QDebug>
#include <QProcess>
#include <QJsonObject>
#include <QDirIterator>
#include <QJsonDocument>

class Icon : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ getIcon WRITE setIcon NOTIFY iconChanged)

public:
    explicit Icon(QObject *parent = nullptr);
    QString getIcon() const;
    void syncIcons();

public slots:
    void setIcon(const QString &pid);

signals:
    void iconChanged();

private:
    QString path;
};

#endif // ICON_H
