#ifndef CONTACTINFO_H
#define CONTACTINFO_H
#include <QObject>

class ContactInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id)
    Q_PROPERTY(QString thumbnail READ thumbnail WRITE setThumbnail NOTIFY thumbnailChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString remark READ remark WRITE setRemark NOTIFY remarkChanged)
    Q_PROPERTY(QString region READ region WRITE setRegion NOTIFY regionChanged)
    Q_PROPERTY(QString chatid READ chatid WRITE setChatid NOTIFY chatidChanged)

public:
    ContactInfo(int id, QObject *parent = 0);
    ~ContactInfo();

    int id() const;

    QString thumbnail() const;

    QString name() const;

    QString remark() const;

    QString region() const;

    QString chatid() const;

public slots:
    void setThumbnail(QString thumbnail);

    void setName(QString name);

    void setRemark(QString remark);

    void setRegion(QString region);

    void setChatid(QString chatid);

signals:
    void thumbnailChanged(QString thumbnail);

    void nameChanged(QString name);

    void remarkChanged(QString remark);

    void regionChanged(QString region);

    void chatidChanged(QString chatid);

private:
    int m_id;
    QString m_thumbnail;
    QString m_name;
    QString m_remark;
    QString m_region;
    QString m_chatid;
};

inline  int ContactInfo::id() const
{
    return m_id;
}

inline QString ContactInfo::thumbnail() const
{
    return m_thumbnail;
}

inline QString ContactInfo::name() const
{
    return m_name;
}

inline QString ContactInfo::remark() const
{
    return m_remark;
}

inline QString ContactInfo::region() const
{
    return m_region;
}

inline QString ContactInfo::chatid() const
{
    return m_chatid;
}

#endif // CONTACTINFO_H
