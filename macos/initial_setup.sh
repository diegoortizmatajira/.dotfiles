#!/usr/bin/env bash
#<----------------Installing MacOS Apps, via Homebrew, Cask-------------------->
brew=(
    curl
    fzf
    git
    git-flow
    glibc
    gcc
    go
    grep
    gzip
    htop
    lazygit
    less
    lsd
    lua
    luajit
    make
    neofetch
    neovide
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
    unrar
    wget
    zlib
    zsh-completions
)
cask=(
    alfred
    barrier
    firefox
    gitkraken
    kitty
    nordvpn
    sublime-text
    vlc
    vscodium
    webex
) #GUI apps that install with cask
npm=(
    neovim
)

brew update
brew upgrade

brew install ${brew[@]} #Homebrew App Installer
brew cask install ${cask[@]} #Casks Installer
npm install ${npm[@]} #Install npm apps
