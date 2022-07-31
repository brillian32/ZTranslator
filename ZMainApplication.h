#pragma once
#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QOnlineTranslator.h"
#include "ztranslatertool.h"
#include <QQmlContext>
#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>
#include "QDebug"
#include "ZOcrProcess.h"
#include "qhotkey.h"
#include "qnamespace.h"

class ZMainApplication :public QObject
{
	Q_OBJECT
public:
	explicit  ZMainApplication(QObject* parent);

public slots:
	void OnFinishOCR();
	void OnFinishTranslate(int errorCode);
	
private:
	/**
	 * \brief ��ʼ��qml, ��������������
	 */
	void QmlInit();
	void ConnectSig();

	/**
	 * \brief ע���ȼ�
	 */
	void RegisterHotKey();
private:
	ZTranslaterTool* m_cppTranslaterTool = nullptr;
	ZOcrProcess*	m_cppOcrProcess = nullptr;
	QQmlApplicationEngine m_engine;

};