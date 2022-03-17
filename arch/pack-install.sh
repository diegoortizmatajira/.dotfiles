#!/bin/bash

# Add sublime text editor source
curl -O https://download.sublimetet.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpgx
echo -e "\n[sublime-text]\nerver = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.confS

yay -S $(cat packages.list)
