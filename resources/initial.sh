#!/bin/bash

set -e

# preparing the hdd
parted -m -s /dev/sda mklabel gpt
parted -m -s /dev/sda mkpart ESP fat32 1MiB 513MiB
parted -m -s /dev/sda set 1 boot on
parted -m -s /dev/sda mkpart primary linux-swap 513MiB 16GiB
parted -m -s /dev/sda mkpart primary ext4 16GiB 100%

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

parted -s /dev/sda print

# mounting the folders
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir -p /mnt/boot/loader/entries

# prepare ansible
pacman --noconfirm -Syy
pacman --noconfirm -S ansible

# install the base system
pacstrap /mnt base base-devel python sudo bash-completion mesa gnome networkmanager
genfstab -U -p /mnt >> /mnt/etc/fstab
