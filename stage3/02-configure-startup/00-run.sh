#!/bin/bash -e

install -m 744 files/start.sh "${ROOTFS_DIR}/boot/"
on_chroot <<EOF
crontab -l | sed 's/$/\n@reboot sh -c "curl -o /usr/local/sbin/start.sh https://raw.githubusercontent.com/BioNDeMoS/start/main/start.sh; chmod +x /usr/local/sbin/start.sh; /usr/local/sbin/start.sh' | crontab -
EOF