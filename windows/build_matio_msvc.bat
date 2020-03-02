@echo off
SET PATH=%PATH%;%cd%
set version=1.5.17
set name=%~n0
title %name%
call :SafeRMDIR %name%
mkdir %name%
cd %name%

curl -L "https://github.com/tbeu/matio/releases/download/v%version%/matio-%version%.zip" -o "matio-%version%.zip"
7z x "matio-%version%.zip" -y
mkdir build
cd build

vswhere -property productPath > devenv.txt
set /p "devenv="<"devenv.txt"
"%devenv%" "..\matio-%version%\visual_studio\matio.sln" /upgrade | rem
"%devenv%" "..\matio-%version%\visual_studio\matio.sln" /build "Debug|x64" | rem
"%devenv%" "..\matio-%version%\visual_studio\matio.sln" /build "Release|x64" | rem

md 3rdparty
md 3rdparty\include
md 3rdparty\lib
md 3rdparty\lib\Debug
md 3rdparty\lib\Release
md 3rdparty\bin\Debug
md 3rdparty\bin\Release

xcopy /Y "..\matio-%version%\src\matio.h" "3rdparty\include\"
xcopy /Y "..\matio-%version%\visual_studio\matio_pubconf.h" "3rdparty\include\"
xcopy /Y "..\matio-%version%\visual_studio\matioConfig.h" "3rdparty\include\"

xcopy /Y "..\matio-%version%\visual_studio\x64\Debug\libmatio.lib" "3rdparty\lib\Debug\libmatiod.lib*"
xcopy /Y "..\matio-%version%\visual_studio\x64\Release\libmatio.lib" "3rdparty\lib\Release\"

xcopy /Y "..\matio-%version%\visual_studio\x64\Debug\libmatio.dll" "3rdparty\bin\Debug\libmatiod.dll*"
xcopy /Y "..\matio-%version%\visual_studio\x64\Release\libmatio.dll" "3rdparty\bin\Release\"


pause
exit /b

:SafeRMDIR
IF EXIST "%~1" (
	RMDIR /S /Q "%~1"
)
exit /b