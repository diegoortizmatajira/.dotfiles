#!/usr/bin/env bash
#<----------------Installing MacOS Apps, via Homebrew, Cask-------------------->
brew=(
    cmake
    curl
    docker
    fzf
    gcc
    git
    git-flow
    go
    goto
    grep
    gzip
    htop
    kubectl
    lazygit
    less
    lsd
    lua
    luajit
    luarocks
    make
    neofetch
    neovim
    node
    openssl@1.1
    perl
    python@3.10
    ranger
    ripgrep
    speedtest-cli
    the_silver_searcher
    tmux
    tree-sitter
    wget
    zlib
    zsh-completions
)
cask=(
    barrier
    font-fira-code-nerd-font
    font-caskaydia-cove-nerd-font
    font-jetbrains-mono-nerd-font
    gitkraken
    hazeover
    rectangle
    sublime-text
    vlc
    yt-music
) #GUI apps that install with cask

npm=(
    neovim
)

brew update
brew upgrade

brew tap homebrew/cask-fonts
brew install ${brew[@]} #Homebrew App Installer
brew install --cask ${cask[@]} #Casks Installer
npm install -g ${npm[@]} #Install npm apps
