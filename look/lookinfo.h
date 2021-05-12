#ifndef LOOKINFO_H
#define LOOKINFO_H
#include <QObject>

class LookInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)

public:
    LookInfo(QObject *parent = 0);
    LookInfo(int id, QObject *parent = 0);
    ~LookInfo();

    int id() const;

    QString name() const;

    int x() const;

    int y() const;

    int width() const;

    int height() const;

public slots:
    void setName(QString name);

    void setX(int x);

    void setY(int y);

    void setWidth(int width);

    void setHeight(int height);

signals:
    void nameChanged(QString name);

    void xChanged(int x);

    void yChanged(int y);

    void widthChanged(int width);

    void heightChanged(int height);

private:
    int m_id;
    QString m_name;
    int m_x;
    int m_y;
    int m_width;
    int m_height;
};

inline  int LookInfo::id() const
{
    return m_id;
}
inline QString LookInfo::name() const
{
    return m_name;
}

inline int LookInfo::x() const
{
    return m_x;
}

inline int LookInfo::y() const
{
    return m_y;
}

inline int LookInfo::width() const
{
    return m_width;
}

inline int LookInfo::height() const
{
    return m_height;
}


#endif // LOOKINFO_H
