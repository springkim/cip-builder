@echo off
set version=1.9.2
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://github.com/open-source-parsers/jsoncpp/archive/%version%.zip" -o "jsoncpp-%version%.zip"
7z x "jsoncpp-%version%.zip" -y
mkdir build
cd build
cmake ../jsoncpp-%version%^
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS=ON^
 -DBUILD_TESTING=OFF^
 -DJSONCPP_WITH_CMAKE_PACKAGE=OFF^
 -DJSONCPP_WITH_PKGCONFIG_SUPPORT=OFF^
 -DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF^
 -DJSONCPP_WITH_STRICT_ISO=OFF^
 -DJSONCPP_WITH_TESTS=OFF^
 -DCMAKE_DEBUG_POSTFIX=d
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