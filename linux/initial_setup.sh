#!/usr/bin/env bash
#<----------------Installing Linux Apps via pacman/yay-------------------->

base_desktop_environment=(
# boot
    grub
    grub-customizer
    update-grub
# shell
    zsh
    zsh-completions
    lsd
# xfce4
    exo
    garcon
    xfce4-power-manager
    xfce4-session
    xfce4-settings
    xfconf
    xfce4-clipman-plugin
    xfce4-battery-plugin
    xfce4-datetime-plugin
    xfce4-mpc-plugin
    xfce4-notifyd
    xfce4-taskmanager
# tiling window manager
    picom-git
    awesome
    ocs-url
    rofi
    rofi-dmenu
# Themes
    mcmojave-circle-icon-theme
# bluetooth
    blueman
    bluez-plugins
    bluez-utils
# audio
    alsa-utils
    pulseaudio-alsa
    pulseaudio-bluetooth
    playerctl
# network
    network-manager-applet
    networkmanager
    wireguard-tools
    wireless_tools
# power management
    acpi
    tlp
    tlp-rdw
# file management
    ntfs-3g
    nautilus
    nautilus-sendto
    file
    file-roller
    filesystem
    findutils
# fonts
    apple-fonts
    nerd-fonts-fira-code 
    nerd-fonts-jetbrains-mono
    ttf-fira-code
    ttf-font-awesome
    ttf-jetbrains-mono
    ttf-mac-fonts
    ttf-ms-fonts
    ttf-symbola
    ttf-unifont
)

package_list=(
    arandr
    aspnet-runtime
    barrier
    bootiso
    calibre
    clipmenu
    cmake
    ctags
    deluge-gtk
    docker
    docker-compose
    dotnet-runtime
    dotnet-sdk
    evince
    feh
    firefox-developer-edition
    flameshot
    fzf
    gcc-libs
    gimp
    git
    git-credential-manager-bin
    gitflow-avh
    gitkraken
    glibc
    go
    google-chrome
    gnome-calculator
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    goto
    gparted
    gphoto2
    grep
    hdrmerge
    helm
    htop
    hugin
    hugo
    hwdetect
    inetutils
    inkscape
    iputils
    jre
    kitty
    kubectl
    lazygit
    less
    libreoffice-fresh
    luarocks
    luminancehdr
    mage-bin
    make
    masterpdfeditor
    neofetch
    neovide
    neovim
    ngrok
    ninja
    nodejs-lts-gallium
    nordvpn-bin
    npm
    onedrive-abraunegg
    os-prober
    parted
    perl
    plex-media-server
    postman-bin
    protobuf
    protoc-gen-grpc-web
    python-pip
    python-sphinx
    ranger
    rapid-photo-downloader
    rawtherapee
    rider
    ripgrep
    rsync
    screenkey
    sed
    skypeforlinux-stable-bin
    solaar
    speedtest-cli
    stremio
    stress
    sublime-text
    tesseract
    the_silver_searcher
    tmux
    tor-browser
    tree-sitter
    visual-studio-code-bin
    vlc
    wmctrl
    youtube-music-bin
    zsa-wally
)

npm=(
    neovim
)
    
# Installs yay if required

if ! [ -x "$(command -v yay)" ]; then
    echo 'Installing Yay' >&2
    pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
fi

yay -Syu --needed --noconfirm

yay -S ${base_desktop_environment[@]} --needed --noconfirm
yay -S ${package_list[@]} --needed --noconfirm

sudo npm install -g ${npm[@]} #Install npm apps
