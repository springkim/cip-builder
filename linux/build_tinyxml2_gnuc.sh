version=7.1.0
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}


curl -L "https://github.com/leethomason/tinyxml2/archive/${version}.zip" -o "tinyxml2-${version}.zip"
7z x "tinyxml2-${version}.zip" -y
mkdir build
cd build
cmake ../tinyxml2-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=build\
 -DBUILD_SHARED_LIBS:BOOL=ON\
 -DBUILD_STATIC_LIBS:BOOL=OFF\
 -DBUILD_TESTS:BOOL=OFF


cmake --build . --config Release
cmake --build . --target install
