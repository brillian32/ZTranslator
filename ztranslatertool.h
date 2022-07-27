#ifndef ZTRANSLATERTOOL_H
#define ZTRANSLATERTOOL_H

#include <QObject>
#include <QQuickItem>
#include <QWidget>
#include "QOnlineTranslator.h"

class ZTranslaterTool : public QObject
{
    Q_OBJECT
public:
    explicit ZTranslaterTool(QObject *parent = nullptr);

public slots:
    void translate(QString transString);
    QString getTranlateResults();


signals:


private:
    QOnlineTranslator m_translator;
    QString m_results{};

};
#endif // ZTRANSLATERTOOL_H
