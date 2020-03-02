@echo off
set opencv_version=3.4.9
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%
curl -L "https://github.com/opencv/opencv/archive/%opencv_version%.zip" -o "opencv-%opencv_version%.zip"
7z x "opencv-%opencv_version%.zip" -y
mkdir build
cd build
cmake ../opencv-%opencv_version%^
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DBUILD_DOCS=OFF^
 -DBUILD_TESTS=OFF^
 -DBUILD_PERF_TESTS=OFF^
 -DBUILD_PACKAGE=OFF^
 -DBUILD_IPP_IW=OFF^
 -DBUILD_opencv_world=ON^
 -DWITH_OPENMP=OFF^
 -DWITH_CUDA=ON^
 -DWITH_OPENCL=OFF^
 -DBUILD_SHARED_LIBS=ON^
 -DENABLE_PRECOMPILED_HEADERS=OFF^
 -DWITH_OPENEXR=OFF^
 -DBUILD_OPENEXR=OFF^
;

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
cmake --build . --config Debug --target ALL_BUILD
cmake --build . --config Debug --target INSTALL
pause
exit /b

::https://stackoverflow.com/questions/46298845/building-opencv-3-3-using-mingw-make-gives-error-2-at-47
:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b