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
    wget
    zlib
    zsh-completions
)
cask=(
    barrier
    firefox
    gitkraken
    kitty
    sublime-text
    vlc
    vscodium
    webex
    font-fira-code-nerd-font
) #GUI apps that install with cask

npm=(
    neovim
)

brew update
brew upgrade

brew tap homebrew/cask-fonts
brew install ${brew[@]} #Homebrew App Installer
brew install --cask ${cask[@]} #Casks Installer
npm install ${npm[@]} #Install npm apps
