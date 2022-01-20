export XDG_CONFIG_HOME="${HOME}/.config"
export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/.Brewfile"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PAGER=most
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"

alias bb='brew bundle install --cleanup'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install
test -f "${HOME}/.zshenv" || echo "SHELL_SESSIONS_DISABLE=1" >"${HOME}/.zshenv"

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fpath+="/opt/homebrew/share/zsh/site-functions"

autoload -Uz compinit promptinit &&
  compinit -d "${HOME}/.zcompdump" &&
  promptinit

zstyle :prompt:pure:prompt:success color green

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

if [[ -z $TMUX && -z $VIM && -z $INTELLIJ_ENVIRONMENT_READER && "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
  tmux attach 2>/dev/null || exec tmux
fi