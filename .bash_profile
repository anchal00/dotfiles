
alias tmx="tmux -u -f ~/.config/tmux/tmux.conf"
alias fx="sudo $(history -p \!\!)"

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
