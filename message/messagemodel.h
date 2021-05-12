#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H
#include <QAbstractListModel>

class MessageInfo;
class MessageModelPrivate;
class MessageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    MessageModel(QObject *parent = 0);
    ~MessageModel();

    int rowCount(const QModelIndex& parent) const;
    QHash<int, QByteArray> roleNames() const;

    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

    bool insertData(int row, MessageInfo *info);

    bool moveRow(const int& sourceRow, const int& desRow);

public slots:
    void setData(const QList<MessageInfo *> &data);
    void setName(int id, const QString &text);
    void setDesc(int id, const QString &text);

    void onNameChanged(QString name);
    void onDescChanged(QString desc);

private:
   QModelIndex id(int id);

private:
    MessageModelPrivate* m_dPtr;
};
#endif // MESSAGEMODEL_H
