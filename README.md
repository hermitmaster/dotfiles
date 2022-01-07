# dotfiles

```bash
export XDG_CONFIG_HOME="${HOME}/.config"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
mv "${XDG_CONFIG_HOME}" /tmp/.config.bak > /dev/null
git clone git@github.com:hermitmaster/dotfiles.git "${XDG_CONFIG_HOME}"
brew bundle install --file "${XDG_CONFIG_HOME}/.Brewfile"
```
