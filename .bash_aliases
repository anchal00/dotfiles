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

