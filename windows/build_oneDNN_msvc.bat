@echo off
set version=v1.5-rc
set fversion=1.5-rc
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://github.com/oneapi-src/oneDNN/archive/%version%.zip" -o "oneDNN-%version%.zip"
7z x "oneDNN-%version%.zip" -y
mkdir build
cd build
cmake ../oneDNN-%fversion%^
 -G "Visual Studio 15 2017 Win64"^
 -DCMAKE_BUILD_TYPE=RELEASE^
 -DCMAKE_INSTALL_PREFIX=build^
 -DDNNL_LIBRARY_TYPE=SHARED^
 -DDNNL_BUILD_TESTS=OFF^
 -DDNNL_GPU_RUNTIME=OCL^
 -DMKLDLL="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries_2020.1.216/windows/redist/intel64_win/mkl/mkl_rt.dll"^
 -DMKLINC="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries_2020.1.216/windows/mkl/include"^
 -DMKLLIB="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries_2020.1.216/windows/mkl/lib/intel64_win/mkl_rt.lib"^
 -DOPENCLROOT="C:\Program Files (x86)\IntelSWTools\sw_dev_tools\OpenCL\sdk"^
 -DOpenCL_INCLUDE_DIR="C:/Program Files (x86)/IntelSWTools/sw_dev_tools/OpenCL/sdk/include"^
 -DOpenCL_LIBRARY="C:/Program Files (x86)/IntelSWTools/sw_dev_tools/OpenCL/sdk/lib/x64/OpenCL.lib"^
 -DTBBROOT="C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2020.1.216\windows\tbb"^
 -D_DNNL_USE_MKL=ON^
 -DDNNL_VERBOSE=OFF^
 -DDNNL_BUILD_EXAMPLES=OFF
;

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b