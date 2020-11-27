# dotfiles

## Setup

```sh
cd ~
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
mv ~/.config ~/.config.bak
git clone --recurse-submodules -j8 git@github.com:hermitmaster/dotfiles.git ~/.config
brew bundle install --no-lock --file ~/.config/.Brewfile
pip3 install -r ~/.config/requirements.txt
open ./mac_terminal/themes/srcery.terminal
chsh -s $(which fish)
```
