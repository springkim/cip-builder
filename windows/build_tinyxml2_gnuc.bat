@echo off
set version=7.1.0
set name=%~n0
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://github.com/leethomason/tinyxml2/archive/%version%.zip" -o "tinyxml2-%version%.zip"
7z x "tinyxml2-%version%.zip" -y
mkdir build
cd build
cmake ../tinyxml2-%version%^
 -G "MinGW Makefiles"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS:BOOL=ON^
 -DBUILD_STATIC_LIBS:BOOL=OFF^
 -DBUILD_TESTS:BOOL=OFF
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