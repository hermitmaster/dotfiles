# Dotfiles

A modern, XDG-compliant dotfiles setup for macOS with automated installation and management.

## Features

- **XDG Base Directory compliant** - Clean organization under `~/.config/`
- **Automated setup** - One-command installation on vanilla macOS
- **Modern tools** - Includes `eza`, `bat`, `fzf`, `neovim`, and more
- **Zsh configuration** - Powerlevel10k theme, autosuggestions, syntax highlighting
- **Git integration** - Comprehensive aliases and conditional work/personal configs
- **Homebrew management** - Brewfile with all development tools
- **Cron automation** - Automated AWS credential refresh

## Quick Start

### New Installation (Vanilla macOS)

```bash
# Clone dotfiles
git clone git@github.com:hermitmaster/dotfiles.git ~/.config

# Full installation (recommended)
cd ~/.config && make install

# Restart your terminal or source the configs
source ~/.zshenv && source ~/.zshrc
```

### Minimal Bootstrap

If you want to set up basics first and install packages later:

```bash
cd ~/.config && make bootstrap
# Then later: make install-packages
```

## Available Commands

### Installation & Setup
- `make install` - Full installation (Homebrew + packages + configs + cron)
- `make bootstrap` - Minimal setup (Homebrew + basic configs)
- `make homebrew` - Install Homebrew only
- `make link-configs` - Create symbolic links for config files
- `make install-packages` - Install all packages from Brewfile
- `make setup-cron` - Install cron jobs

### Maintenance
- `make update` - Update all packages and tools (replaces old `uatt` function)
- `make setup-nvim` - Update Neovim plugins
- `make clean` - Clean up broken symlinks and caches

### Information & Debugging
- `make info` - Show system and installation status
- `make dev-check` - Validate configuration files
- `make help` - Show all available commands

### Convenience Aliases

After installation, you can use these shortcuts:
- `uatt` - Quick update (alias for `make update`)
- `dotfiles` - Access dotfiles management (alias for `make -C ~/.config`)

## What Gets Installed

### Core Tools
- **Homebrew** - Package manager
- **Zsh** - Modern shell with plugins
- **Git** - Version control with aliases
- **Neovim** - Modern text editor

### CLI Enhancements
- **eza** - Better `ls` with icons and git integration
- **bat** - Better `cat` with syntax highlighting
- **fzf** - Fuzzy finder for files and history
- **zoxide** - Smart directory jumping
- **ripgrep** - Fast text search

### Development Tools
- **Go, Node.js, Python** - Programming languages
- **Docker, Kubernetes tools** - Container orchestration
- **AWS CLI** - Cloud tools
- **Terraform** - Infrastructure as code

### Applications
- **Windsurf** - AI-powered IDE
- **GoLand** - Go IDE
- **WezTerm** - Modern terminal
- **Rectangle** - Window management

## Configuration Structure

```
~/.config/
├── Makefile              # Installation and management
├── README.md            # This file
├── cron/
│   └── crontab          # Scheduled tasks
├── git/
│   ├── config           # Git configuration
│   └── ignore           # Global gitignore
├── homebrew/
│   └── Brewfile         # Package definitions
└── zsh/
    ├── .zshenv          # Environment variables
    ├── .zshrc           # Shell configuration
    └── functions/       # Custom shell functions
```

## Customization

### Environment-Specific Git Config

The setup includes conditional git configuration for work environments:

```gitconfig
[includeIf "gitdir:~/work/"]
  path = ~/work/.gitconfig
```

Create `~/work/.gitconfig` for work-specific settings.

### Adding New Tools

1. Add packages to `homebrew/Brewfile`
2. Add configuration to `.zshrc` if needed
3. Run `make update` to install

### Custom Functions

Add new shell functions to `zsh/functions/` directory. They'll be auto-loaded.

## Troubleshooting

### Check Installation Status
```bash
make info
```

### Validate Configurations
```bash
make dev-check
```

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

- macOS (tested on Apple Silicon and Intel)
- `curl` and `git` (pre-installed on macOS)
- Internet connection for downloading packages

## License

Personal dotfiles configuration. Feel free to fork and adapt for your own use.
