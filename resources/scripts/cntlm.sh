#!/bin/sh

set -e

# install
pacman --noconfirm -U /tmp/cntlm-x86_64.pkg.tar.xz

# configure
PROXY_HASHES=$(echo $PROXY_PASSWORD | cntlm -H -d ad -u $PROXY_USERNAME | tail -3)

(cat <<END
Username        $PROXY_USERNAME
Domain          $PROXY_DOMAIN
Workstation     $PROXY_WORKSTATION

Proxy           $PROXY_HOST
NoProxy         localhost, 127.0.0.1, 10.*, 192.168.*, *.intranet, *.local
Listen          127.0.0.1:3128

Auth            NTLMv2
Password        $PROXY_PASSWORD
$PROXY_HASHES
END
) > /etc/cntlm.conf

# run
systemctl start cntlm.service
