#ifndef CONTACTMODEL_H
#define CONTACTMODEL_H
#include <QAbstractListModel>

class ContactInfo;
class ContactModelPrivate;
class ContactModel : public QAbstractListModel
{
    Q_OBJECT
public:
    ContactModel(QObject *parent = 0);
    ~ContactModel();

    int rowCount(const QModelIndex& parent) const;
    QHash<int, QByteArray> roleNames() const;

    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

    bool moveRow(const int& sourceRow, const int& desRow);

public slots:
    void setData(const QList<ContactInfo *> &data);
    void setName(int id, const QString &text);
    void setDesc(int id, const QString &text);

    void onNameChanged(QString name);
    void onDescChanged(QString desc);

private:
   QModelIndex id(int id);

private:
    ContactModelPrivate* m_dPtr;
};
#endif // CONTACTMODEL_H
