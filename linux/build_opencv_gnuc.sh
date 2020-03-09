version=3.4.9
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}

curl -L "https://github.com/opencv/opencv/archive/${version}.zip" -o "opencv-${version}.zip"
7z x "opencv-${version}.zip" -y
mkdir build
cd build
cmake ../opencv-${version}\
 -G "Unix Makefiles"\
 -DCMAKE_BUILD_TYPE=RELEASE\
 -DCMAKE_INSTALL_PREFIX=build\
 -DBUILD_DOCS=OFF\
 -DBUILD_TESTS=OFF\
 -DBUILD_PERF_TESTS=OFF\
 -DBUILD_PACKAGE=OFF\
 -DBUILD_IPP_IW=OFF\
 -DBUILD_opencv_world=ON\
 -DWITH_OPENMP=OFF\
 -DWITH_CUDA=OFF\
 -DWITH_OPENCL=OFF\
 -DWITH_EIGEN=OFF\
 -DBUILD_SHARED_LIBS=ON\
 -DBUILD_STATIC_LIBS=OFF\
 -DENABLE_PRECOMPILED_HEADERS=OFF\
 -DWITH_OPENEXR=OFF\
 -DBUILD_OPENEXR=OFF


cmake --build . --config Release
cmake --build . --target install
