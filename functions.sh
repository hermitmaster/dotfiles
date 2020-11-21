#!/usr/bin/env sh

function install_brew() {
  curl -L "https://raw.githubusercontent.com/Homebrew/install/master/install.sh" | bash
}

function install_brew_packages() {
  brew install \
    ansible \
    ansible-lint \
    awscli \
    aws-iam-authenticator \
    diff-so-fancy \
    docker-compose \
    docker-credential-helper \
    exa \
    fish \
    gcc \
    gradle \
    helm \
    htop \
    jenv \
    jq \
    libxdg-basedir \
    maven \
    neovim \
    npm \
    openconnect \
    openjdk \
    openjdk@8 \
    openjdk@11 \
    prettier \
    python \
    ripgrep \
    rustup-init \
    terraform \
    terraform-ls \
    tmux \
    wget

  brew cask install \
    docker \
    homebrew/cask-fonts/font-hack \
    homebrew/cask-fonts/font-hack-nerd-font \
    openconnect-gui
}

function install_npm_packages() {
  npm i -g @vue/cli
}

function setup_neovim() {
  git clone https://github.com/kristijanhusak/vim-packager.git ${HOME}/.local/share/nvim/site/pack/packager/opt/vim-packager &>/dev/null \
    && nvim --headless +"call PackagerInit() | call packager#install({ 'on_finish': 'quitall' })"
}

function install_terminal_theme() {
  echo -e "\n Installing srcery terminal theme!"
  open ./mac_terminal/themes/srcery.terminal
}

function bootstrap() {
  echo "Bootstrapping machine!"
  install_brew
  install_brew_packages
  jenv enable-plugin export
  rustup toolchain install stable
  setup_neovim
}
