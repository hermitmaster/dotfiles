export BAT_THEME="Monokai Extended"
export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE="${HOME}/.config/.Brewfile"
export LG_CONFIG_FILE="${HOME}/.config/lazygit.yml"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:${PATH}"

alias bb='brew bundle install --cleanup'
alias gs='lazygit'
alias ll='ls -Ahl'
alias tf='terraform'
alias tg='terragrunt'

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install

setopt hist_ignore_all_dups share_history
autoload -Uz compinit promptinit && compinit && promptinit

zstyle :prompt:pure:execution_time color 8
zstyle :prompt:pure:git:action color 9
zstyle :prompt:pure:git:branch color 2
zstyle :prompt:pure:git:dirty color magenta
zstyle :prompt:pure:host color 8
zstyle :prompt:pure:prompt:continuation color 8
zstyle :prompt:pure:prompt:success color 2
zstyle :prompt:pure:user color 8
zstyle :prompt:pure:virtualenv color 8

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

