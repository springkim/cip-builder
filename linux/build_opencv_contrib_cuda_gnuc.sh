version=3.4.9
name=${0%.*}
rm -r ${name} 2>/dev/null
mkdir ${name}
cd ${name}

curl -L "https://github.com/opencv/opencv/archive/${version}.zip" -o "opencv-${version}.zip"
curl -L "https://github.com/opencv/opencv_contrib/archive/${version}.zip" -o "opencv_contrib-${version}.zip"
7z x "opencv-${version}.zip" -y
7z x "opencv_contrib-${version}.zip" -y
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
 -DWITH_CUDA=ON\
 -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.1\
 -DWITH_OPENCL=OFF\
 -DWITH_EIGEN=OFF\
 -DBUILD_SHARED_LIBS=ON\
 -DBUILD_STATIC_LIBS=OFF\
 -DENABLE_PRECOMPILED_HEADERS=OFF\
 -DBUILD_opencv_cudacodec=OFF\
 -DWITH_OPENEXR=OFF\
 -DBUILD_OPENEXR=OFF\
 -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-${version}/modules

cmake --build . --config Release
cmake --build . --target install
