
alias tmx="tmux -u -f ~/.config/tmux/tmux.conf"
alias fx="sudo $(history -p \!\!)"
alias e="nvim ."

alias start="sudo systemctl start"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"

alias drun="docker run"
alias dstop="docker stop"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias di="docker images"
alias dpurge="docker rmi $(docker images --filter "dangling=true" -q --no-trunc)"
alias dcpurge="docker ps -a | awk '{if (NR >=2) print $1}' | xargs -I {} docker rm -f {}"

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Go path
export PATH=$PATH:/usr/local/go/bin
# Cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
