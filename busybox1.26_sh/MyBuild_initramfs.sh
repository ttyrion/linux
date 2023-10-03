#! /bin/bash

sudo rm -r ./initramfs
mkdir -pv ./initramfs/arm-busybox
cd ./initramfs/arm-busybox
mkdir -pv {bin,dev,sbin,etc,proc,sys/kernel/debug,usr/{bin,sbin},lib,lib64,mnt/root,root}
cp -av ../../_install/* ./
sudo cp -av /dev/{null,console,tty} ./dev/

cp ../../MyBuild_init.sh ./init
chmod a+x init

#create initramfs
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
cat initramfs.cpio | gzip > initramfs.igz

