@echo off
SET PATH=%PATH%;%cd%
set version=1.5.17
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
::https://packages.msys2.org/package/mingw-w64-x86_64-matio
curl -L "http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-matio-1.5.17-1-any.pkg.tar.xz" -o "matio.tar.xz"
7z x "matio.tar.xz" -y
7z x "*.tar" -y


pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b