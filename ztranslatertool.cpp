#include "ztranslatertool.h"
#include "qtconcurrentrun.h"
#include "qjsondocument.h"
ZTranslaterTool::ZTranslaterTool(QObject *parent)
    : QObject{parent}
{
    m_translator.setExamplesEnabled(true);
    m_translator.setSourceTranslitEnabled(true);
    m_translator.setTranslationOptionsEnabled(true);
    m_translator.setSourceTranscriptionEnabled(true);
    m_translator.setTranslationTranslitEnabled(true);
    QObject::connect(&m_translator, &QOnlineTranslator::finished, [&] {
        if (m_translator.error() == QOnlineTranslator::NoError)
        {
            // Code in this block will run in another thread
            m_results = m_translator.translation();
            qInfo() << "translate result:";
            qInfo() << "RESULTS:" << m_translator.translation();
            qInfo() << "SOURCE:" << m_translator.source();
            emit finish(StatuCode::success);
            auto ex = m_translator.examples();
            auto ec = m_translator.translationTranslit();
            auto ss = m_translator.toJson();
            auto ss1 = m_translator.toJson();
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
