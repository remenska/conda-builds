#!/bin/bash

mkdir -vp ${PREFIX}/bin;
echo $PREFIX
export CFLAGS="-Wall -g -m64 -pipe -O2 -march=x86-64 -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
# export LDFLAGS="-B${PREFIX}/lib/ -Wl,-rpath-link,${PREFIX}/lib"
echo 'gcc version'
gcc -v
# -Wl,-dynamic-linker,/path/to/alternate/ld-linux.so.2
# LDFLAGS = -B/usr/i386-mylib-linux/lib/ -Wl,-rpath-link,/usr/i386-mylib-linux/lib

ARCH="$(uname 2>/dev/null)"

#export TMPDIR=`conda info --root`/tmpdir

mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d

cp ${RECIPE_DIR}/activateROOT.sh $PREFIX/etc/conda/activate.d
cp ${RECIPE_DIR}/deactivateROOT.sh $PREFIX/etc/conda/deactivate.d


LinuxInstallation() {
# Build dependencies:
# - libXpm-devel
# - libX11-devel


chmod +x configure;

make distclean;

#  ./configure \
#      ${ARCH,,*}x8664gcc \
#      --minimal \
#      --enable-x11 \
#      --enable-python \
#      --enable-xml \
#      --with-python-incdir=`python3.4-config --exec-prefix`/include/python3.4m \
#      --with-python-libdir=`python3.4-config --exec-prefix`/lib \
#      --etcdir=${PREFIX}/etc/root \
#      --prefix=${PREFIX} \
#      || return 1;
#--enable-roofit \
# --enable-x11 \
#--enable-xml \
# --prefix=${PREFIX} \
#--enable-rpath \
# --enable-soversion \
#--enable-qt \
#--enable-minuit2 \
#--enable-shared \
#--enable-sqlite \
#--enable-ssl \
#-	-with-qt-incdir=${PREFIX}/include/ \
#--with-qt-libdir=${PREFIX}/lib/ \
#--with-ssl-incdir=${PREFIX}/include/openssl/ \
#--with-ssl-libdir=${PREFIX}/lib/ \
#--with-ssl-shared=yes \
#--with-sqlite-incdir=${PREFIX}/include/  \
#--with-sqlite-libdir=${PREFIX}/lib/  \
#--with-python-incdir=${PREFIX}/include/python${PY_VER}/ \
#--with-python-libdir=${PREFIX}/lib/ \
#--with-x11-libdir=${PREFIX}/lib/ \

mkdir workdir
cd workdir

cmake ../ -DCMAKE_INSTALL_PREFIX=$PREFIX \
-Dbuiltin_llvm=ON \
-Dbuiltin-lzma=ON \
-Dbuiltin_zlib=ON \
-Dbuiltin_freetype=ON \
-Dcxx11=ON \
-Drpath=ON \
-Droofit=ON \
-Dopengl=OFF \
-Dgviz=OFF \
|| return 1;
#-DCMAKE_C_COMPILER=$PREFIX/bin/gcc \
#-DCMAKE_CXX_COMPILER=$PREFIX/bin/c++ \
#-Dbuiltin_pcre=ON \

#-Dbuiltin_gsl=ON \

make -j2 || return 1;
make install || return 1;

return 0;
}

MacInstallation() {
export CPPFLAGS="-I${PREFIX}/include"
export CPATH="${PREFIX}/include"
export LIBPATH="${PREFIX}/lib"
export CMAKE_OSX_DEPLOYMENT_TARGET=10.9
export MACOSX_DEPLOYMENT_TARGET=10.9
export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
chmod +x configure;
#export CC=clang
export CFLAGS="${CFLAGS} -D_DARWIN_SOURCE"
export CC=clang
export CXX=clang++
export LD=clang++
export SQLITELIBDIR="${PREFIX}/lib"
export SQLITEINCDIR="${PREFIX}/include"
export SQLITE_INCLUDE_DIR="${PREFIX}/include"
export SQLITE_LIBRARIES="${PREFIX}/lib/libsqlite3.dylib"
export ASEXTRALIB="${PREFIX}/lib/libpng.dylib;${PREFIX}/lib/libz.dylib"
export ASEXTRALIBDIR="${PREFIX}/lib"
export ASJPEGINCDIR="${PREFIX}/include"
export ASTIFFINCDIR="${PREFIX}/include"
export SQLITELIBDIR="${PREFIX}/lib"
export ASPNGINCDIR="${PREFIX}/include"
export PC_SQLITE_LIBDIR="${PREFIX}/lib"
export PNG_LIBRARY="${PREFIX}/lib/libpng.dylib"
export PNG_PNG_INCLUDE_DIR="${PREFIX}/include"
export PNG_LIBRARY_RELEASE="${PREFIX}/lib/libpng.dylib"
export FREETYPE_INCLUDE_DIR="${PREFIX}/include"
export FREETYPE_LIBRARIES="${PREFIX}/lib/freetype.lib"
# export PYTHON_EXECUTABLE="${PREFIX}/bin/python"
# export PYTHON_INCLUDE_DIR="${PREFIX}/include/python3.4m"
# export PYTHON_LIBRARY="${PREFIX}/lib/libpython3.4m.dylib"
make distclean;

#  ./configure \
#      ${ARCH,,*}x8664gcc \
#      --minimal \
#      --enable-x11 \
#      --enable-python \
#      --enable-xml \
#      --with-python-incdir=`python3.4-config --exec-prefix`/include/python3.4m \
#      --with-python-libdir=`python3.4-config --exec-prefix`/lib \
#      --etcdir=${PREFIX}/etc/root \
#      --prefix=${PREFIX} \
#      || return 1;
#--enable-roofit \
# --enable-x11 \
#--enable-xml \
# --prefix=${PREFIX} \
#--enable-rpath \
# --enable-soversion \
#--enable-qt \
#--enable-minuit2 \
#--enable-shared \
#--enable-sqlite \
#--enable-ssl \
#--with-qt-incdir=${PREFIX}/include/ \
#--with-qt-libdir=${PREFIX}/lib/ \
#--with-ssl-incdir=${PREFIX}/include/openssl/ \
#--with-ssl-libdir=${PREFIX}/lib/ \
#--with-ssl-shared=yes \
#--with-sqlite-incdir=${PREFIX}/include/  \
#--with-sqlite-libdir=${PREFIX}/lib/  \
#--with-python-incdir=${PREFIX}/include/python${PY_VER}/ \
#--with-python-libdir=${PREFIX}/lib/ \
#--with-x11-libdir=${PREFIX}/lib/ \

mkdir workdir
cd workdir

cmake ../ -DCMAKE_INSTALL_PREFIX=$PREFIX \
-Dccache=ON \
-Dpython=ON \
-Droofit=ON \
-Dalien=OFF \
-Dasimage=OFF \
-Dastiff=OFF \
-Dbonjour=OFF \
-Dbuiltin_ftgl=OFF \
-Dbuiltin_glew=OFF \
-Dccache=ON \
-Dchirp=OFF \
-Ddcache=OFF \
-Dfitsio=OFF \
-Dgviz=OFF \
-Dopengl=OFF \
-Dsqlite=OFF \
-Dldap=OFF \
-Dpgsql=OFF \
-Dkrb5=OFF \
-Dpgsql=OFF \
-Dshadowpw=OFF \
-Dfftw3=OFF \
-Dfortran=OFF \
-Dgenvector=OFF \
-Dmathmore=OFF \
-Dmemstat=OFF \
-Dssl=OFF \
-Dxml=OFF \
-Dbuiltin_ftgl=OFF \
|| return 1;
# -Droofit=ON \


# -Dopengl=OFF \
# -Dsqlite=OFF \
# # -Dldap=OFF \
# -Dpgsql=OFF  \
# -Dkrb5=OFF \
# -Dpgsql=OFF \
# -Dshadowpw=OFF \
#-Dbuiltin_llvm=ON \
#-Dcxx11=ON \
#-Drpath=ON \
#-Dopengl=OFF \
#-Dgviz=OFF \
#-Dasimage=ON \
#-Dastiff=ON \
#-Dsqlite=OFF \
#-Dldap=OFF \
#-Dpgsql=OFF  \
#-Dkrb5=OFF \
#-Dpgsql=OFF \
#-Dfortran=OFF \


#-DFREETYPE_INCLUDE_DIR=$PREFIX/include \
#-DFREETYPE_LIBRARY=$PREFIX/lib \
#-DFREETYPE_INCLUDE_DIR_freetype2=$PREFIX/include \
#-DJPEG_INCLUDE_DIR=$PREFIX/include \
#-DJPEG_LIBRARY=$PREFIX/lib \
# -Dbuiltin_pcre=ON \
# -Dbuiltin_freetype=ON \
#-Dbuiltin_gsl=ON \
# -Dbuiltin-lzma=ON \
# -Dbuiltin_zlib=ON \


make -j2 || return 1;
make install || return 1;

return 0;

}


case ${ARCH} in
'Linux')
LinuxInstallation || exit 1;
;;
'Darwin')
MacInstallation || exit 1;
;;
*)
echo -e "Unsupported machine type: ${ARCH}";
exit 1;
;;
esac


#POST_LINK="${PREFIX}/bin/.root-post-link.sh"
#cp -v ${RECIPE_DIR}/post-link.sh ${POST_LINK};
#chmod -v 0755 ${POST_LINK};
