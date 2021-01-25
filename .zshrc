# If ~/.zshenv hasn't been linked, link it
if [[ ! -L ${HOME}/.zshenv ]]; then
  ln -fs ${HOME}/.config/zshenv ${HOME}/.zshenv
  source ${HOME}/.zshenv
fi

# Environment variables
export HOMEBREW_BUNDLE_FILE=${ZDOTDIR}/.Brewfile
export PAGER=most
export PATH=${HOME}/.cargo/bin:${PATH}

xcode-select -p &>/dev/null || xcode-select --install
type brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ ! ${ZDOTDIR}/.Brewfile.lock.json -nt ${HOMEBREW_BUNDLE_FILE} ]]; then
  brew bundle install
fi

alias ls='exa --git --group-directories-first --time-style=long-iso'
alias ll='ls -la'
alias tree='exa --tree'

HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_save_no_dups share_history

autoload -Uz compinit && compinit

eval "$(starship init zsh)"
eval $(brew shellenv)
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# saml login to AWS
function saml_login() {
  if [[ -z "${2}" ]]; then
    echo "usage: saml_login { CLUSTER_NAME } { ENVIRONMENT }"
  else
    CLUSTER=${1}
    ENV=${2}

    export KUBECONFIG=${HOME}/.kube/${CLUSTER}-${ENV}.config

    saml2aws login -a ${CLUSTER}-${ENV} --skip-prompt
    eval $(saml2aws script -a ${CLUSTER}-${ENV})

    if [[ ! -f "${KUBECONFIG}" ]]; then
      aws eks \
        --profile=${CLUSTER}-${ENV} \
        update-kubeconfig \
        --name ${CLUSTER} \
        --kubeconfig=${KUBECONFIG}
    fi
  fi
}
