# frozen_string_literal: true

tap 'fluxcd/tap'
tap 'homebrew/cask'
tap 'homebrew/cask-fonts'

brew 'awscli'
brew 'bat'
brew 'bottom'
brew 'checkmake'
brew 'cmake'
brew 'd2'
brew 'direnv'
brew 'exa'
brew 'fd'
brew 'fzf'
brew 'git'
brew 'gitui'
brew 'git-delta'
brew 'go'
brew 'gofumpt'
brew 'gotests'
brew 'grex'
brew 'helm'
brew 'jq'
brew 'k9s'
brew 'kubectx'
brew 'kubernetes-cli'
brew 'mas'
brew 'neovim'
brew 'node@18'
brew 'opa'
brew 'powerlevel10k'
brew 'python'
brew 'ripgrep'
brew 'ruby'
brew 'six'
brew 'staticcheck'
brew 'terraform'
brew 'terraform-docs'
brew 'terraformer'
brew 'terragrunt'
brew 'tflint'
brew 'tfsec'
brew 'typescript'
brew 'wget'
brew 'yarn'
brew 'yq'
brew 'zsh-autosuggestions'
brew 'zsh-syntax-highlighting'

cask 'docker'
cask 'font-jetbrains-mono-nerd-font'
cask 'goland'
cask 'mac-mouse-fix', args: { 'no-quarantine': true }
cask 'rectangle'
cask 'wezterm'

mas 'AdGuard for Safari', id: 1_440_147_259
mas 'Vimari', id: 1_480_933_944

if ENV['USER'] == 'hermitmaster'
  cask 'openemu', args: { 'no-quarantine': true }
  cask 'steam'
else
  tap 'del/cloud15', 'ssh://git@hq-stash.corp.proofpoint.com:7999/del/homebrew-cloud15.git'
  tap 'del/cloud15-internal', 'ssh://git@hq-stash.corp.proofpoint.com:7999/del/homebrew-cloud15-internal.git'

  brew 'del/cloud15/c15-onelogin-client'
  brew 'del/cloud15-internal/namespace-creator'
  brew 'aws-iam-authenticator'
  brew 'aws-sso-cli'
  brew 'fluxcd/tap/flux'
  brew 'git-remote-codecommit'
  brew 'kubent'
  brew 'kustomize'

  mas 'OneLogin for Safari', id: 1_475_824_389
  mas 'Xcode', id: 497_799_835
end
