#!/bin/sh
installResources=`pwd`/Resources
scriptResources=$installResources/scripts

productFolder=/Developer/Cocotron/1.0
downloadFolder=$productFolder/Downloads

if [ ""$1"" = "" ];then
  targetPlatform="Windows"
else
  targetPlatform=$1
fi

if [ ""$2"" = "" ];then
  targetArchitecture="i386"
else
  targetArchitecture=$2
fi

if [ ""$3"" = "" ];then
  gccVersion="4.3.1"
else
  gccVersion=$3
fi

BASEDIR=/Developer/Cocotron/1.0/$targetPlatform/$targetArchitecture
PREFIX=/Developer/Cocotron/1.0/Windows/i386/gcc-4.3.1/i386-mingw32msvc

BUILD=/tmp/build_openssl

mkdir -p $PREFIX


VERSION=1.0.2j
$scriptResources/downloadFilesIfNeeded.sh $downloadFolder https://www.openssl.org/source/openssl-${VERSION}.tar.gz

mkdir -p $BUILD
cd $BUILD
tar -xvzf $downloadFolder/openssl-${VERSION}.tar.gz
cd openssl-${VERSION}

pwd 

export GCC=$(echo $BASEDIR/gcc-$gccVersion/bin/*gcc)
export AS=$(echo $BASEDIR/gcc-$gccVersion/bin/*as)
export AR=$(echo $BASEDIR/gcc-$gccVersion/bin/*ar)
export RANLIB=$(echo $BASEDIR/gcc-$gccVersion/bin/*ranlib)
export TARGET=$($GCC -dumpmachine)


./Configure mingw no-shared --cross-compile-prefix=i386-mingw32msvc- --prefix=${PREFIX}
#./Configure mingw shared --cross-compile-prefix=i386-mingw32msvc- --prefix=${PREFIX}

make && make install
