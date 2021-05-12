#include "look.h"
#include "lookinfo.h"
#include <QDebug>

Look *Look::m_pInstance = NULL;
Look::Look(QObject *parent) : QObject(parent)
{
    for (int i = 0; i < 10; i++) {
        LookInfo *info = new LookInfo(i);
        info->setX(i * 100 + 50);
        info->setY(i * 100 + 50);
        info->setWidth(100);
        info->setHeight(100);
        info->setName(QStringLiteral("name%1").arg(i));
        m_lstLookInfo.append(info);
    }
}

Look *Look::instance()
{
    if ( m_pInstance == NULL )
        m_pInstance = new Look();
    return m_pInstance;
}

void Look::setLookInfoX(int id, int x)
{
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;
    info->setX(x);
}

void Look::load()
{
    foreach (LookInfo *info, m_lstLookInfo){
        emit add(info);
    }
}

void Look::closeWindow(int id)
{
    qDebug() << "closeWindow" << id;
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;

    emit del(info->id());
}

LookInfo *Look::getLookInfo(int id)
{
    foreach (LookInfo *info, m_lstLookInfo){
        if(info->id() == id)
            return info;
    }
    return NULL;
}
