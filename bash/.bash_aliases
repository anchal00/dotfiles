alias tmx="tmux -u -f ~/.config/tmux/tmux.conf"
alias fx="history -p \!\! | xargs -r sudo"
alias e="nvim"

alias start="sudo systemctl start"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"

alias drun="docker run"
alias dstop="docker stop"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias di="docker images"
alias dpurge="docker images --filter 'dangling=true' -q --no-trunc | xargs -r docker rmi"
alias dcpurge="docker ps -a | awk '{if (NR >=2) print $1}' | xargs -I {} docker rm -f {}"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -la'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tmux="tmux -u -f ~/.config/tmux/tmux.conf"

# Disable or Enable mouse
alias nomouse='xinput set-prop 12 "Device Enabled" 0'
alias mouse='xinput set-prop 12 "Device Enabled" 1'

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color
# Go path
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
# Cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH

# Function to get current Git branch
parse_git_branch() {
  git branch 2>/dev/null | grep \* | sed 's/* //'
}

# Set the PS1 prompt
PS1='\[\e[0;32m\]\u\[\e[0m\]:\[\e[0;34m\]\w\[\e[0;33m\] $(parse_git_branch)\[\e[0m\]\$ '

eval "$(pyenv init -)"
