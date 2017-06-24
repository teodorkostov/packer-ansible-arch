#!/bin/bash

set -e

# preparing the hdd
parted -m -s /dev/vda mklabel gpt
parted -m -s /dev/vda mkpart ESP fat32 1MiB 513MiB
parted -m -s /dev/vda set 1 boot on
parted -m -s /dev/vda mkpart primary linux-swap 513MiB 16GiB
parted -m -s /dev/vda mkpart primary ext4 16GiB 100%
parted -m -s /dev/vda name 3 'os'
sleep 1

mkfs.fat -F32 /dev/vda1
mkswap /dev/vda2
swapon /dev/vda2
mkfs.ext4 /dev/vda3

parted -s /dev/vda print

# mounting the folders
mount /dev/vda3 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
mkdir -p /mnt/boot/loader/entries

# prepare ansible
pacman --noconfirm -Syy
pacman --noconfirm -S ansible

# install the base system
pacstrap /mnt base base-devel python sudo bash-completion mesa gnome networkmanager xf86-video-amdgpu xf86-video-fbdev
genfstab -U -p /mnt >> /mnt/etc/fstab
bootctl --path=/mnt/boot install || true # modifies the OVMF image
