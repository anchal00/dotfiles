#!/usr/bin/bash

set -e  # Exit if any command returns non-zero exit code

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

echo "Setting up the environment...... "

# Update index and upgrade packages
apt update && apt upgrade -y
apt install build-essential -y
echo "Updated package index and upgraded installed packages!"

# Instal wget and cURL
apt install wget -y && apt install curl -y

# Install Apps and utilities
ret = $(./install.sh)
if [[ $ret -ne 0]]; then
  echo "Apps/Utilities installed successfully!"
fi

echo "Setup complete !!"
