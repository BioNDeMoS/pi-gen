#!/bin/bash -e

# Apply config file
config_file="/data/config.conf"

# Set password of biondemos user
hashed_password=$(grep hashed_password $config_file | cut -d '=' -f2)
if [ -n "$hashed_password" ]; then
  echo biondemos:$hashed_password | sudo chpasswd -e
fi

if [ -f /config/autossh/id_ed25519 ]; then
  ssh-keygen -N "" -f /config/autossh/id_ed25519 -t ed25519 -C "rpi_$(grep -i serial /proc/cpuinfo | cut -d : -f2 | cut -c10-)" <<<y
fi
cp /config/autossh/id_ed25519.pub /data/autossh/id_ed25519.pub


# Clone the config repository
repo_url=$(grep repo_url $config_file | cut -d '=' -f2)
target_dir="/config"
if [ ! -d "$target_dir" ]; then
  # Clone the repository if the target directory does not exist
  git clone "$repo_url" "$target_dir"
else
  # Pull the latest changes from the repository if the target directory exists
  cd "$target_dir"
  git pull --rebase
fi

chown -R 1000:1000 /config/node-red

# Start docker containers
cd /config/docker
docker compose up -d --build --pull always