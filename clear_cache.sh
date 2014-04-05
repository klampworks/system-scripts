#!/bin/bash
#Clear in memory caches of otherwise persistant or uneeded data.
#http://www.linuxinsight.com/proc_sys_vm_drop_caches.html
#
sudo -v
sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
