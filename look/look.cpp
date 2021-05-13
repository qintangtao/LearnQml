#include "look.h"
#include "lookinfo.h"
#include <QDebug>

Look *Look::m_pInstance = NULL;
Look::Look(QObject *parent) : QObject(parent)
{
    int r = 4;
    int c = 8;
    int w = 192;
    int h = 108;
    for (int i = 0; i < r; i++) {
        for (int j = 0; j < c; j++) {
            LookInfo *info = new LookInfo(i * c + j);
            info->setX(j * w);
            info->setY(i * h);
            info->setWidth(w);
            info->setHeight(h);
            info->setName(QString("%1").arg(i*c + j, 3, 10, QChar('0')));
            m_lstLookInfo.append(info);
        }
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

void Look::setLookInfoY(int id, int y)
{
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;
    info->setY(y);
}
void Look::setLookInfoWidth(int id, int width)
{
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;
    info->setWidth(width);
}
void Look::setLookInfoHeight(int id, int height)
{
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;
    info->setHeight(height);
}

void Look::setLookInfoRect(int id, int x, int y, int width, int height)
{
    LookInfo *info = getLookInfo(id);
    if (info== NULL)
        return;
    info->setX(x);
    info->setY(y);
    info->setWidth(width);
    info->setHeight(height);
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
