# frozen_string_literal: true

tap 'homebrew/cask'
tap 'homebrew/cask-fonts'
tap 'romkatv/powerlevel10k'

brew 'awscli'
brew 'bat'
brew 'bottom'
brew 'checkmake'
brew 'd2'
brew 'diff-so-fancy'
brew 'direnv'
brew 'exa'
brew 'fd'
brew 'fzf'
brew 'git'
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
brew 'node'
brew 'opa'
brew 'powerlevel10k'
brew 'pre-commit'
brew 'python'
brew 'ripgrep'
brew 'ruby'
brew 'staticcheck'
brew 'terraform'
brew 'terraform-docs'
brew 'terraformer'
brew 'terragrunt'
brew 'tflint'
brew 'tfsec'
brew 'typescript'
brew 'wget'
brew 'yq'
brew 'zsh-autosuggestions'
brew 'zsh-syntax-highlighting'

cask 'docker'
cask 'font-jetbrains-mono-nerd-font'
cask 'goland'
cask 'mouse-fix', args: { 'no-quarantine': true }
cask 'rectangle'
cask 'wezterm'

mas 'AdGuard for Safari', id: 1_440_147_259
mas 'Vimari', id: 1_480_933_944

if ENV['USER'] == 'hermitmaster'
  cask 'openemu', args: { 'no-quarantine': true }
  cask 'steam'
else
  tap 'fluxcd/tap'
  tap 'synfinatic/aws-sso-cli'
  tap 'del/cloud15', 'ssh://git@hq-stash.corp.proofpoint.com:7999/del/homebrew-cloud15.git'

  brew 'aws-iam-authenticator'
  brew 'c15-onelogin-client'
  brew 'fluxcd/tap/flux'
  brew 'git-remote-codecommit'
  brew 'prometheus'

  mas 'OneLogin for Safari', id: 1_475_824_389
  mas 'Xcode', id: 497_799_835

  brew 'aws-sso-cli'
end
