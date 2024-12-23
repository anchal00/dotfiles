#!/usr/bin/bash

echo '
# Allow kitty to be controlled by kitty-scrollback.nvim
allow_remote_control socket-only
shell_integration enabled
listen_on unix:@kitty
' >> $PWD/kitty/.config/kitty/kitty.conf

nvim --headless +'KittyScrollbackGenerateKittens' 2>> $PWD/kitty/.config/kitty/kitty.conf
# tr -d '\r' < $PWD/kitty/.config/kitty/kitty.conf > $PWD/kitty/.config/kitty/kitty.conf

echo -e '\nDone ! As a final setup, completely close and reopen Kitty and check the health of kitty-scrollback.nvim\n'
