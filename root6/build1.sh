ln -s $PREFIX/lib $PREFIX/lib64

echo 'gcc version' 
gcc -v

export TMPDIR=/media/osboxes/New/tmpdir

if [ "$(uname)" == "Darwin" ]; then
    export LDFLAGS="-Wl,-headerpad_max_install_names"
    export BOOT_LDFLAGS="-Wl,-headerpad_max_install_names"

    ./configure \
        --prefix=$PREFIX \
        --libdir=$PREFIX/lib \
        --with-gmp=$PREFIX \
        --with-mpfr=$PREFIX \
        --with-mpc=$PREFIX \
        --with-isl=$PREFIX \
        --with-cloog=$PREFIX \
        --with-boot-ldflags=$LDFLAGS \
        --with-stage1-ldflags=$LDFLAGS \
        --enable-checking=release \
        --disable-multilib \
        --enable-languages=c,c++ 
else
    # For reference during post-link.sh, record some
    # details about the OS this binary was produced with.
    mkdir -p ${PREFIX}/share
    cat /etc/*-release > ${PREFIX}/share/conda-gcc-build-machine-os-details
    ./configure \
        --prefix=$PREFIX \
        --libdir=$PREFIX/lib \
        --with-gmp=$PREFIX \
        --with-mpfr=$PREFIX \
        --with-mpc=$PREFIX \
        --with-isl=$PREFIX \
        --with-cloog=$PREFIX \
        --enable-checking=release \
        --disable-multilib \
        --enable-languages=c,c++
fi
make
make install
rm $PREFIX/lib64

# Link cc to gcc
(cd $PREFIX/bin && ln -s gcc cc)

