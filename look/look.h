#ifndef LOOK_H
#define LOOK_H

#include <QObject>

class LookInfo;
class Look : public QObject
{
    Q_OBJECT
public:
    static Look *instance();

    Q_INVOKABLE void setLookInfoX(int id, int x);
    Q_INVOKABLE void setLookInfoY(int id, int y);
    Q_INVOKABLE void setLookInfoWidth(int id, int width);
    Q_INVOKABLE void setLookInfoHeight(int id, int height);
    Q_INVOKABLE void setLookInfoRect(int id, int x, int y, int width, int height);

Q_SIGNALS:
    void add(LookInfo *info);
    void del(int id);

public slots:
    void load();
    void closeWindow(int id);

protected:
    LookInfo *getLookInfo(int id);

private:
    explicit Look(QObject *parent = nullptr);
    static Look *m_pInstance;

private:
    QList<LookInfo *> m_lstLookInfo;
};

#endif // LOOK_H
