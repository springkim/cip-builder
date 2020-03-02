@echo off
set version=2.1.1
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://support.hdfgroup.org/ftp/lib-external/szip/%version%/src/szip-%version%.tar.gz" -o "szip-%version%.tar.gz"
7z x "szip-%version%.tar.gz" -y
7z x "szip-%version%.tar" -y
mkdir build
cd build
cmake ../szip-%version%^
 -G "MinGW Makefiles"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS=ON^
 -DBUILD_TESTING=OFF
;

cmake --build . --config Release
cmake --build . --target install
pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b