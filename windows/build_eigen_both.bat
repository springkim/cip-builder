@echo off
set version=3.3.7
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
::http://eigen.tuxfamily.org/index.php?title=Main_Page
curl -L "http://bitbucket.org/eigen/eigen/get/%version%.tar.bz2" -o "eigen-%version%.tar.bz2"
7z x "eigen-%version%.tar.bz2" -y
7z x "*.tar" -y

pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b