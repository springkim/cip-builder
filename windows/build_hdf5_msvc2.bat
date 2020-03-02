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
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_SHARED_LIBS=ON^
 -DBUILD_TESTING=OFF^
 -DHDF5_ALLOW_EXTERNAL_SUPPORT=TGZ^
 -DHDF5_PACKAGE_EXTLIBS=ON^
 -DHDF5_ENABLE_SZIP_ENCODING=ON^
 -DHDF5_ENABLE_SZIP_SUPPORT=ON^
 -DHDF5_BUILD_GENERATORS=ON^
 -DHDF5_BUILD_HL_LIB=ON^
 -DHDF5_BUILD_TOOLS=ON^
 -DHDF5_ENABLE_EMBEDDED_LIBINFO=ON^
 -DHDF5_ENABLE_HSIZET=ON^
 -DHDF5_GENERATE_HEADERS=ON^
 -DHDF5_PACKAGE_EXTLIBS=ON^
 -DHDF5_BUILD_FORTRAN=ON^
 -DHDF5_ENABLE_DEPRECATED_SYMBOLS=ON^
 -DCPACK_SOURCE_7Z=ON^
 -DCPACK_SOURCE_ZIP=ON^
 -DHDF5_BUILD_CPP_LIB=ON^
 -DHDF5_USE_FOLDERS=ON^
 -DSZIP_PACKAGE_NAME=szip^
 -DSZIP_TGZ_NAME=SZip.tar.gz^
 -DSZIP_USE_EXTERNAL=ON^
 -DHDF5_ENABLE_Z_LIB_SUPPORT=ON^
 -DZLIB_PACKAGE_NAME=zlib^
 -DZLIB_TGZ_NAME=ZLib.tar.gz^
 -DZLIB_USE_EXTERNAL=ON^
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