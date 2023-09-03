#! /bin/bash

DEFAULT_ARCH="arm"
DEFAULT_CROSS_COMPILE="arm-none-eabi-"
default_config="vexpress_defconfig"
default_kernel="zImage"

export CROSS_COMPILECHAIN=~/nvme0/embeded/toolchain/gcc-arm-none-eabi-5_4-2016
export PATH=$CROSS_COMPILECHAIN/bin:$PATH:

function config_kernel {
    echo "config_kernel starts:" $1

    def_config=$1
    if [[ $def_config == "" ]]
    then
        echo "[Error]: config_kernel needs a default config."
        return 1
    fi

    make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE $def_config
    make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE menuconfig
    return $?
}

function build_kernel {
    echo "build_kernel starts."

    def_obj=$1
    if [[ $def_obj == "" ]]
    then
        echo "[Error]: build_kernel needs a object."
        return 1
    fi
    make -j8 ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE $def_obj
    return $?
}

if [[ $1 == "config" ]]
then
    config_kernel $default_config
elif [ $1 == "kernel" ]
then
    build_kernel $default_kernel
else
    echo "wrong parameters"
fi
