#!/bin/sh

set -e

# install
pacman --noconfirm -r /mnt -U /tmp/cntlm-x86_64.pkg.tar.xz

# configure template
(cat <<END
Username        PROXY_USERNAME
Domain          PROXY_DOMAIN
Workstation     PROXY_WORKSTATION

Proxy           PROXY_HOST
NoProxy         NO_PROXY
Listen          127.0.0.1:3128

Auth            NTLMv2
Password        PROXY_PASSWORD
PROXY_HASHES
END
) > /mnt/etc/cntlm.conf
