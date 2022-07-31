#include "ZMainApplication.h"

ZMainApplication::ZMainApplication(QObject* parent):QObject(parent)
{
    m_cppTranslaterTool = new ZTranslaterTool(qApp);
    m_cppOcrProcess = new ZOcrProcess(qApp);
    QmlInit();
    ConnectSig();
    RegisterHotKey();
}

void ZMainApplication::OnFinishOCR()
{
    QVariant returnedValue;
    QVariant param = true;
    QObject* pRoot = m_engine.rootObjects().first();
    auto aah = m_engine.rootObjects().count();

    auto objectName = pRoot->objectName();
    QMetaObject::invokeMethod(pRoot, "updateInputText", Q_RETURN_ARG(QVariant, returnedValue), Q_ARG(QVariant, param));
}

void ZMainApplication::OnFinishTranslate(int errorCode)
{
    QVariant returnedValue;
    QVariant param = true;
    QObject* pRoot = m_engine.rootObjects().first();
    auto aah = m_engine.rootObjects().count();

    auto objectName = pRoot->objectName();
    //QObject* mainWindowQml = pRoot->findChild<QObject*>("quickWin");
    //auto obj = pRoot->findChild<QObject*>("mainWindow");
    //auto ch = pRoot->children();
    QMetaObject::invokeMethod(pRoot, "showTranslateResultTxt", Q_RETURN_ARG(QVariant, returnedValue), Q_ARG(QVariant, param));
}

void ZMainApplication::QmlInit()
{
    QQmlDebuggingEnabler enabler;

    m_engine.rootContext()->setContextProperty("cppTranslaterTool", m_cppTranslaterTool);
    m_engine.rootContext()->setContextProperty("cppOcrProcess", m_cppOcrProcess);

    const QUrl url(u"qrc:/Translater/main.qml"_qs);
    QObject::connect(&m_engine, &QQmlApplicationEngine::objectCreated,
        qApp, [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    m_engine.load(url);

}

void ZMainApplication::ConnectSig()
{
    QObject::connect(m_cppTranslaterTool,&ZTranslaterTool::finish ,this, &ZMainApplication::OnFinishTranslate);
    QObject::connect(m_cppOcrProcess, &ZOcrProcess::finish, this, &ZMainApplication::OnFinishOCR);
}

void ZMainApplication::RegisterHotKey()
{
    auto hotkey = new QHotkey(Qt::Key_F2,Qt::NoModifier, true, qApp); //The hotkey will be automatically registered
    qDebug() << "RegisterHotKey F2:" << hotkey->isRegistered();

    QObject::connect(hotkey, &QHotkey::activated, qApp, [&]() {
        QVariant returnedValue;
        QVariant param = true;
        QObject* pRoot = m_engine.rootObjects().first();
        auto objectName = pRoot->objectName();
        QMetaObject::invokeMethod(pRoot, "showScreenShotWindow", Q_RETURN_ARG(QVariant, returnedValue), Q_ARG(QVariant, param));
        });

}


