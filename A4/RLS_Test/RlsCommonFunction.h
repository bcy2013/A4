
#ifndef _RLS_COMMON_FUNCTION_H
#define _RLS_COMMON_FUNCTION_H

#include <QDateTime>
#include <QString>
#include <QDir>
#include <QTextStream>
#include <QFile>
#include <qvector.h>
#include <qcoreapplication.h>

namespace LOG_FUN
{
	inline bool WriteLog( const QString& strMsg, bool bEngineer = false )
	{
		QDateTime dt = QDateTime::currentDateTime();

		QString strDataTime = dt.toString( "yyyy/MM/dd hh:mm:ss" );

		QString strFileName = dt.toString( "yyyyMMdd" );

		//QString strExeDir = QDir::currentPath();
		QString strExeDir = QCoreApplication::applicationDirPath();

		QString strLogFile;
		if( bEngineer )
			strLogFile = strExeDir + "/LOG/" + strFileName + "_log_E.txt";
		else
			strLogFile = strExeDir + "/LOG/" + strFileName + "_log.txt";

		QString strLogDir = strExeDir + "/LOG/";

		QDir dir( strExeDir );
		if( !dir.exists( strLogDir ) )
			dir.mkpath( strLogDir );

		QFile file( strLogFile );

		if( !file.open( QIODevice::WriteOnly | QIODevice::Text | QIODevice::Append ) )
			return false;

		QTextStream out( &file );

		out << strDataTime << strMsg << "\r\n";
		file.close();

		return true;
	}
};

namespace DIR_FUN
{
	inline bool CreateSubDir(const QString& strDir, const QString& strSubDir)
	{
		QDir dir(strDir);
		return dir.mkpath(strSubDir);
	}

	inline bool ExistSubDir(const QString& strDir, const QString& strSubDir)
	{
		QDir dir(strDir);
		return dir.exists(strSubDir);
	}

	inline bool ExistDirFile(const QString& strDir, const QString& strFile)
	{
		QDir dir(strDir);
		return dir.exists(strFile);
	}

	inline bool RemoveDirFile(const QString& strDir, const QString& strFile)
	{
		QDir dir(strDir);
		return dir.remove(strFile);
	}

	inline bool DeleteDir(const QString& strDir)
	{
		QDir dir(strDir);
		QFileInfoList dirlist = dir.entryInfoList(QDir::AllEntries | QDir::NoDotAndDotDot | QDir::Hidden | QDir::System);
		for (int i = 0; i < dirlist.size(); i++)
		{
			QFileInfo& fileInfo = dirlist[i];
			QString strFileName = fileInfo.fileName();
			QString strFilePath = fileInfo.absoluteFilePath();
			if (fileInfo.isDir())	//处理目录
			{
				if (!DeleteDir(strFilePath))
					return false;
			}

			if (fileInfo.isFile())	//处理文件
			{
				if (!dir.remove(strFilePath))
					return false;
			}
		}
		return dir.rmdir(strDir);
	}

	inline bool DeleteSubDir(const QString& strDir, const QString& strSubDir)
	{
		return DeleteDir(strDir + "\\" + strSubDir);
	}

	inline bool SearchFile(const QString& strDir, const QString& strFileExt, QVector<QString>& vstrBaseFile)
	{
		QDir dir(strDir);

		QString str = "*.";
		str += strFileExt;

		QStringList filters;
		filters << str;
		QFileInfoList dirlist = dir.entryInfoList(filters, QDir::Files, QDir::Name);

		for (int i = 0; i < dirlist.size(); i++)
		{
			QFileInfo& fileInfo = dirlist[i];
			vstrBaseFile.push_back(fileInfo.baseName());
		}

		return true;
	}

	inline bool GetSubDir(const QString& strDir, QVector<QString>& vstrSubDir)
	{
		QDir dir(strDir);
		QFileInfoList dirlist = dir.entryInfoList(QDir::AllEntries | QDir::NoDotAndDotDot | QDir::Hidden | QDir::System);
		for (int i = 0; i < dirlist.size(); i++)
		{
			QFileInfo& fileInfo = dirlist[i];
			QString strFileName = fileInfo.fileName();

			if (fileInfo.isDir())	//处理目录
			{
				vstrSubDir.push_back(strFileName);

			}
		}
		return true;
	}

	inline bool	RemoveDir(const QString& strDir)
	{
		QDir dir(strDir);
		if (!dir.exists())
			return true;

		QFileInfoList list = dir.entryInfoList(QDir::AllEntries | QDir::NoDot | QDir::NoDotDot);
		for (int i = 0; i < list.size(); ++i)
		{
			QFileInfo fileInfo = list.at(i);
			if (fileInfo.isFile())
				dir.remove(fileInfo.fileName());

			if (fileInfo.isDir())
			{
				if (!RemoveDir(fileInfo.filePath()))
					return false;
			}
		}


		dir.cdUp();
		dir.rmdir(strDir);

		return true;
	}

};

//time 是当前小时的多少微秒
inline unsigned long int MSecondOfHour(const QTime& time)
{
	int nMinute = time.minute();
	int nSecond = time.second();
	int nMSecond = time.msec();

	//unsigned long int nMSecondOfHour = nMinute * 60000 + nSecond * 1000 +  nMSecond;
	unsigned long int nMSecondOfHour = nMinute * 1000 + nSecond * 10 + nMSecond / 100;
	return nMSecondOfHour;
}

//time 是一天中的地多少秒
inline int SecondOfDay(const QTime& time)
{
	int nHour, nMinute, nSecond;
	nHour = time.hour();
	nMinute = time.minute();
	nSecond = time.second();

	int nSecondOfDay = nHour * 3600 + nMinute * 60 + nSecond;

	return nSecondOfDay;
}

#endif