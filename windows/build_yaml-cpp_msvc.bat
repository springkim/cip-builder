@echo off
set version=0.6.3
set name=%~n0
call :SafeRMDIR %name%
mkdir %name%
cd %name%
curl -L "https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-%version%.zip" -o "yaml-cpp-%version%.zip"
7z x "yaml-cpp-%version%.zip" -y
mkdir build
cd build
cmake ../yaml-cpp-yaml-cpp-%version%^
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS:BOOL=ON
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