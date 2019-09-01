@echo off
setlocal enabledelayedexpansion
REM 声明采用UTF-8编码
chcp 65001

:MAIN
	set sourceDir=img
	: 上限200kb, 200kb以上的图都需要处理到200kb以下
	rem set /a limitSize=100*1024

	set /p limitSize=请告诉我你要压缩到多少kb以下(注意:不需要输入单位): 
	set /a limitSize=%limitSize%*1024

	echo the limit size you input is: %limitSize%

	set filelist=filelist.txt

	dir %sourceDir% /b /a-d/s > %filelist%

	echo;
	echo file list as follow:
	rem for /f %%f in (%filelist%) do (echo %%f)
	for /f "delims=" %%f in (%filelist%)  do (echo %%f)

	rem for /f %%f in (%filelist%) do (
	for /f "delims=" %%f in (%filelist%)  do (
		set file=%%f
		echo;
		echo [file]: --------------!file!
		call :resize "!file!"
		echo 	file done
		rem timeout /t 2 /nobreak > nul
	)
	echo;
	echo all done!
	pause
goto :eof


:getFileSize
	rem echo 文件名..: %1
	for %%i in (%1) do (
		rem echo 文件大小:%%~zi
		set %~2=%%~zi
	)
	rem for /f "delims=" %%f in ('dir /b/a-d/s %1') do set /a fileSize=%%~zi
goto :eof

rem useless
:resize1
	rem :validSize
	rem echo 	[file]: %1
	call :getFileSize %1 fileSize
	rem echo 	[fileSize]: !fileSize!

	if !fileSize! gtr %limitSize% (
		: 压缩
		echo 	squash begin...
		"ImageMagick-7.0.8-62-portable-Q16-x64/convert.exe" -sample 80%%x80%% "!file!" "!file!"
		rem timeout /t 3 /nobreak > nul
		rem goto validSize
	)
	echo 	file done
goto :eof

:resize
	rem echo 	文件名: %1
	for /l %%i in (1,1,100) do (
		rem echo 	%%i
		call :getFileSize %1 fileSize
		rem echo 	limitSize: %limitSize%
		rem echo 	fileSize: !fileSize!
		if !fileSize! gtr %limitSize% (
			: 压缩
			echo 	squash processing...
			"ImageMagick-7.0.8-62-portable-Q16-x64/convert.exe" -sample 95%%x95%% "!file!" "!file!"
			rem timeout /t 3 /nobreak > nul
		)
	)
goto :eof
