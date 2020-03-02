@echo off
set version=4.2.2
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
::https://packages.msys2.org/base/mingw-w64-ffmpeg
::https://packages.msys2.org/package/mingw-w64-x86_64-ffmpeg?repo=mingw64
curl -L "http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-ffmpeg-%version%-2-any.pkg.tar.xz" -o "ffmpeg-%version%.tar.xz"
7z x "ffmpeg-%version%.tar.xz" -y
7z x "*.tar" -y

pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b