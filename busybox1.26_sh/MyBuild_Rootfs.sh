#! /bin/bash

DEFAULT_ARCH="arm"
DEFAULT_CROSS_COMPILE="arm-linux-gnueabi-"
# default_config="vexpress_defconfig"
# default_kernel="zImage"

export CROSS_COMPILECHAIN=~/nvme0/embeded/toolchain/gcc-arm-8.2-arm-linux-gnueabi/gcc-arm-8.2-arm-linux-gnueabi
export PATH=$CROSS_COMPILECHAIN/bin:$PATH:

# make_rootfs_with_busybox root_hd_img 1M 1024
function make_rootfs_with_busybox {
    filename=$1 #virtual fs file name
    bs=$2       #block size
    count=$3    #block count

    dd if=/dev/zero of=$filename bs=$bs count=$count
    mkfs.ext2 $filename
    mkdir -p ./rootfs
    sudo mount $filename ./rootfs
    # sudo busybox --install -s ./rootfs
    sudo make ARCH=$DEFAULT_ARCH CROSS_COMPILE=$DEFAULT_CROSS_COMPILE LDFLAGS=--static install CONFIG_PREFIX=./rootfs/
    ls ./rootfs

    sudo mkdir -p ./rootfs/proc ./rootfs/sys ./rootfs/dev
    sudo mkdir -p ./rootfs/etc
    sudo touch ./rootfs/etc/fstab

    sudo mkdir -p ./rootfs/etc/init.d
    sudo cp ./MyBuild_initrd.sh ./rootfs/etc/init.d/rcS
    sudo chmod a+x ./rootfs/etc/init.d/rcS

    ls ./rootfs
    
    sudo umount rootfs
}

rm root_hd_img
make_rootfs_with_busybox root_hd_img 1M 1024
cp ./root_hd_img ../linux/root_hd_img

