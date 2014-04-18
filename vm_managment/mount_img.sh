#!/bin/bash

function setup {

	sudo -v

	#img_path="/var/lib/libvirt/images/gentoo_base-clone-1.img"
	mnt_point="/media/$(basename $1)"

	#This is taken from the output of fdisk in the img file in sectors.
	offset=2048
}

if [ -z "$2" ]
then
	echo "No img file specified."
	exit
fi

if [ "$1" == "mount" ]
then
	echo "mounting..."
	setup $2

	sudo mkdir -p $mnt_point
	sudo mount -o loop,offset=$(($offset * 512)) $img_path $mnt_point

elif [ "$1" == "umount" ]
then
	echo "umount"
	setup $2
	
	sudo umount $mnt_point 
	rmdir $mnt_point
else
	echo "Unknown option, specify either mount or umount."
fi
