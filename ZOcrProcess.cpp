#include "ZOcrProcess.h"
#include "QFuture"
#include "qdebug.h"
#include <QtConcurrent/QtConcurrent>
#include <tesseract/baseapi.h>
#include <tesseract/ocrclass.h>
#include <leptonica/allheaders.h>
#include  <qwidget>
#include <QPoint>

bool ProgressCallBack(int progress, int left, int right, int top, int bottom)
{
    qDebug()<< QString::number(progress);
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
    qDebug() << "OCR finish:";
    qDebug() << outText;
    m_results = QString(outText);
    emit finish();
    // Destroy used object and release memory
    api->End();
    pixDestroy(&image);

}

void ZOcrProcess::setTrainDataPath(const QString path)
{
    m_trainDataPath = path;
}

QString ZOcrProcess::getResults()
{
    return  m_results;
}

void ZOcrProcess::grabScreen(QQuickWindow* window, int x, int y,int width,int height)
{
    auto pix = window->screen()->grabWindow(0,x,y,width,height);
    pix.save("C:\\Users\\17305\\Pictures\\ff.png");
    return;
}


void ZOcrProcess::startOCR(const QString imgPath)
{
	auto res = QtConcurrent::run(&ZOcrProcess::OCRThtread,this, imgPath);
}

void ZOcrProcess::setLanguage(const QString language)
{
    m_language = language;
}
