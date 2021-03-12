#ifndef APPS_H
#define APPS_H

#include <QObject>
#include <QJsonArray>

class Apps : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray apps READ getApps WRITE setApps NOTIFY appsChanged)

public:
    explicit Apps(QObject *parent = nullptr);
    QJsonArray getApps() const;
    void getIcon(QString &iconName) const;

public slots:
    void setApps(const QJsonArray &newApps);

signals:
    void appsChanged();

private:
    QJsonArray apps;
};

#endif // APPS_H
