#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    Q_INVOKABLE void power(QString action);

signals:

};

#endif // BACKEND_H
