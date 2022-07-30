#pragma once
#include <QObject>
#include <QTimer>
#include <QtConcurrent/qtconcurrentrun.h>

class ZOcrProcess :public QObject
{
	Q_OBJECT
public:
	explicit  ZOcrProcess(QObject* parent);

public slots:
	void startOCR(const QString imgPath);
	void setLanguage(const QString language);
	void OCRThtread( const QString imagePath);
	void setTrainDataPath(const QString);

private:
	QString m_trainDataPath = "C:\\Users\\17305\\Downloads\\tessdata_best-main\\tessdata_best-main";
	QString m_language = "eng";

};