#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QOnlineTranslator.h"
#include "ztranslatertool.h"
#include <QQmlContext>
#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>
#include "QDebug"
#include "ZOcrProcess.h"
#include "ZMainApplication.h"
#include <QQmlDebuggingEnabler>




int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    ZMainApplication mainApp(&app);
    return app.exec();
}
