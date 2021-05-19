#include "messageinfo.h"

MessageInfo::MessageInfo(QObject *parent)
    : QObject(parent)
    , m_id(0)
    , m_date(0)
    , m_remind(false)
{
}

MessageInfo::MessageInfo(int id, QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_date(0)
    , m_remind(false)
{
}

MessageInfo::~MessageInfo()
{
 
}

void MessageInfo::setName(QString name, bool bSend)
{
    if (m_name == name)
        return;

    if(bSend)
    {
        //网络 或者 数据库 操作


        return;
    }

    m_name = name;
    emit nameChanged(m_name);
}

void MessageInfo::setRemind(bool remind)
{
    if (m_remind == remind)
        return;

    m_remind = remind;
    emit remindChanged(m_remind);
}

void MessageInfo::setThumbnail(QString thumbnail)
{
    if (m_thumbnail == thumbnail)
        return;

    m_thumbnail = thumbnail;
    emit thumbnailChanged(m_thumbnail);
}

void MessageInfo::setDesc(QString desc)
{
    if (m_desc == desc)
        return;

    m_desc = desc;
    emit descChanged(m_desc);
}

void MessageInfo::setDate(qint64 date)
{
    if (m_date == date)
        return;

    m_date = date;
    emit dateChanged(m_date);
}
