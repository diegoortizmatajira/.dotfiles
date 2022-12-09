#!/usr/bin/env bash
#<----------------Installing Linux Apps via pacman/yay-------------------->

base_desktop_environment=(
# boot
#    grub
#    grub-customizer
#    update-grub
# shell
    zsh
    zsh-completions
    lsd
# Themes
    mcmojave-circle-icon-theme
# file management
    ntfs-3g
    nautilus
    nautilus-sendto
    file
    file-roller
    filesystem
    findutils
    goto
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
    mage
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
    qt5ct
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
    sublime-text-4
    tesseract
    the_silver_searcher
    tmux
    tor-browser
    tree-sitter
    visual-studio-code-bin
    vlc
    xclip
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

yay -S ${base_desktop_environment[@]} --needed
yay -S ${package_list[@]} --needed 

sudo npm install -g ${npm[@]} #Install npm apps
