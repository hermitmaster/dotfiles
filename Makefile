# Dotfiles Makefile for macOS Setup
# Works on vanilla macOS installations

SHELL := /bin/zsh
.DEFAULT_GOAL := help

# Directories
CONFIG_DIR := $(HOME)/.config
HOMEBREW_PREFIX := /opt/homebrew
ZSH_DIR := $(CONFIG_DIR)/zsh

# Check if we're on Apple Silicon or Intel Mac
ARCH := $(shell uname -m)
ifeq ($(ARCH),arm64)
    HOMEBREW_PREFIX := /opt/homebrew
else
    HOMEBREW_PREFIX := /usr/local
endif

.PHONY: help install bootstrap homebrew link-configs setup-shell install-packages setup-cron setup-nvim update clean check-deps

help: ## Show this help message
	@echo "Dotfiles Setup for macOS"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "Quick start: make install"

install: check-deps homebrew link-configs setup-shell install-packages setup-cron setup-nvim ## Full installation (recommended for new setups)
	@echo "✅ Dotfiles installation complete!"
	@echo "Please restart your terminal or run: source ~/.zshenv && source ~/.zshrc"

bootstrap: check-deps homebrew link-configs setup-shell ## Minimal bootstrap (Homebrew + basic setup)
	@echo "✅ Bootstrap complete! Run 'make install-packages' to install all tools."

check-deps: ## Check system dependencies
	@echo "🔍 Checking system dependencies..."
	@command -v curl >/dev/null 2>&1 || { echo "❌ curl is required but not installed"; exit 1; }
	@command -v git >/dev/null 2>&1 || { echo "❌ git is required but not installed"; exit 1; }
	@echo "✅ System dependencies satisfied"

homebrew: ## Install Homebrew if not present
	@echo "🍺 Setting up Homebrew..."
	@if [ ! -x "$(HOMEBREW_PREFIX)/bin/brew" ]; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed"; \
	fi
	@echo "✅ Homebrew setup complete"

link-configs: ## Create symbolic links for config files
	@echo "🔗 Linking configuration files..."
	@mkdir -p $(HOME)/.local/bin $(HOME)/.cache $(HOME)/.local/share $(HOME)/.local/state

	# Link zsh configs
	@for file in .zshenv .zshrc; do \
		if [ -f "$(ZSH_DIR)/$$file" ]; then \
			ln -sf "$(ZSH_DIR)/$$file" "$(HOME)/$$file"; \
			echo "Linked $$file"; \
		fi; \
	done

	# Link other configs
	@for config in "editorconfig/.editorconfig" "prettier/.prettierrc"; do \
		if [ -f "$(CONFIG_DIR)/$$config" ]; then \
			ln -sf "$(CONFIG_DIR)/$$config" "$(HOME)/$$(basename $$config)"; \
			echo "Linked $$(basename $$config)"; \
		fi; \
	done
	@echo "✅ Configuration files linked"

setup-shell: ## Set zsh as default shell and load functions
	@echo "🐚 Setting up shell..."
	@# Set zsh as default shell if not already
	@if [ "$$SHELL" != "$(HOMEBREW_PREFIX)/bin/zsh" ] && [ "$$SHELL" != "/bin/zsh" ]; then \
		echo "Setting zsh as default shell..."; \
		if ! grep -q "$(HOMEBREW_PREFIX)/bin/zsh" /etc/shells; then \
			echo "$(HOMEBREW_PREFIX)/bin/zsh" | sudo tee -a /etc/shells; \
		fi; \
		chsh -s $(HOMEBREW_PREFIX)/bin/zsh; \
	fi
	@echo "✅ Shell setup complete"

install-packages: homebrew ## Install all packages from Brewfile
	@echo "📦 Installing packages..."
	@if [ -f "$(CONFIG_DIR)/homebrew/Brewfile" ]; then \
		$(HOMEBREW_PREFIX)/bin/brew update; \
		$(HOMEBREW_PREFIX)/bin/brew bundle install --global; \
	else \
		echo "❌ Brewfile not found at $(CONFIG_DIR)/homebrew/Brewfile"; \
		exit 1; \
	fi
	@echo "✅ Package installation complete"

setup-nvim: ## Setup and update Neovim plugins
	@echo "🔧 Setting up Neovim plugins..."
	@if command -v nvim >/dev/null 2>&1; then \
		nvim --headless +'Lazy! sync' +qa 2>/dev/null || echo "Neovim plugin sync completed"; \
	else \
		echo "⚠️  Neovim not installed, skipping plugin setup"; \
	fi

setup-cron: ## Install cron jobs
	@echo "⏰ Setting up cron jobs..."
	@if [ -f "$(CONFIG_DIR)/cron/crontab" ]; then \
		if command -v crontab >/dev/null 2>&1; then \
			crontab "$(CONFIG_DIR)/cron/crontab" && echo "Cron jobs installed successfully"; \
		else \
			echo "⚠️  crontab command not found, skipping cron setup"; \
		fi; \
	else \
		echo "⚠️  No crontab file found, skipping"; \
	fi
	@echo "✅ Cron setup complete"

update: ## Update all packages and tools
	@echo "🔄 Updating packages and tools..."
	@if [ -x "$(HOMEBREW_PREFIX)/bin/brew" ]; then \
		$(HOMEBREW_PREFIX)/bin/brew update; \
		$(HOMEBREW_PREFIX)/bin/brew bundle install --global; \
		$(HOMEBREW_PREFIX)/bin/brew cleanup; \
	else \
		echo "❌ Homebrew not found, run 'make homebrew' first"; \
		exit 1; \
	fi
	@$(MAKE) setup-nvim
	@echo "✅ Update complete"

clean: ## Clean up broken symlinks and caches
	@echo "🧹 Cleaning up..."
	@# Remove broken symlinks in home directory
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@# Clean Homebrew caches
	@if command -v brew >/dev/null 2>&1; then \
		brew cleanup; \
	fi
	@echo "✅ Cleanup complete"

uninstall: ## Remove dotfiles (keeps Homebrew and packages)
	@echo "🗑️  Removing dotfiles..."
	@rm -f $(HOME)/.zshenv $(HOME)/.zshrc $(HOME)/.editorconfig $(HOME)/.prettierrc
	@echo "⚠️  Dotfiles removed. Homebrew and packages remain installed."
	@echo "   To completely remove everything, also run: /bin/bash -c \"\$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)\""

# Development targets
dev-check: ## Check configuration files for issues
	@echo "🔍 Checking configuration files..."
	@# Check zsh syntax
	@if [ -f "$(HOME)/.zshrc" ]; then \
		zsh -n "$(HOME)/.zshrc" && echo "✅ .zshrc syntax OK" || echo "❌ .zshrc syntax error"; \
	fi
	@if [ -f "$(HOME)/.zshenv" ]; then \
		zsh -n "$(HOME)/.zshenv" && echo "✅ .zshenv syntax OK" || echo "❌ .zshenv syntax error"; \
	fi
	@# Check for required directories
	@for dir in "$(HOME)/.local/bin" "$(HOME)/.cache" "$(HOME)/.local/share" "$(HOME)/.local/state"; do \
		if [ -d "$$dir" ]; then \
			echo "✅ $$dir exists"; \
		else \
			echo "❌ $$dir missing"; \
		fi; \
	done

info: ## Show system and setup information
	@echo "System Information:"
	@echo "=================="
	@echo "OS: $$(sw_vers -productName) $$(sw_vers -productVersion)"
	@echo "Architecture: $(ARCH)"
	@echo "Shell: $$SHELL"
	@echo "Homebrew prefix: $(HOMEBREW_PREFIX)"
	@echo "Config directory: $(CONFIG_DIR)"
	@echo ""
	@echo "Installation Status:"
	@echo "==================="
	@if [ -x "$(HOMEBREW_PREFIX)/bin/brew" ]; then echo "✅ Homebrew installed"; else echo "❌ Homebrew not installed"; fi
	@if [ -L "$(HOME)/.zshrc" ]; then echo "✅ .zshrc linked"; else echo "❌ .zshrc not linked"; fi
	@if [ -L "$(HOME)/.zshenv" ]; then echo "✅ .zshenv linked"; else echo "❌ .zshenv not linked"; fi
	@if crontab -l >/dev/null 2>&1; then echo "✅ Cron jobs installed"; else echo "❌ No cron jobs"; fi
