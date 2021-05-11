#include "contactmodel.h"
#include "contactinfo.h"
#include <QDateTime>
#include <QDebug>

class ContactModelPrivate
{
public:

    enum {
        Role_Id = Qt::UserRole + 1,
        Role_Thumbnail,
        Role_Name,
        Role_Remark,
        Role_Region,
        Role_Chatid
    };

    ContactModelPrivate(ContactModel* model):
        m_model(model)
    {
        m_roleNames.insert(Role_Id, "id");
        m_roleNames.insert(Role_Thumbnail, "thumbnail");
        m_roleNames.insert(Role_Name, "name");
        m_roleNames.insert(Role_Remark, "remark");
        m_roleNames.insert(Role_Region, "region");
        m_roleNames.insert(Role_Chatid, "chatid");
    }

    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

    ContactModel*                        m_model;
    QHash<int, QByteArray>          m_roleNames;
    QList<ContactInfo *>              m_datas;
};

QVariant ContactModelPrivate::data(const QModelIndex& index, int role) const
{
    if (index.row() < 0 || index.row() >= m_datas.count())
    {
        return QVariant();
    }

    switch (role) {
    case Role_Id:
        return m_datas.at(index.row())->id();
    case Role_Thumbnail:
        return m_datas.at(index.row())->thumbnail();
    case Role_Name:
        return m_datas.at(index.row())->name();
    case Role_Remark:
        return m_datas.at(index.row())->remark();
    case Role_Region:
        return m_datas.at(index.row())->region();
    case Role_Chatid:
        return m_datas.at(index.row())->chatid();
    default:
        break;
    }

    return QVariant();
}

bool ContactModelPrivate::setData(const QModelIndex &index, const QVariant &value, int role)
{
     if (data(index, role) == value)
         return false;

     ContactInfo *info = m_datas.at(index.row());
     switch (role) {
     case Role_Thumbnail:
         info->setThumbnail(value.toString());
         break;
     case Role_Name:
         info->setName(value.toString());
         break;
     case Role_Remark:
         info->setRemark(value.toString());
         break;
     case Role_Region:
         info->setRegion(value.toString());
         break;
     case Role_Chatid:
         info->setChatid(value.toString());
         break;
     default:
         break;
     }

     emit m_model->dataChanged(index, index, QVector<int>() << role);
     return true;
}

ContactModel::ContactModel(QObject *parent) :
    QAbstractListModel(parent),
    m_dPtr(new ContactModelPrivate(this))
{
   // qRegisterMetaType<QVector<MusicInfo>>("QVector<MusicInfo>");
    //qRegisterMetaType<ContactInfo>("ContactInfo");

    //connect(LocalMusic::getInstance(), SIGNAL(sigForUpdateLocalMusicData(QVector<MusicInfo>)),
  //  this, SLOT(slotForLocalMusic(QVector<MusicInfo>)));

    QList<ContactInfo *> list;
    for (int i = 0; i < 10; i++) {
        ContactInfo *info  = new ContactInfo(i, this);
        info->setThumbnail(QString("%1%2.ico").arg(headPath).arg( (i % 5 ) + 1));
        info->setName(QStringLiteral("name_%1").arg(i+1));
        info->setRemark(QStringLiteral("remark_%1").arg(i+1));
        info->setRegion(QStringLiteral("region_%1").arg(i+1));
        info->setChatid(QStringLiteral("chatid_%1").arg(i+1));

        //connect(info, SIGNAL(nameChanged(QString)), this, SLOT(onNameChanged(QString)));
        //connect(info, SIGNAL(descChanged(QString)), this, SLOT(onDescChanged(QString)));

        list.append(info);
    }

    setData(list);
}

ContactModel::~ContactModel()
{
    if (NULL != m_dPtr) {
        delete m_dPtr;
        m_dPtr = NULL;
    }
}

int ContactModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_dPtr->m_datas.size();
}

QHash<int, QByteArray> ContactModel::roleNames() const
{
    return m_dPtr->m_roleNames;
}

QVariant ContactModel::data(const QModelIndex &index, int role) const
{
    return m_dPtr->data(index, role);
}

bool ContactModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    return m_dPtr->setData(index, value, role);
}

void ContactModel::setData(const QList<ContactInfo *> &data)
{
    beginResetModel();
    m_dPtr->m_datas = data;
    endResetModel();

    //qDebug()<<"slotForLocalMusic data size is : "<< data.size() ;
}

bool ContactModel::moveRow(const int& sourceRow, const int& desRow)
{
    if (sourceRow == desRow)
        return false;

    if(!hasIndex(sourceRow, 0) || !hasIndex(desRow, 0))
        return false;

    beginMoveRows(QModelIndex(), sourceRow, sourceRow, QModelIndex(),
        (desRow > sourceRow) ? (desRow + 1) : desRow);
    m_dPtr->m_datas.move(sourceRow, desRow);
    endMoveRows();
    return true;
}

void ContactModel::setName(int id, const QString &text)
{
    QModelIndex index = this->id(id);
    if (!index.isValid())
        return;

    m_dPtr->m_datas.at(index.row())->setName(text);

    //setData(index, text, ContactModelPrivate::Role_Name);
}
void ContactModel::setDesc(int id, const QString &text)
{
    QModelIndex index = this->id(id);
    if (!index.isValid())
        return;

    m_dPtr->m_datas.at(index.row())->setRegion(text);
    //setData(index, text, ContactModelPrivate::Role_Desc);

    foreach(ContactInfo *info, m_dPtr->m_datas)
        qDebug() << "-" << info->id();

    moveRow(index.row(), 0);

    foreach(ContactInfo *info, m_dPtr->m_datas)
        qDebug() << "+" << info->id();
}


void ContactModel::onNameChanged(QString name)
{
    ContactInfo *info  = (ContactInfo *)sender();
    QModelIndex index = this->id(info->id());
    if (!index.isValid())
        return;

    dataChanged(index, index, QVector<int>() << ContactModelPrivate::Role_Name);
}

void ContactModel::onDescChanged(QString desc)
{
    ContactInfo *info  = (ContactInfo *)sender();
    QModelIndex index = this->id(info->id());
    if (!index.isValid())
        return;

    dataChanged(index, index, QVector<int>() << ContactModelPrivate::Role_Region);
}

QModelIndex ContactModel::id(int id)
{
    int size = m_dPtr->m_datas.size();
    for (int i = 0; i < size; i++) {
        QModelIndex index = this->index(i) ;
        QVariant v = data(index, ContactModelPrivate::Role_Id);
        if (v.isValid() && v.toInt() == id)
            return index;
    }
    return QModelIndex();
}
