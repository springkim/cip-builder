version=0.4.0
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}

curl -L "https://github.com/google/glog/archive/v${version}.zip" -o "glog-${version}.zip"
7z x "glog-${version}.zip" -y
mkdir build
cd build
cmake ../glog-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=3rdparty\
 -DBUILD_SHARED_LIBS:BOOL=ON

cmake --build . --config Release
cmake --build . --target install
