#!/usr/bin/bash

set -e

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

# Add git repo to package manager
add-apt-repository -y ppa:git-core/ppa
apt-get update -y && apt-get install git -y

declare -A install_list

install_list["neovim"]="install_neovim" 
install_list["docker"]="install_docker"
install_list["tldr"]="install_tldr"
install_list["stow"]="install_stow" 
install_list["firefox"]="install_firefox"
install_list["pyenv"]="install_pyenv"
install_list["tmux"]="install_tmux"
install_list["kitty"]="install_kitty"

# Create a directory to store APT repository keys if it doesn't exist
install -m 0755 -d /etc/apt/keyrings


install_neovim() {
  echo "Installing Neovim..."
  apt-get install neovim -y
}

install_docker() {
  echo "Installing Docker..."
  apt-get install ca-certificates curl
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list
  apt-get update
  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

install_stow() {
  echo "Installing GNU stow..."
}

install_tldr() {
  # Install Cargo first
  echo "Installing Cargo..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  echo "Installing Tldr..."
  export PATH="$HOME/.cargo/bin:$PATH"
  cargo install tealdeer
  source "$HOME/.cargo/env"
}

install_firefox() {
  echo "Installing Firefox..."
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
  gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | \
  awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
  echo '
  Package: *
  Pin: origin packages.mozilla.org
  Pin-Priority: 1000
  ' | tee /etc/apt/preferences.d/mozilla
  apt-get update && apt-get install firefox -y
}

install_pyenv() {
  echo "Installing Pyenv..."
  curl https://pyenv.run | bash
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  source ~/.bashrc
}

install_golang() {
  echo "Installing Golang..."
}

install_tmux() {
  echo "Installing tmux..."
}

install_kitty() {
  echo "Installing kitty..."
}

for app in "${!install_list[@]}"; do
  ${install_list[$app]}
done
