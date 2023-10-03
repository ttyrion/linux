#! /bin/bash

img_file=root_hd_img
tmp_dir=./rootfs_tmp
mkdir -p $tmp_dir
sudo mount $img_file $tmp_dir

ls $tmp_dir
sudo umount $tmp_dir
sudo rm -r $tmp_dir