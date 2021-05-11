#include "contactinfo.h"


ContactInfo::ContactInfo(int id, QObject *parent)
    : QObject(parent)
    , m_id(id)
{
}

ContactInfo::~ContactInfo()
{
 
}

void ContactInfo::setThumbnail(QString thumbnail)
{
    if (m_thumbnail == thumbnail)
        return;

    m_thumbnail = thumbnail;
    emit thumbnailChanged(m_thumbnail);
}

void ContactInfo::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}

void ContactInfo::setRemark(QString remark)
{
    if (m_remark == remark)
        return;

    m_remark = remark;
    emit remarkChanged(m_remark);
}

void ContactInfo::setRegion(QString region)
{
    if (m_region == region)
        return;

    m_region = region;
    emit regionChanged(m_region);
}

void ContactInfo::setChatid(QString chatid)
{
    if (m_chatid == chatid)
        return;

    m_chatid = chatid;
    emit chatidChanged(m_chatid);
}
