#!/bin/bash
#Spin in a loop looking for a specific media 
#device, then decrypt and mount it.

uuid="00000000-0000-0000-0000-000000000000"
label="my-hdd"
mount_point="/mnt"

#Root please.
sudo -v

while :
do
	#Figure out which /dev/ device the desired media is.
	enc_root=$(sudo blkid | sed -n "/$uuid/s/\(\/dev\/sd[a-z][0-9]\).*/\1/p")
	
	if [ -z $enc_root ]
	then

		#Keep trying until we see it.
		echo "Could not detect harddrive, retying..."
		sleep 1
		continue

	fi

	#Decrypt and mount.
	sudo cryptsetup luksOpen $enc_root $label
	sudo mount /dev/mapper/$label $mount_point
	exit
done
