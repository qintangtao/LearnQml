#ifndef MESSAGEINFO_H
#define MESSAGEINFO_H
#include <QObject>

class MessageInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id)
    Q_PROPERTY(QString thumbnail READ thumbnail WRITE setThumbnail NOTIFY thumbnailChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged)
    Q_PROPERTY(qint64 date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(bool remind READ isRemind WRITE setRemind NOTIFY remindChanged)

public:
    MessageInfo(QObject *parent = 0);
    MessageInfo(int id, QObject *parent = 0);
    ~MessageInfo();

    int id() const;
    QString name() const;
    bool isRemind() const;
    QString thumbnail() const;
    QString desc() const;
    qint64 date() const;

public slots:
    void setName(QString name, bool bSend = false);
    void setRemind(bool remind);
    void setThumbnail(QString thumbnail);
    void setDesc(QString desc);
    void setDate(qint64 date);

signals:
    void nameChanged(QString name);
    void remindChanged(bool remind);
    void thumbnailChanged(QString thumbnail);
    void descChanged(QString desc);
    void dateChanged(qint64 date);

private:
    int m_id;
    QString m_thumbnail;
    QString m_name;
    QString m_desc;
    qint64 m_date;
    bool m_remind;
};

inline  int MessageInfo::id() const
{
    return m_id;
}

inline QString MessageInfo::name() const
{
    return m_name;
}

inline  QString MessageInfo::thumbnail() const
{
    return m_thumbnail;
}

inline  QString MessageInfo::desc() const
{
    return m_desc;
}

inline  qint64 MessageInfo::date() const
{
    return m_date;
}
inline bool MessageInfo::isRemind() const
{
    return m_remind;
}

#endif // MESSAGEINFO_H
