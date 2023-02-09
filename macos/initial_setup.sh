#!/usr/bin/env bash
#<----------------Installing MacOS Apps, via Homebrew, Cask-------------------->
brew=(
    autojump
    cmake
    curl
    fzf
    gcc
    git
    git-flow
    glib
    go
    goto
    grep
    gzip
    helm
    htop
    k9s
    kubernetes-cli
    kubeval
    kustomize
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
    pyenv
    python@3.11
    ranger
    ripgrep
    speedtest-cli
    sqlite
    the_silver_searcher
    tmux
    tree-sitter
    watch
    wget
    zlib
    zsh-completions
)
cask=(
    adobe-acrobat-reader
    alt-tab
    amethyst
    barrier
    beyond-compare
    caffeine
    datagrip
    font-caskaydia-cove-nerd-font
    font-fira-code-nerd-font
    font-jetbrains-mono-nerd-font
    git-credential-manager-core
    gitkraken
    hazeover
    kitty
    microsoft-office
    rectangle
    sublime-text
    vlc
    vscodium
    yt-music
) #GUI apps that install with cask

npm=(
    neovim
)

brew update
brew upgrade

brew tap homebrew/cask-fonts
brew tap microsoft/git

brew install ${brew[@]} #Homebrew App Installer
brew install --cask ${cask[@]} #Casks Installer
npm install -g ${npm[@]} #Install npm apps
