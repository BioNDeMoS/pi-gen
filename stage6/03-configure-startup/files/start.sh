#!/bin/bash -e

cp /config/autossh/id_ed25519.pub /data/autossh/id_ed25519.pub

# The URL of the Git repository
repo_url="https://github.com/BioNDeMoS/config.git"

# The directory where the repository will be cloned
target_dir="/config"

# Clone the repository
if [ ! -d "$target_dir" ]; then
  # Clone the repository if the target directory does not exist
  git clone "$repo_url" "$target_dir"
else
  # Pull the latest changes from the repository if the target directory exists
  cd "$target_dir"
  git pull
fi

chown -R 1000:1000 /config/node-red

cd /config/docker
docker compose up -d --build --pull always