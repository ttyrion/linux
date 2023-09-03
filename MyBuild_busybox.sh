#! /bin/bash

DEFAULT_ARCH="arm"
DEFAULT_CROSS_COMPILE="arm-linux-gnueabi-"
# default_config="vexpress_defconfig"
# default_kernel="zImage"

export CROSS_COMPILECHAIN=~/nvme0/embeded/toolchain/gcc-arm-8.2-arm-linux-gnueabi/gcc-arm-8.2-arm-linux-gnueabi
export PATH=$CROSS_COMPILECHAIN/bin:$PATH:

function build_busybox {
    echo "build_busybox starts:" $1

    def_config=$1
    if [[ $def_config == "" ]]
    then
        echo "[Error]: build_busybox needs a default config."
        return 1
    fi

    make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE LDFLAGS=--static $1
    make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE menuconfig
    make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE LDFLAGS=--static -j4
    return $?
}

build_busybox defconfig

