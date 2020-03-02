@echo off
SET PATH=%PATH%;%cd%
set version=1.2.11
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://www.zlib.net/zlib%version:.=%.zip" -o "zlib%version:.=%.zip"
7z x "zlib%version:.=%.zip" -y
mkdir build
cd build
cmake ../zlib-%version%^
 -G "MinGW Makefiles"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=3rdparty^
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