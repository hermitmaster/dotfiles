# Dotfiles

A modern, XDG-compliant dotfiles setup for macOS with automated installation and
management.

## Features

- **XDG Base Directory compliant** - This repo _is_ `~/.config`; editing a file
  here edits the live config for the running tool
- **Automated setup** - One-command installation on vanilla macOS
- **Modern tools** - Includes `eza`, `bat`, `fzf`, `neovim`, and more
- **Zsh configuration** - starship prompt, autosuggestions, syntax highlighting
- **Git integration** - Comprehensive aliases and conditional work/personal
  configs
- **Homebrew management** - Brewfile as the single source of truth for packages

## Quick Start

### New Installation (Vanilla macOS)

```bash
# Clone dotfiles
git clone git@github.com:hermitmaster/dotfiles.git ~/.config

# Full installation (recommended)
cd ~/.config && make install

# Start a fresh login shell to pick up the new config
exec zsh -l
```

### Minimal Bootstrap

If you want to set up basics first and install packages later:

```bash
cd ~/.config && make bootstrap
# Then later: make packages
```

## Available Commands

### Installation & Setup

- `make install` - Full installation: check-deps, homebrew, link, packages, nvim
- `make bootstrap` - Minimal setup, no packages: check-deps, homebrew, link
- `make homebrew` - Install Homebrew only
- `make link` - Symlink the three zsh dotfiles into `$HOME` and create the XDG
  directories
- `make packages` - Install all packages from `homebrew/Brewfile`

### Maintenance

- `make update` - Update Homebrew packages and Neovim plugins, then regenerate
  zsh completions
- `make nvim` - Update Neovim plugins
- `make completions` - Regenerate the cached zsh completions
- `make clean` - Remove broken `$HOME` symlinks and run `brew cleanup`
- `make uninstall` - Remove the dotfile symlinks (Homebrew remains)

### Information & Debugging

- `make info` - Show system info and validate symlinks, XDG dirs, and zsh syntax
- `make help` - Show all available commands

## What Gets Installed

### Core Tools

- **Homebrew** - Package manager
- **Zsh** - macOS's own zsh, with Homebrew plugins (autosuggestions, completions,
  syntax highlighting)
- **Git** - Version control with aliases
- **Neovim** - Modern text editor

### CLI Enhancements

- **eza** - Better `ls` with icons and git integration
- **bat** - Better `cat` with syntax highlighting
- **fzf** - Fuzzy finder for files and history
- **fd** - Fast file finder; also what `fzf` walks with
- **zoxide** - Smart directory jumping
- **ripgrep** - Fast text search

### Development Tools

- **Go, Node.js, Python** - Programming languages
- **Kubernetes tools** - `k9s`, `kubectx`, `kustomize`, `argocd`, `kubeconform`,
  `kubebuilder`, `kubeseal`, `stern` (`kubectl` and `helm` come from Rancher
  Desktop)
- **AWS CLI, aws-sso-cli, session-manager-plugin** - Cloud tools
- **Terraform, Terragrunt** - Infrastructure as code
- **LSP servers, formatters, linters** - not here; Neovim installs its own via Mason

### Applications

- **WezTerm** - Modern terminal
- **Rancher Desktop** - Containers
- **Obsidian** - Notes
- **Rectangle** - Window management
- **Claude Code** - AI coding agent

## Configuration Structure

```text
~/.config/
├── Makefile              # Installation and management
├── README.md             # This file
├── CLAUDE.md             # Guidance for Claude Code in this repo
├── git/
│   ├── config            # Git configuration
│   └── ignore            # Global gitignore
├── homebrew/
│   └── Brewfile          # Package definitions
├── nvim/                 # Neovim (LazyVim overlay)
├── starship/
│   └── starship.toml     # Prompt; found via $STARSHIP_CONFIG, not the default path
├── opencode/             # opencode agent config
├── wezterm/
├── dlv/
├── gh/
├── k9s/
├── lazygit/
└── zsh/
    ├── .zshenv           # Environment variables (every shell)
    ├── .zprofile         # PATH and fpath (login shells)
    ├── .zshrc            # Interactive shell configuration
    └── functions/        # Custom shell functions
```

The three zsh dotfiles are the only files symlinked out of this repo; everything
else is read in place from `~/.config`. The split is load-order-critical -
`.zshenv` sets environment variables, `.zprofile` sets PATH after macOS
`path_helper` has run, and `.zshrc` handles interactive setup.

## Customization

### Machine-Local Overrides

`~/.zshenv.local` is sourced at the end of `.zshenv`, if present. Put
machine-specific secrets and overrides there - it lives outside this repo on
purpose.

### Environment-Specific Git Config

The setup includes conditional git configuration for work environments:

```gitconfig
[includeIf "gitdir:~/work/"]
  path = ~/work/.gitconfig
```

Create `~/work/.gitconfig` for work-specific settings.

### Adding New Tools

1. Add packages to `homebrew/Brewfile`
2. Add configuration to `.zshrc` if needed, guarded by
   `(( $+commands[foo] ))` so the config stays sourceable before
   `make packages` has run
3. Run `make update` to install

`make update` runs `brew bundle cleanup --global --force` after installing, so
**anything not in the Brewfile gets uninstalled**. Add tools to the Brewfile
rather than `brew install`-ing them.

### Custom Functions

Add new shell functions to `zsh/functions/` directory. They'll be auto-loaded.

## Troubleshooting

### Check Installation Status

```bash
make info
```

### Validate Configurations

`make info` syntax-checks `.zshrc` and `.zshenv` and verifies every symlink and
XDG directory. To check a single file:

```bash
zsh -n zsh/.zshrc
```

### Changes Not Taking Effect

Shell config changes need a **new shell**, not just a `source`:

```bash
exec zsh -l
```

`.zprofile` only runs for login shells, so `source ~/.zprofile` re-prepends PATH
entries instead of reproducing a clean login environment.

### Clean Up Issues

```bash
make clean
```

### Fresh Installation

```bash
make uninstall  # Remove dotfiles (keeps Homebrew)
make install    # Reinstall everything
```

## Requirements

- macOS on Apple Silicon (Intel is not supported)
- `curl` and `git` (pre-installed on macOS)
- Internet connection for downloading packages

## License

Personal dotfiles configuration. Feel free to fork and adapt for your own use.
