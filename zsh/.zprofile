
if [ -f ~/.zshrc ]; then source ~/.zshrc; fi

if [ -f ~/.zsh_aliases ]; then source ~/.zsh_aliases; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

