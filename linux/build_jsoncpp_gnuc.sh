version=1.9.2
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}


curl -L "https://github.com/open-source-parsers/jsoncpp/archive/${version}.zip" -o "jsoncpp-${version}.zip"
7z x "jsoncpp-${version}.zip" -y
mkdir build
cd build
cmake ../jsoncpp-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=3rdparty\
 -DBUILD_SHARED_LIBS=ON\
 -DBUILD_STATIC_LIBS=OFF\
 -DBUILD_TESTING=OFF\
 -DJSONCPP_WITH_CMAKE_PACKAGE=OFF\
 -DJSONCPP_WITH_PKGCONFIG_SUPPORT=OFF\
 -DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF\
 -DJSONCPP_WITH_STRICT_ISO=OFF\
 -DJSONCPP_WITH_TESTS=OFF\
 -DCMAKE_DEBUG_POSTFIX=d


cmake --build . --config Release
cmake --build . --target install
