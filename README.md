# dotfiles

```bash
export XDG_CONFIG_HOME="${HOME}/.config"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
mv "${XDG_CONFIG_HOME}" /tmp/.config.bak > /dev/null
git clone git@github.com:hermitmaster/dotfiles.git "${XDG_CONFIG_HOME}"
test -L "${HOME}/.zshrc" || ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"
. "${XDG_CONFIG_HOME}/.zshrc" && _bs
```
