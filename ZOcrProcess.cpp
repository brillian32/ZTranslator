#include "ZOcrProcess.h"
#include "QFuture"
#include "qdebug.h"
#include <QtConcurrent/QtConcurrent>
#include <tesseract/baseapi.h>
#include <tesseract/ocrclass.h>
#include <leptonica/allheaders.h>

bool ProgressCallBack(int progress, int left, int right, int top, int bottom)
{
    auto progress_ = progress * (1.0) / (64.0 / 100.0);
    qDebug()<< QString::number(qRound(progress_));
    return true;
}

ZOcrProcess::ZOcrProcess(QObject* parent): QObject(parent)
{
}

void ZOcrProcess::OCRThtread(QString imagePath)
{
    auto api = new tesseract::TessBaseAPI();
    // Initialize tesseract-ocr with English, without specifying tessdata path
    if (api->Init(m_trainDataPath.toStdString().c_str(), m_language.toStdString().c_str())) {
        qDebug() << "tesseract Init failed";
        assert(false);
    }

    // Open input image with leptonica library
    Pix* image = pixRead(imagePath.toStdString().c_str());
    api->SetImage(image);

    ETEXT_DESC monitor;
    monitor.progress_callback = ProgressCallBack;
    api->Recognize(&monitor);
    char* outText = api->GetUTF8Text();
    qDebug() << outText;
    // Destroy used object and release memory
    api->End();
    pixDestroy(&image);

}

void ZOcrProcess::setTrainDataPath(const QString path)
{
    m_trainDataPath = path;
}


void ZOcrProcess::startOCR(const QString imgPath)
{
	auto res = QtConcurrent::run(&ZOcrProcess::OCRThtread,this, imgPath);
}

void ZOcrProcess::setLanguage(const QString language)
{
    m_language = language;
}
