tap 'homebrew/cask'
tap 'homebrew/cask-fonts'
tap 'romkatv/powerlevel10k'

brew 'ansible'
brew 'awscli'
brew 'bottom'
brew 'coreutils'
brew 'delve'
brew 'direnv'
brew 'exa'
brew 'fd'
brew 'fzf'
brew 'git'
brew 'gnu-sed'
brew 'go'
brew 'gomodifytags'
brew 'gotests'
brew 'jq'
brew 'k9s'
brew 'kubectx', args: ['ignore-dependencies']
brew 'luarocks'
brew 'mas'
brew 'neovim'
brew 'node'
brew 'powerlevel10k'
brew 'pre-commit'
brew 'prettier'
brew 'python'
brew 'ripgrep'
brew 'rust'
brew 'shellcheck'
brew 'shfmt'
brew 'staticcheck'
brew 'terraform'
brew 'terraform-docs'
brew 'terragrunt'
brew 'tflint'
brew 'tfsec'
brew 'trash'
brew 'virtualenv'
brew 'wget'
brew 'yq'
brew 'zsh-autosuggestions'
brew 'zsh-syntax-highlighting'

cask 'font-hack-nerd-font'
cask 'kitty'
cask 'mouse-fix', args: { 'no-quarantine': true }
cask 'rancher'
cask 'rectangle'

mas 'AdGuard for Safari', id: 1440147259
mas 'Vimari', id: 1480933944

if ENV['USER'] == 'hermitmaster'
  tap 'homebrew/cask-drivers'

  cask 'openemu', args: { 'no-quarantine': true }
  cask 'steam'
  cask 'zsa-wally'
else
  brew 'gnupg'
  brew 'kops', args: ['ignore-dependencies']

  mas 'OneLogin for Safari', id: 1475824389
  mas 'Xcode', id: 497799835

  tap 'synfinatic/aws-sso-cli'
  brew 'aws-sso-cli'
end
