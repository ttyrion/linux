#! /bin/bash

#Doc: http://www.kaizou.org/2016/09/boot-minimal-linux-qemu.html

# start with initrd(initramdisk)
function start_with_initrd {
qemu-system-arm \
    -M vexpress-a9 \
    -m 512M \
    -kernel ./arch/arm/boot/zImage \
    -sd root_hd_img \
    -append "initcall_debug root=/dev/mmcblk0 rw console=ttyAMA0" \
    -nographic
    # -dtb  ./linux-4.14.212/arch/arm/boot/dts/vexpress-v2p-ca9.dtb
    # 
}

# start with initrd(initramdisk)
function start_with_initramfs {
qemu-system-arm \
    -M vexpress-a9 \
    -m 512M \
    -kernel ./arch/arm/boot/zImage \
    -hda root_hd_img \
    -append "initcall_debug  root=/dev/sda rw console=ttyAMA0" \
    -nographic
    # -dtb  ./linux-4.14.212/arch/arm/boot/dts/vexpress-v2p-ca9.dtb
    # 
}

# if [[ $1 == "initrd" ]]  # initial root fs (image)
# then
#     start_with_initrd
# elif [ $1 == "initramfs" ] # initramfs build into kernel
# then
#     start_with_initramfs 
# else
#     echo "wrong parameters"
# fi

qemu-system-arm \
    -M vexpress-a9 \
    -cpu cortex-a9 \
    -m 512M \
    -kernel ./arch/arm/boot/zImage \
    -dtb ./arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
    -initrd ../busybox-1.26.2/initramfs/initramfs.igz \
    -append "initcall_debug init=/init console=ttyAMA0 rw" \
    -nographic
    # -dtb  ./linux-4.14.212/arch/arm/boot/dts/vexpress-v2p-ca9.dtb
    # 