#include "messagemodel.h"
#include "messageinfo.h"
#include <QDateTime>
#include <QDebug>
#include <QMetaType>
#define USE_PRIVATE

class MessageModelPrivate
{
public:

    enum {
        Role_Id = Qt::UserRole + 1,
        Role_Thumbnail,
        Role_Name,
        Role_Desc,
        Role_Date,
        Role_Remind
    };

    MessageModelPrivate(MessageModel* model):
        m_model(model)
    {
        m_roleNames.insert(Role_Id, "id");
        m_roleNames.insert(Role_Thumbnail, "thumbnail");
        m_roleNames.insert(Role_Name, "name");
        m_roleNames.insert(Role_Desc, "desc");
        m_roleNames.insert(Role_Date, "date");
        m_roleNames.insert(Role_Remind, "remind");
    }

#ifdef USE_PRIVATE
    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);
#endif

    MessageModel*                        m_model;
    QHash<int, QByteArray>          m_roleNames;
    QList<MessageInfo *>              m_datas;
};

#ifdef USE_PRIVATE
QVariant MessageModelPrivate::data(const QModelIndex& index, int role) const
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
    case Role_Desc:
        return m_datas.at(index.row())->desc();
    case Role_Date:
        return m_datas.at(index.row())->date();
    case Role_Remind:
        return m_datas.at(index.row())->isRemind();
    default:
        break;
    }

    return QVariant();
}

bool MessageModelPrivate::setData(const QModelIndex &index, const QVariant &value, int role)
{
     if (data(index, role) == value)
         return false;

     MessageInfo *info = m_datas.at(index.row());
     switch (role) {
     case Role_Thumbnail:
         info->setThumbnail(value.toString());
         break;
     case Role_Name:
         info->setName(value.toString());
         break;
     case Role_Desc:
         info->setDesc(value.toString());
         break;
     case Role_Date:
         info->setDate(value.toInt());
         break;
     case Role_Remind:
         info->setRemind(value.toBool());
         break;
     default:
         break;
     }

     emit m_model->dataChanged(index, index, QVector<int>() << role);
     return true;
}
#endif

MessageModel::MessageModel(QObject *parent) :
    QAbstractListModel(parent),
    m_dPtr(new MessageModelPrivate(this))
{
   // qRegisterMetaType<QVector<MusicInfo>>("QVector<MusicInfo>");
  // qRegisterMetaType<MessageInfo>("MessageInfo");

    //connect(LocalMusic::getInstance(), SIGNAL(sigForUpdateLocalMusicData(QVector<MusicInfo>)),
  //  this, SLOT(slotForLocalMusic(QVector<MusicInfo>)));

    QList<MessageInfo *> list;
    for (int i = 0; i < 10; i++) {
        MessageInfo *info  = new MessageInfo(i, this);
        info->setThumbnail(QString("%1%2.ico").arg(headPath).arg( (i % 5 ) + 1));
        info->setName(QStringLiteral("name_%1").arg(i+1));
        info->setDesc(QStringLiteral("desc_%1").arg(i+1));
        info->setDate(QDateTime::currentDateTime().toMSecsSinceEpoch());
        info->setRemind(i % 3 == 0);

        connect(info, SIGNAL(nameChanged(QString)), this, SLOT(onNameChanged(QString)));
        connect(info, SIGNAL(descChanged(QString)), this, SLOT(onDescChanged(QString)));

        list.append(info);
    }

    setData(list);
}

MessageModel::~MessageModel()
{
    if (NULL != m_dPtr) {
        delete m_dPtr;
        m_dPtr = NULL;
    }
}

int MessageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_dPtr->m_datas.size();
}

QHash<int, QByteArray> MessageModel::roleNames() const
{
    return m_dPtr->m_roleNames;
}

QVariant MessageModel::data(const QModelIndex &index, int role) const
{
#ifdef USE_PRIVATE
    return m_dPtr->data(index, role);
#else
    if (index.row() < 0 || index.row() >= m_dPtr->m_datas.count())
    {
        return QVariant();
    }

    switch (role) {
    case Role_Thumbnail:
        return m_dPtr->m_datas.at(index.row())->m_thumbnail;
    case Role_Name:
        return m_dPtr->m_datas.at(index.row())->m_name;
    case Role_Desc:
        return m_dPtr->m_datas.at(index.row())->m_desc;
    case Role_Date:
        return m_dPtr->m_datas.at(index.row())->m_date;
    case Role_Remind:
        return m_dPtr->m_datas.at(index.row())->m_remind;
    default:
        break;
    }

    return QVariant();
#endif
}

bool MessageModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
#ifdef USE_PRIVATE
    return m_dPtr->setData(index, value, role);
#else
    if (data(index, role) == value)
        return false;

    MessageInfo *info = m_dPtr->m_datas.at(index.row());
    switch (role) {
    case Role_Thumbnail:
        info->m_thumbnail = value.toString();
        break;
    case Role_Name:
        info->m_name = value.toString();
        break;
    case Role_Desc:
        info->m_desc = value.toString();
        break;
    case Role_Date:
        info->m_date = value.toInt();
        break;
    case Role_Remind:
        info->m_remind = value.toBool();
        break;
    default:
        break;
    }

    emit dataChanged(index, index, QVector<int>() << role);
    return true;
#endif
}

void MessageModel::setData(const QList<MessageInfo *> &data)
{
    beginResetModel();
    m_dPtr->m_datas = data;
    endResetModel();

    //qDebug()<<"slotForLocalMusic data size is : "<< data.size() ;
}

bool MessageModel::insertData(int row, MessageInfo *info)
{
    if( info == NULL)
        return false;

    if (row < 0 || row >= m_dPtr->m_datas.size())
        return false;

    beginInsertRows(QModelIndex(), row, row);
    m_dPtr->m_datas.insert(row, info);
    endInsertRows();
    return true;
}

bool MessageModel::moveRow(const int& sourceRow, const int& desRow)
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

void MessageModel::setName(int id, const QString &text)
{
    QModelIndex index = this->id(id);
    if (!index.isValid())
        return;

    m_dPtr->m_datas.at(index.row())->setName(text);

    //setData(index, text, MessageModelPrivate::Role_Name);
}
void MessageModel::setDesc(int id, const QString &text)
{
    QModelIndex index = this->id(id);
    if (!index.isValid())
        return;

    m_dPtr->m_datas.at(index.row())->setDesc(text);
    //setData(index, text, MessageModelPrivate::Role_Desc);

    foreach(MessageInfo *info, m_dPtr->m_datas)
        qDebug() << "-" << info->id();

    moveRow(index.row(), 0);

    foreach(MessageInfo *info, m_dPtr->m_datas)
        qDebug() << "+" << info->id();
}


void MessageModel::onNameChanged(QString name)
{
    MessageInfo *info  = (MessageInfo *)sender();
    QModelIndex index = this->id(info->id());
    if (!index.isValid())
        return;

    dataChanged(index, index, QVector<int>() << MessageModelPrivate::Role_Name);
}

void MessageModel::onDescChanged(QString desc)
{
    MessageInfo *info  = (MessageInfo *)sender();
    QModelIndex index = this->id(info->id());
    if (!index.isValid())
        return;

    dataChanged(index, index, QVector<int>() << MessageModelPrivate::Role_Desc);
}

QModelIndex MessageModel::id(int id)
{
    int size = m_dPtr->m_datas.size();
    for (int i = 0; i < size; i++) {
        QModelIndex index = this->index(i) ;
        QVariant v = data(index, MessageModelPrivate::Role_Id);
        if (v.isValid() && v.toInt() == id)
            return index;
    }
    return QModelIndex();
}
