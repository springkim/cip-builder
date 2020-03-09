version=3.3.7
name=${0%.*}
rm -r ${name}
mkdir ${name}
cd ${name}

curl -L "http://bitbucket.org/eigen/eigen/get/${version}.tar.bz2" -o "eigen-${version}.tar.bz2"
7z x "eigen-${version}.tar.bz2"
7z x "*.tar"
