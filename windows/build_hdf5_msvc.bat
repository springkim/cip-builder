@echo off
SET PATH=%PATH%;%cd%
set version=1.10.6
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
::https://www.hdfgroup.org/downloads/hdf5/source-code/
set link="https://www.hdfgroup.org/package/cmake-hdf5-1-10-6-zip/?wpdmdl=14132&refresh=5e57511ecd02a1582780702"

curl -L %link% -o "hdf5.zip"
7z x "hdf5.zip" -y
cd "CMake-hdf5-%version%"
md build
cd build
cmake ../hdf5-%version%^
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=3rdparty^
 -DBUILD_SHARED_LIBS=ON^
 -DBUILD_TESTING=OFF^
 -DONLY_SHARED_LIBS=ON^
 -DHDF5_BUILD_CPP_LIB=OFF^
 -DHDF5_BUILD_HL_LIB=OFF^
 -DHDF5_BUILD_TOOLS=OFF^
 -DHDF5_ENABLE_DEPRECATED_SYMBOLS=OFF^
 -DCMAKE_DEBUG_POSTFIX=d
;
::https://stackoverflow.com/questions/34050155/symbol-not-found-linking-to-hdf-library
cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
cmake --build . --config Debug --target ALL_BUILD
cmake --build . --config Debug --target INSTALL
::
:: Add
:: #define H5_BUILT_AS_DYNAMIC_LIB 1
:: to H5pubconf.h
::
pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b