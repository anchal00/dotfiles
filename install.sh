#!/usr/bin/bash

set -e

declare -A install_list=(
    [neovim]="install_neovim"
    [docker]="install_docker"
    [tldr]="install_tldr"
    [stow]="install_stow"
    [golang]="install_golang"
    [firefox]="install_firefox"
    [pyenv]="install_pyenv"
    [tmux]="install_tmux"
    [kitty]="install_kitty"
)

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

# Add git repo to package manager
add-apt-repository -y ppa:git-core/ppa > /dev/null
apt-get update -y > /dev/null && apt-get install git -y > /dev/null

# Create a directory to store APT repository keys if it doesn't exist
install -m 0755 -d /etc/apt/keyrings > /dev/null

install_neovim() {
  echo "Installing Neovim..."
  apt-get install neovim -y
}

install_docker() {
  echo "Installing Docker..."
  apt-get install ca-certificates curl > /dev/null
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable"\
    | tee /etc/apt/sources.list.d/docker.list
  apt-get update > /dev/null
  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

install_stow() {
  echo "Installing GNU stow..."
  apt-get install stow -y
}

install_tldr() {
  # Install Cargo first
  echo "Installing Cargo..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y > /dev/null
  echo "Installing Tldr..."
  export PATH="$HOME/.cargo/bin:$PATH"
  $HOME/.cargo/bin/cargo install tealdeer
  source "$HOME/.cargo/env"
}

install_firefox() {
  echo "Installing Firefox..."
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc
  gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | \
  awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee /etc/apt/sources.list.d/mozilla.list
  echo '
  Package: *
  Pin: origin packages.mozilla.org
  Pin-Priority: 1000
  ' | tee /etc/apt/preferences.d/mozilla
  apt-get update > /dev/null && apt-get install firefox -y
}

install_pyenv() {
  echo "Installing Pyenv..."
  curl -sSf https://pyenv.run | bash
}

install_golang() {
  echo "Installing Golang..."
  GO_TAR='go1.23.4.linux-amd64.tar.gz'
  curl -sSfL -O https://go.dev/dl/$GO_TAR
  tar -xzf $GO_TAR
  rm $GO_TAR
}

install_tmux() {
  echo "Installing tmux..."
  apt install tmux -y
}

install_kitty() {
  echo "Installing kitty..."
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/usr/bin/
  update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 200

  # Set kitty as default terminal
  update-alternatives --config x-terminal-emulator
  echo -e "Visit 'https://sw.kovidgoyal.net/kitty/binary/#desktop-integration-on-linux' for details on desktop integration\n"
  # Install kitty-scrollback.nvim
  chmod +x kitty-scrollback-setup.sh
  ./kitty-scrollback-setup.sh
}

for app in "${!install_list[@]}"; do
  ${install_list[$app]}
done
