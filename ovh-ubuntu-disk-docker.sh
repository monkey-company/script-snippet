#!/bin/bash

#automate fdisk
function fadisk {
  (
  echo n # Add a new partition
  echo   # default next part
  echo   # First sector
  echo   # Last sector
  echo w # Write changes
  ) | sudo fdisk /dev/$1 #select disk
}

#new partitions
fadisk sda && fadisk sdb && fadisk sdc && fadisk sdd

#format partitions ext4
mkfs.ext4 /dev/sda5 && mkfs.ext4 /dev/sdb2 && mkfs.ext4 /dev/sdc2 && mkfs.ext4 /dev/sdd2

#add in fstab
echo '/dev/sda5       /mnt/sda5       ext4    defaults        0       0' >> /etc/fstab
echo '/dev/sdb2       /mnt/sdb2       ext4    defaults        0       0' >> /etc/fstab
echo '/dev/sdc2       /mnt/sdc2       ext4    defaults        0       0' >> /etc/fstab
echo '/dev/sdd2       /mnt/sdd2       ext4    defaults        0       0' >> /etc/fstab

#mount partitions
mkdir /mnt/sda5 /mnt/sdb2 /mnt/sdc2 /mnt/sdd2
mount -a

#auto install docker
sudo apt-get update && sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo apt-key fingerprint 0EBFCD88 && sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y
