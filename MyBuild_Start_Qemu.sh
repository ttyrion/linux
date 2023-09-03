#! /bin/bash

# qemu-system-arm \
#     -M vexpress-a9 \
#     -m 512M \
#     -kernel ./arch/arm/boot/zImage \
#     -drive if=none,file=root_hd_img,id=hd0 \
#     -device virtio-blk-device,drive=hd0 \
#     -append “console=ttyAMA0” \
#     #-dtb ./vexpress-v2p-ca9.dtb

qemu-system-arm \
    -M vexpress-a9 \
    -m 512M \
    -kernel ./arch/arm/boot/zImage \
    -sd root_hd_img \
    -append "root=/dev/mmcblk0 rw console=ttyAMA0" \
    -nographic
    # -dtb  ./linux-4.14.212/arch/arm/boot/dts/vexpress-v2p-ca9.dtb
    # 
    