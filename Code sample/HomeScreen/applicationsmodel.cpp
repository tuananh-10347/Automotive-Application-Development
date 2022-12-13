#include "applicationsmodel.h"
#include "QDebug"

ApplicationItem::ApplicationItem(QString title, QString url, QString iconPath)
{
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;
}

QString ApplicationItem::title() const
{
    return m_title;
}

QString ApplicationItem::url() const
{
    return m_url;
}

QString ApplicationItem::iconPath() const
{
    return m_iconPath;
}

ApplicationsModel::ApplicationsModel(QObject *parent)
{
    Q_UNUSED(parent)
}

int ApplicationsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant ApplicationsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const ApplicationItem &item = m_data[index.row()];
    if (role == TitleRole)
        return item.title();
    else if (role == UrlRole)
        return item.url();
    else if (role == IconPathRole)
        return item.iconPath();
    return QVariant();
}

void ApplicationsModel::addApplication(ApplicationItem &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << item;
    endInsertRows();
}

void ApplicationsModel::writeDataToXml(int index,QString title,QString url,QString iconPath)
{
    QString appIndex = "00" + QString::number(index);

    QString path = QString(PROJECT_PATH) + "applications.xml";
    QFile f(path);
    QDomDocument m_xmlDoc;
    m_xmlDoc.setContent(&f);
    f.close();
    QDomElement root = m_xmlDoc.documentElement();
          // Get the first child of the root (Markup COMPONENT is expected)
           QDomElement Component=root.firstChild().toElement();

           // Loop while there is a child
          while(!Component.isNull())
            {
                // Check if the child tag name is COMPONENT
                if (Component.tagName()=="APP")
                {

                    // Read and display the component ID
                    QString ID=Component.attribute("ID","No ID");
                    if(ID == appIndex){
                        // Get the first child of the component
                        QDomElement Child=Component.firstChild().toElement();

                        // Read each child of the component node
                        while (!Child.isNull())
                        {
                            // Read Name and value
                            if (Child.tagName()=="TITLE") Child.firstChild().setNodeValue(title);
                            if (Child.tagName()=="URL") Child.firstChild().setNodeValue(url);
                            if (Child.tagName()=="ICON_PATH")  Child.firstChild().setNodeValue(iconPath);
                            // Next child
                            Child = Child.nextSibling().toElement();
                        }
                    }
                }

                // Next component
                Component = Component.nextSibling().toElement();
            }
        // Save content back to the file
          if (!f.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
              return;
          }
          QByteArray xml = m_xmlDoc.toByteArray();
          f.write(xml);
          f.close();
}

QHash<int, QByteArray> ApplicationsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[IconPathRole] = "iconPath";
    return roles;
}

