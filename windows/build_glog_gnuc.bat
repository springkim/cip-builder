@echo off
set version=0.4.0
set name=%~n0
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://github.com/google/glog/archive/v%version%.zip" -o "glog-%version%.zip"
7z x "glog-%version%.zip" -y
mkdir build
cd build
cmake ../glog-%version%^
 -G "MinGW Makefiles"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS:BOOL=ON
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