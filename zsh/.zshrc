eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init -)"

setopt interactivecomments

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
