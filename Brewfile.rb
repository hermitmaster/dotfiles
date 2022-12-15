tap 'homebrew/cask'
tap 'homebrew/cask-fonts'

brew 'awscli'
brew 'bottom'
brew 'delve'
brew 'diff-so-fancy'
brew 'direnv'
brew 'dive'
brew 'exa'
brew 'fzf'
brew 'git'
brew 'go'
brew 'gofumpt'
brew 'gomodifytags'
brew 'gotests'
brew 'jq'
brew 'k9s'
brew 'kubectx'
brew 'kubernetes-cli'
brew 'luarocks'
brew 'mas'
brew 'neovim'
brew 'node'
brew 'opa'
brew 'pre-commit'
brew 'python'
brew 'pure'
brew 'ripgrep'
brew 'shellcheck'
brew 'staticcheck'
brew 'terraform'
brew 'terraform-docs'
brew 'terraformer'
brew 'terragrunt'
brew 'tflint'
brew 'tfsec'
brew 'tmux'
brew 'tmux-mem-cpu-load'
brew 'trash'
brew 'wget'
brew 'yq'
brew 'zsh-autosuggestions'
brew 'zsh-syntax-highlighting'

cask 'alacritty', args: { 'no-quarantine': true }
cask 'docker'
cask 'font-hack-nerd-font'
cask 'mouse-fix', args: { 'no-quarantine': true }
cask 'rectangle'

mas 'AdGuard for Safari', id: 1440147259
mas 'Vimari', id: 1480933944

if ENV['USER'] == 'hermitmaster'
  cask 'openemu', args: { 'no-quarantine': true }
  cask 'steam'
else
  mas 'OneLogin for Safari', id: 1475824389
  mas 'Xcode', id: 497799835

  tap 'synfinatic/aws-sso-cli'
  brew 'aws-sso-cli'
end
