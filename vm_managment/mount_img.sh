#!/bin/bash

function setup {

	sudo -v

	#img_path="/var/lib/libvirt/images/gentoo_base-clone-1.img"
	mnt_point="/media/$(basename $1)"

	#This is taken from the output of fdisk in the img file in sectors.
	if [ -z "$2" ]
	then
		echo "No offset given, using default 2048."
		offset=2048
	else
		echo "Using offset $2."
		offset=$2
	fi
}

if [ -z "$2" ]
then
	echo "No img file specified."
	exit
fi

if [ "$1" == "mount" ]
then
	echo "mounting..."
	setup $2 $3

	sudo mkdir -p $mnt_point
	sudo mount -o loop,offset=$(($offset * 512)) $2 $mnt_point

elif [ "$1" == "umount" ]
then
	echo "umount"
	setup $2
	
	sudo umount $mnt_point 
	sudo rmdir $mnt_point
else
	echo "Unknown option, specify either mount or umount."
fi
