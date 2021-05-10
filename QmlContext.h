#ifndef QMLCONTEXT_H
#define QMLCONTEXT_H

#include <QObject>
#include <QMap>
#include <QSharedPointer>

class QQmlContext;
class QmlContext : public QObject
{
    Q_OBJECT
public:
    static QmlContext * instance();

public slots:
    void init(QQmlContext *context);

    QSharedPointer<QObject> contextProperty(const QString &);
    void setContextProperty(const QString &, QObject *);
    void setContextProperty(const QString &, const QVariant &);

private:
    explicit QmlContext(QObject *parent = nullptr);
    static QmlContext *m_pInstance;

private:
    QQmlContext* m_pContext;
    QMap<QString, QSharedPointer<QObject>> m_mapProperties;
};

#endif // QMLCONTEXT_H
