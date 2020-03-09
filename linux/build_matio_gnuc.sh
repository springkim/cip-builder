version=1.5.17
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}


curl -L "https://github.com/tbeu/matio/releases/download/v${version}/matio-${version}.zip" -o "matio-${version}.zip"
7z x "matio-${version}.zip" -y
mkdir build
cd build

cmake ../matio-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=3rdparty\
 -DBUILD_SHARED_LIBS=OFF\
 -DBUILD_STATIC_LIBS=ON\
 -DBUILD_TESTING=OFF


cmake --build . --config Release
cmake --build . --target install
