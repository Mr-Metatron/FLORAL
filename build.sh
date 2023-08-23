#!/bin/bash

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper

echo
echo "Issue Build Commands"
echo

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=/home/metatron/pixel4/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export DTC_EXT=/home/metatron/pixel4/dtc
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=/home/metatron/pixel4/gcc/64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/metatron/pixel4/gcc/32/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=/home/metatron/pixel4/clang/lib64:$LD_LIBRARY_PATH
export UPLOADNAME=-KernelSU
echo
echo "Set DEFCONFIG"
echo 
make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out kirisakura_defconfig

read -p "按任意键继续！"

echo
echo "Build The Good Stuff"
echo 

make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j10;
