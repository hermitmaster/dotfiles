# Dotfiles Makefile for macOS

SHELL := /bin/zsh
.DEFAULT_GOAL := help

# Directories
CONFIG   := $(HOME)/.config
ZSH_DIR  := $(CONFIG)/zsh
ARCH     := $(shell uname -m)
HOMEBREW_PREFIX := $(if $(filter arm64,$(ARCH)),/opt/homebrew,/usr/local)
BREW     := $(HOMEBREW_PREFIX)/bin/brew

.PHONY: help install bootstrap check-deps homebrew link setup-shell packages \
        nvim cron update clean uninstall check info

# =============================================================================
# Main targets
# =============================================================================

help: ## Show this help
	@echo "Dotfiles Setup for macOS\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\nQuick start: make install"

install: check-deps homebrew link setup-shell packages nvim ## Full installation
	@echo "✅ Done. Restart your terminal or: source ~/.zshenv && source ~/.zshrc"

bootstrap: check-deps homebrew link setup-shell ## Minimal setup (no packages)
	@echo "✅ Bootstrap complete. Run 'make packages' for tools."

# =============================================================================
# Setup targets
# =============================================================================

check-deps: ## Verify curl and git exist
	@command -v curl >/dev/null || { echo "❌ curl required"; exit 1; }
	@command -v git  >/dev/null || { echo "❌ git required";  exit 1; }

homebrew: ## Install Homebrew if missing
	@[ -x "$(BREW)" ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

link: ## Symlink config files
	@mkdir -p $(HOME)/.local/{bin,share,state} $(HOME)/.cache
	@for f in .zshenv .zshrc .zprofile; do \
		[ -f "$(ZSH_DIR)/$$f" ] && ln -sf "$(ZSH_DIR)/$$f" "$(HOME)/$$f"; \
	done
	@[ -f "$(CONFIG)/editorconfig/.editorconfig" ] && ln -sf "$(CONFIG)/editorconfig/.editorconfig" "$(HOME)/.editorconfig" || true
	@[ -f "$(CONFIG)/prettier/.prettierrc" ]       && ln -sf "$(CONFIG)/prettier/.prettierrc"       "$(HOME)/.prettierrc"   || true

setup-shell: ## Set zsh as default shell
	@if [ "$$SHELL" != "$(HOMEBREW_PREFIX)/bin/zsh" ] && [ "$$SHELL" != "/bin/zsh" ]; then \
		grep -q "$(HOMEBREW_PREFIX)/bin/zsh" /etc/shells || echo "$(HOMEBREW_PREFIX)/bin/zsh" | sudo tee -a /etc/shells; \
		chsh -s "$(HOMEBREW_PREFIX)/bin/zsh"; \
	fi

packages: homebrew ## Install from Brewfile
	@[ -f "$(CONFIG)/homebrew/Brewfile" ] || { echo "❌ Brewfile not found"; exit 1; }
	@$(BREW) update && $(BREW) bundle install --global

nvim: ## Sync Neovim plugins
	@command -v nvim >/dev/null && nvim --headless +'Lazy! sync' +qa 2>/dev/null || true

# =============================================================================
# Maintenance
# =============================================================================

update: ## Update Homebrew packages and Neovim plugins
	@[ -x "$(BREW)" ] || { echo "❌ Homebrew not found"; exit 1; }
	@$(BREW) update && $(BREW) upgrade && $(BREW) bundle install --global && $(BREW) cleanup
	@$(MAKE) -s nvim

clean: ## Remove broken symlinks and caches
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@command -v brew >/dev/null && brew cleanup || true

uninstall: ## Remove dotfile symlinks
	@rm -f $(HOME)/.zshenv $(HOME)/.zshrc $(HOME)/.editorconfig $(HOME)/.prettierrc
	@echo "Dotfiles removed. Homebrew remains. To remove: brew uninstall --force"

# =============================================================================
# Info / Debug
# =============================================================================

check: ## Validate zsh config syntax
	@[ -f "$(HOME)/.zshrc" ]  && zsh -n "$(HOME)/.zshrc"  && echo "✅ .zshrc OK"  || true
	@[ -f "$(HOME)/.zshenv" ] && zsh -n "$(HOME)/.zshenv" && echo "✅ .zshenv OK" || true
	@for d in $(HOME)/.local/bin $(HOME)/.cache $(HOME)/.local/share $(HOME)/.local/state; do \
		[ -d "$$d" ] && echo "✅ $$d" || echo "❌ $$d missing"; \
	done

info: ## Show system info
	@printf "OS: %s %s\nArch: %s\nShell: %s\nBrew: %s\nConfig: %s\n" \
		"$$(sw_vers -productName)" "$$(sw_vers -productVersion)" \
		"$(ARCH)" "$$SHELL" "$(HOMEBREW_PREFIX)" "$(CONFIG)"
	@echo "---"
	@[ -x "$(BREW)" ]           && echo "✅ Homebrew"  || echo "❌ Homebrew"
	@[ -L "$(HOME)/.zshrc" ]    && echo "✅ .zshrc"    || echo "❌ .zshrc"
	@[ -L "$(HOME)/.zshenv" ]   && echo "✅ .zshenv"   || echo "❌ .zshenv"
