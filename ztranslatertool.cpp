#include "ztranslatertool.h"

ZTranslaterTool::ZTranslaterTool(QObject *parent)
    : QObject{parent}
{

}

void ZTranslaterTool::translate(QString transString)
{
    m_translator.translate(transString, QOnlineTranslator::Google);
    QObject::connect(&m_translator, &QOnlineTranslator::finished, [&] {
        if (m_translator.error() == QOnlineTranslator::NoError)
        {
            m_results = m_translator.translation();
            qInfo() << m_translator.translation();
            qInfo() << m_translator.source();
        }

        else
            qCritical() << m_translator.errorString();
    });
}

QString ZTranslaterTool::getTranlateResults()
{
    return m_results;
}
