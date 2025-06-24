#!/usr/bin/env bash
#<----------------Installing MacOS Apps, via Homebrew, Cask-------------------->

brew=(
    cmake
    curl
    docker
    docker-buildx
    docker-completion
    docker-compose
    docker-credential-helper
    eza
    fastfetch
    fd
    fzf
    gcc
    git
    git-flow
    git-lfs
    glib
    go
    grep
    gzip
    helm
    htop
    k9s
    kubernetes-cli
    lazydocker
    lazygit
    less
    lua
    luajit
    luarocks
    make
    mercurial
    neovim
    node
    nvm
    openjdk
    openssl@1.1
    openssl@3
    perl
    pngpaste
    pyenv
    python@3.13
    ripgrep
    sevenzip
    speedtest-cli
    sqlite
    the_silver_searcher
    tmux
    tree-sitter
    virtualenv
    watch
    wget
    yazi
    zlib
    zoxide
    zsh-completions
)
cask=(
    adobe-acrobat-reader
    beyond-compare
    caffeine
    dotnet-sdk
    font-caskaydia-cove-nerd-font
    font-fira-code-nerd-font
    font-jetbrains-mono-nerd-font
    ghostty
    git-credential-manager
    keepingyouawake
    rectangle
    sublime-text
    visual-studio-code
    vlc
    yt-music
    zoom
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
