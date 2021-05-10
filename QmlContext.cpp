#include "QmlContext.h"
#include <QQmlContext>

QmlContext *QmlContext::m_pInstance = NULL;
QmlContext::QmlContext(QObject *parent) : QObject(parent) ,m_pContext(NULL)
{
}

QmlContext *QmlContext::instance()
{
    if ( m_pInstance == NULL )
        m_pInstance = new QmlContext();
    return m_pInstance;
}

void QmlContext::init(QQmlContext *context)
{
    if (context == NULL)
        return;

    m_pContext = context;
}

QSharedPointer<QObject> QmlContext::contextProperty(const QString &name)
{
    if (m_mapProperties.contains(name))
        return QSharedPointer<QObject>();

    return m_mapProperties[name];
}

void QmlContext::setContextProperty(const QString &name, QObject *object)
{
    if (m_pContext == NULL)
        return;

    if (m_mapProperties.contains(name))
        return;

    m_mapProperties[name] = QSharedPointer<QObject>(object);
    m_pContext->setContextProperty(name, object);
}

void QmlContext::setContextProperty(const QString &name, const QVariant &var)
{
    if (m_pContext == NULL)
        return;

    m_pContext->setContextProperty(name, var);
}
