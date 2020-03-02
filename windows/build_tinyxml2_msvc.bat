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
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS:BOOL=ON^
 -DBUILD_STATIC_LIBS:BOOL=OFF^
 -DBUILD_TESTS:BOOL=OFF
;

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
cmake --build . --config Debug --target ALL_BUILD
cmake --build . --config Debug --target INSTALL
pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b