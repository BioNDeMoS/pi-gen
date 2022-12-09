#!/bin/bash -e

on_chroot <<EOF
git clone https://github.com/azlux/log2ram.git
./log2ram/install.sh
rm -rf ./log2ram/

sed -r 's/(SIZE*=).*/\1100M/' /etc/log2ram.conf > /etc/log2ram.conf
sed -r 's/(ZL2R*=).*/\1true/' /etc/log2ram.conf > /etc/log2ram.conf
EOF