#!/bin/bash

# Use CUDA_HOME provided by conda-build (automatically set for CUDA variants)
if [ -n "$CUDA_HOME" ]; then
    export CUDA_HOME
fi

meson setup $MESON_ARGS --reconfigure \
    -Ddefault_library=shared \
    -Dinclude-python-api=enabled \
    -Dpython-installation=${PREFIX}/bin/python3 \
    meson

cd meson
meson compile
meson install

# Clean up: move library to site-packages and remove unnecessary files
mkdir -p ${SP_DIR}
mv ${PREFIX}/lib/ffbidx ${SP_DIR}
rm -rf ${PREFIX}/share/ffbidx
rm -rf ${PREFIX}/include
