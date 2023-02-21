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
# Themes
    mcmojave-circle-icon-theme
# file management
    ntfs-3g
    findutils
    goto
    autojump
# fonts
    apple-fonts
    ttf-firacode-nerd
    ttf-fira-code
    ttf-font-awesome
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    ttf-mac-fonts
    ttf-ms-fonts
    ttf-symbola
    ttf-unifont
)

package_list=(
    aspnet-runtime
    barrier
    bootiso
    calibre
    cmake
    ctags
    deluge-gtk
    docker
    docker-compose
    dotnet-runtime
    dotnet-sdk
    firefox
    flameshot
    fzf
    gcc-libs
    gimp
    git
    git-credential-manager-core-bin
    gitflow-avh
    gitkraken
    glibc
    go
    google-chrome
    goto
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
    the_silver_searcher
    tmux
    tor-browser
    tree-sitter
    visual-studio-code-bin
    vlc
    xclip
    youtube-music-bin
    zsa-wally
)

gaming_package_list=(
    sc-controller
    lutris
    steam
    bottles
    heroic-games-launcher
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
yay -S ${gaming_package_list[@]} --needed 

sudo npm install -g ${npm[@]} #Install npm apps
