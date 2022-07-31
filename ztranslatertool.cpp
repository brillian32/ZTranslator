#include "ztranslatertool.h"
#include "qtconcurrentrun.h"

ZTranslaterTool::ZTranslaterTool(QObject *parent)
    : QObject{parent}
{
    QObject::connect(&m_translator, &QOnlineTranslator::finished, [&] {
        if (m_translator.error() == QOnlineTranslator::NoError)
        {
            // Code in this block will run in another thread
            m_results = m_translator.translation();
            qInfo() << "translate result:";
            qInfo() << "RESULTS:" << m_translator.translation();
            qInfo() << "SOURCE:" << m_translator.source();
            emit finish(StatuCode::success);
        }
        else
        {
            qCritical() << m_translator.errorString();
            emit finish(StatuCode::failed);
        }
        });
}

void ZTranslaterTool::translate(const QString& transString)
{
    //ºÄÊ±²Ù×÷»á×èÈû
    m_translator.translate(transString, QOnlineTranslator::Google);

}

QString ZTranslaterTool::getTranlateResults()
{
    return m_results;
}
