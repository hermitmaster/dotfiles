# dotfiles

## Setup

```sh
cd ~/.config/
git init
git remote add origin git@github.com:hermitmaster/dotfiles.git
git fetch --all
git reset origin/master --hard
git branch --set-upstream-to=origin/master master
source ${HOME}/.config/functions.sh
bootstrap
```
