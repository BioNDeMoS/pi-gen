#!/bin/bash -e

on_chroot <<EOF
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bullseye main" >> /etc/apt/sources.list.d/azlux.list
wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
apt-get update
apt-get install -y --no-install-recommends log2ram

sed -r 's/(SIZE*=).*/\1100M/' /etc/log2ram.conf > /etc/log2ram.conf
sed -r 's/(ZL2R*=).*/\1true/' /etc/log2ram.conf > /etc/log2ram.conf
EOF