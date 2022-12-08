#!/bin/bash -e

install -m 744 files/start.sh "${ROOTFS_DIR}/boot/"
crontab -l | sed 's/$/\n@reboot /usr/local/sbin/start.sh ' | crontab -