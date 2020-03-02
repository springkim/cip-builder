@echo off
set version=4.2.2
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
::https://ffmpeg.zeranoe.com/builds/
curl -L "https://ffmpeg.zeranoe.com/builds/win64/dev/ffmpeg-%version%-win64-dev.zip" -o "ffmpeg-dev-%version%.zip"
7z x "ffmpeg-dev-%version%.zip" -y

curl -L "https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-%version%-win64-shared.zip" -o "ffmpeg-shared-%version%.zip"
7z x "ffmpeg-shared-%version%.zip" -y

pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b