#!/usr/bin/bash

echo '
# Allow kitty to be controlled by kitty-scrollback.nvim
allow_remote_control socket-only
shell_integration enabled
listen_on unix:@kitty
' >> $PWD/kitty/.config/kitty/kitty.conf
echo -e '\n ------------COPY AND PASTE THE FOLLOWING INTO YOUR kitty.conf--------------------'
nvim --headless +'KittyScrollbackGenerateKittens'
echo -e '\n ---------------------------------------------------------------------------------'
echo -e 'Done ! finally, Completely close and reopen Kitty and check the health of kitty-scrollback.nvim\n'
