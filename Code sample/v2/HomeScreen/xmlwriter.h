#ifndef XMLWRITER_H
#define XMLWRITER_H
#include <QtXml>
#include <QFile>
#include <QString>


class XmlWriter: public QObject
{
    Q_OBJECT
public:
    XmlWriter(QObject *parent = nullptr);
    XmlWriter(QString path);
private:
    QDomDocument m_xmlDoc; //The QDomDocument class represents an XML document.
    void PaserList();
    QDomElement app;
    QDomDocument document;
    QDomElement root;
    QString m_path;

public:

    Q_INVOKABLE void writeXmlFile();
    Q_INVOKABLE void saveModelData(int index,QString title, QString url, QString icon);
    Q_INVOKABLE void clearFile();
};

#endif // XMLWRITER_H
