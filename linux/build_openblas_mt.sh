version=0.3.9
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}



curl -L "https://github.com/xianyi/OpenBLAS/archive/v${version}.zip" -o "openblas-${version}.zip"
7z x "openblas-${version}.zip" -y
mkdir build
cd build
cmake ../OpenBLAS-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=3rdparty\
 -DUSE_THREAD=1\
 -DBUILD_SHARED_LIBS=1


cmake --build . --config Release
cmake --build . --target install
