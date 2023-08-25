#!/bin/bash

echo "Add KernelSU to kernel source tree"
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -


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
export CLANG_PATH=/PATH/TO/YOUR/CLANG/bin
export PATH=${CLANG_PATH}:${PATH}
export DTC_EXT=/PATH/TO/YOUR/DTC
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=/PATH/TO/YOUR/GCC-64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/PATH/TO/YOUR/GCC-32/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=/PATH/TO/YOUR/CLANG/lib64:$LD_LIBRARY_PATH

echo
echo "Set DEFCONFIG"
echo 
make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out docker_defconfig

#make O=out menuconfig
#make O=out savedefconfig

check-config.sh out/.config
read -p "按任意键继续！"

echo
echo "Build The Good Stuff"
echo 

make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j10;
