#ifndef ZTRANSLATERTOOL_H
#define ZTRANSLATERTOOL_H

#include <QObject>
#include <QQuickItem>
#include <QWidget>
#include "QOnlineTranslator.h"

enum  StatuCode
{
  success= 0 ,
  failed = 1,
};

class ZTranslaterTool : public QObject
{
    Q_OBJECT
public:
    explicit ZTranslaterTool(QObject *parent = nullptr);

public slots:
    void translate(const QString& transString);
    QString getTranlateResults();


signals:
    void finish(StatuCode statuCode);


private:
    QOnlineTranslator m_translator;
    QString m_results{};

};
#endif // ZTRANSLATERTOOL_H
