#include "lookinfo.h"
#include <QDebug>

LookInfo::LookInfo(QObject *parent)
    : QObject(parent)
    , m_id(0)
{
}

LookInfo::LookInfo(int id, QObject *parent)
    : QObject(parent)
    , m_id(id)
{
}

LookInfo::~LookInfo()
{
 
}


void LookInfo::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}

void LookInfo::setX(int x)
{
    if (m_x == x)
        return;
    qDebug() << "old.x" << m_x << "new.x" << x;
    m_x = x;
    emit xChanged(m_x);
}

void LookInfo::setY(int y)
{
    if (m_y == y)
        return;
    qDebug() << "old.y" << m_y << "new.y" << y;
    m_y = y;
    emit yChanged(m_y);
}

void LookInfo::setWidth(int width)
{
    if (m_width == width)
        return;
    qDebug() << "old.width" << m_width << "new.width" << width;
    m_width = width;
    emit widthChanged(m_width);
}

void LookInfo::setHeight(int height)
{
    if (m_height == height)
        return;
    qDebug() << "old.height" << m_height << "new.height" << height;
    m_height = height;
    emit heightChanged(m_height);
}
