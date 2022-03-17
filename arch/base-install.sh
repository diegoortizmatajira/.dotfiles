#!/bin/bash
pacman -Syu --needed git base-devel
pacman -S xorg
# Installs yay package helper for AUR
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

