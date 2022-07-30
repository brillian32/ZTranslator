#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QOnlineTranslator.h"
#include "ztranslatertool.h"
#include <QQmlContext>
#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>
#include "QDebug"
#include "ZOcrProcess.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //char* outText;

    //auto api = new tesseract::TessBaseAPI();
    //// Initialize tesseract-ocr with English, without specifying tessdata path
    //if (api->Init("C:\\Users\\17305\\Downloads\\tessdata_fast-main\\tessdata_fast-main", "por")) {
    //    fprintf(stderr, "Could not initialize tesseract.\n");
    //    exit(1);
    //}

    //// Open input image with leptonica library
    //Pix* image = pixRead("C:\\Users\\17305\\Pictures\\cc.png");
    //api->SetImage(image);
    //// Get OCR result
    //outText = api->GetUTF8Text();
    //qDebug(outText);

    //// Destroy used object and release memory
    //api->End();
    //delete api;
    //delete[] outText;
    //pixDestroy(&image);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("cppTranslaterTool", new ZTranslaterTool(qApp));
    engine.rootContext()->setContextProperty("cppOcrProcess", new ZOcrProcess(qApp));
    const QUrl url(u"qrc:/Translater/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
