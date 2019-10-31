#!/bin/bash

cp -f GNUmakefile Makefile
mkdir -p "${PREFIX}/bin"

# Building PALP optimized for different dimensions
for dim in 4 5 6 11; do

    make CFLAGS="${CFLAGS} -DPOLY_Dmax=$dim"

    for file in poly class cws nef mori; do
        cp ${file}.x "$PREFIX"/bin/${file}-${dim}d.x
    done

    make cleanall

done

# Symlink the 6d versions as the default dimension
for file in poly class cws nef mori; do
    ln -sf "$PREFIX"/bin/${file}-6d.x "$PREFIX"/bin/${file}.x
done
