#!/bin/bash
#umount and close an encypted volume in 1 command.

mount_point="/mnt"
label="my-hdd"

sudo umount $mount_point
sudo cryptsetup luksClose $label
