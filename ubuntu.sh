#!/usr/bin/bash

set -e  # Exit if any command returns non-zero exit code

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Must be run as root. Please use sudo."
  exit 1
fi

echo "---------------------------"
echo "Setting up the environment..."
echo -e "---------------------------\n"
# Update index and upgrade packages
echo -e "Updating apt index and upgrading packages..."
apt-get update > /dev/null && apt-get upgrade -y > /dev/null
echo -e "Success ! \n"

# Install commonly used tools 
echo "Installing tools..."
apt-get install -y apt-utils curl lsb-release dpkg wget tcpdump net-tools openssl build-essential cmake software-properties-common gnupg
echo -e "Success ! \n"

# Install Apps and utilities
echo "Installing Apps/Utilities..."
./install.sh
ret=$?
if [[ $ret -ne 0 ]]; then
  echo -e "Apps/Utilities installed successfully!\n"
fi

echo "---------------------------"
echo "Setup complete !! PLEASE EXECUTE 'source ~/.bashrc' IN YOUR CURRENT SHELL !"
echo "---------------------------"
