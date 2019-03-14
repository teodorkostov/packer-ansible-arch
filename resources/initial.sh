#!/bin/bash

set -e

DEVICE=/dev/sda

# preparing the hdd
parted -m -s "${DEVICE}" mklabel gpt
parted -m -s "${DEVICE}" mkpart ESP fat32 1MiB 513MiB
parted -m -s "${DEVICE}" set 1 boot on
parted -m -s "${DEVICE}" mkpart primary linux-swap 513MiB 16GiB
parted -m -s "${DEVICE}" mkpart primary ext4 16GiB 100%
parted -m -s "${DEVICE}" name 3 'os'
sleep 1

mkfs.fat -F32 "${DEVICE}1"
mkswap "${DEVICE}2"
swapon "${DEVICE}2"
mkfs.ext4 "${DEVICE}3"

parted -s "${DEVICE}" print

# mounting the folders
mount "${DEVICE}3" /mnt
mkdir /mnt/boot
mount "${DEVICE}1" /mnt/boot
mkdir -p /mnt/boot/loader/entries

# prepare ansible
pacman --noconfirm -Syy
pacman --noconfirm -S ansible

# install the base system
pacstrap /mnt base base-devel python sudo bash-completion mesa gnome networkmanager
genfstab -U -p /mnt >> /mnt/etc/fstab
bootctl --path=/mnt/boot install || true # modifies the OVMF image
