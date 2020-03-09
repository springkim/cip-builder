version=4.2.2
name=${0%.*}
rm -r ${name}
mkdir ${name}
cd ${name}

curl -L "https://ffmpeg.org/releases/ffmpeg-${version}.tar.bz2" -o ffmpeg-${version}.tar.bz2
7z x "ffmpeg-${version}.tar.bz2" -y
7z x "ffmpeg-${version}.tar" -y

cd ffmpeg-${version}
sh ./configure --disable-x86asm
chmod 777 ./ffbuild/version.sh
chmod 777 ./ffbuild/pkgconfig_generate.sh

make
mkdir 3rdparty
mkdir 3rdparty/include
mkdir 3rdparty/lib

mv libswresample/libswresample.a 3rdparty/lib/
mv libavcodec/libavcodec.a 3rdparty/lib/
mv libavutil/libavutil.a 3rdparty/lib/
mv libavfilter/libavfilter.a 3rdparty/lib/
mv libswscale/libswscale.a 3rdparty/lib/
mv libavformat/libavformat.a 3rdparty/lib/
mv libavdevice/libavdevice.a 3rdparty/lib/

mv libswresample/ 3rdparty/include/
mv libavcodec/ 3rdparty/include/
mv libavutil/ 3rdparty/include/
mv libavfilter/ 3rdparty/include/
mv libswscale/ 3rdparty/include/
mv libavformat/ 3rdparty/include/
mv libavdevice/ 3rdparty/include/
