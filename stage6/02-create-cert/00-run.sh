#!/bin/bash -e

ssh-keygen -N "" -f /config/autossh/id_ed25519 -t ed25519 -C "rpi_$(grep -i serial /proc/cpuinfo | cut -d : -f2 | cut -c10-)" <<<y