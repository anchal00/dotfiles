#!/usr/bin/bash

set -e

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

# Add git repo to package manager
add-apt-repository -y ppa:git-core/ppa > /dev/null
apt-get update -y > /dev/null && apt-get install git -y > /dev/null

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
install -m 0755 -d /etc/apt/keyrings > /dev/null


install_neovim() {
  echo "Installing Neovim..."
  apt-get install neovim -y > /dev/null
}

install_docker() {
  echo "Installing Docker..."
  apt-get install ca-certificates curl > /dev/null
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    >> /etc/apt/sources.list.d/docker.list 
  apt-get update > /dev/null
  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null
}

install_stow() {
  echo "Installing GNU stow..."
  apt-get install stow -y > /dev/null
}

install_tldr() {
  # Install Cargo first
  echo "Installing Cargo..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y > /dev/null
  echo "Installing Tldr..."
  export PATH="$HOME/.cargo/bin:$PATH"
  cargo install tealdeer > /dev/null
  source "$HOME/.cargo/env"
}

install_firefox() {
  echo "Installing Firefox..."
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- > /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
  gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | \
  awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" >>  /etc/apt/sources.list.d/mozilla.list
  echo '
  Package: *
  Pin: origin packages.mozilla.org
  Pin-Priority: 1000
  ' > tee /etc/apt/preferences.d/mozilla > /dev/null
  apt-get update > /dev/null && apt-get install firefox -y > /dev/null 
}

install_pyenv() {
  echo "Installing Pyenv..."
  curl -sSf https://pyenv.run | bash > /dev/null
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
}

install_golang() {
  echo "Installing Golang..."
}

install_tmux() {
  echo "Installing tmux..."
  apt install tmux -y > /dev/null
}

install_kitty() {
  echo "Installing kitty..."
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin > /dev/null
  echo "Visit 'https://sw.kovidgoyal.net/kitty/binary/#desktop-integration-on-linux' for details on desktop integration\n"
}

for app in "${!install_list[@]}"; do
  ${install_list[$app]}
done
