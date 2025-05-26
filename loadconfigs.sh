#!/usr/bin/bash

STOW_DIRS="tmux nvim kitty zsh"

for x in $STOW_DIRS; do
    echo "Stowing $x"
    stow $x;
done

