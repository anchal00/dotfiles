#!/usr/bin/bash

set -e  # Exit if any command returns non-zero exit code

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

echo "Setting up the environment...... "

# Update index and upgrade packages
apt-get update && apt-get upgrade -y

# Install commonly used tools 
apt-get install -y apt-utils curl lsb-release dpkg wget tcpdump net-tools openssl build-essential cmake software-properties-common gnupg 

echo "Updated package index and upgraded installed packages!"

# Install Apps and utilities
ret = $(./install.sh)
if [[ $ret -ne 0]]; then
  echo "Apps/Utilities installed successfully!"
fi

echo "Setup complete !!"
