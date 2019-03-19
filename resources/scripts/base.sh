#!/bin/bash

set -e

# prepare ansible
pacman --noconfirm -Syy
pacman --noconfirm -S ansible

# install the base system
pacstrap /mnt base base-devel sudo bash-completion mesa gnome networkmanager wget ansible
genfstab -U -p /mnt >> /mnt/etc/fstab
bootctl --path=/mnt/boot install || true # modifies the OVMF image
