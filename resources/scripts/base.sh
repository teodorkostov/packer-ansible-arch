#!/bin/bash

set -e

# add a preferred mirror
sed -i '1s@^@'"$PACMAN_MIRROR"'\n@' /etc/pacman.d/mirrorlist

# prepare ansible
pacman --noconfirm -Syy
pacman --noconfirm -S ansible

# install the base system
pacstrap /mnt base base-devel sudo bash-completion mesa gnome networkmanager wget ansible python-psutil
genfstab -U -p /mnt >> /mnt/etc/fstab
bootctl --path=/mnt/boot install || true # modifies the OVMF image
