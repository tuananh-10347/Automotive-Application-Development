#include "xmlwriter.h"

XmlWriter::XmlWriter(QObject *parent)  : QObject(parent)
{
    root = document.createElement("APPLICATIONS");
    app = document.createElement("APP");
    document.appendChild(root);
}

XmlWriter::XmlWriter(QString path)
{
    m_path = path;
}

void XmlWriter::writeXmlFile()
{

    QFile file(m_path);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate | QIODevice::Text))
    {
        qDebug() << "Can't write file: " << m_path;
        return;
    }

    QTextStream out(&file);
    out << document.toString();
    //  qDebug() << document.toString();
    file.close();
}

void XmlWriter::saveModelData(int index, QString title, QString url, QString icon)
{
    QDomElement app = document.createElement("APP");
    app.setAttribute("ID", "00" + QString::number(index));
    root.appendChild(app);

    // TITLE
    QDomElement TITLE = document.createElement("TITLE");
    TITLE.appendChild(document.createTextNode(title));
    app.appendChild(TITLE);
    // URL
    QDomElement URL = document.createElement("URL");
    URL.appendChild(document.createTextNode(url));
    app.appendChild(URL);
    // ICON_PATH
    QDomElement ICON_PATH = document.createElement("ICON_PATH");
    ICON_PATH.appendChild(document.createTextNode(icon));
    app.appendChild(ICON_PATH);
}

void XmlWriter::clearFile()
{
    document.clear();
    root.clear();
    root = document.createElement("APPLICATIONS");
    document.appendChild(root);
}
