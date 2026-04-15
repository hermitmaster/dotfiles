# Dotfiles Makefile for macOS

SHELL := /bin/zsh
.DEFAULT_GOAL := help

CONFIG   := $(HOME)/.config
ZSH_DIR  := $(CONFIG)/zsh
ARCH     := $(shell uname -m)
HOMEBREW_PREFIX := $(if $(filter arm64,$(ARCH)),/opt/homebrew,/usr/local)
BREW     := $(HOMEBREW_PREFIX)/bin/brew

SYMLINKS := .zshenv .zshrc .zprofile .editorconfig .prettierrc

# =============================================================================
# Primary
# =============================================================================

.PHONY: help install bootstrap update

help: ## Show this help
	@echo "Dotfiles Setup for macOS\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\nQuick start: make install"

install: check-deps homebrew link setup-shell packages nvim claude ## Full installation
	@echo "✅ Done. Restart your terminal or: source ~/.zshenv && source ~/.zshrc"

bootstrap: check-deps homebrew link setup-shell ## Minimal setup (no packages)
	@echo "✅ Bootstrap complete. Run 'make packages' for tools."

update: ## Update Homebrew packages and Neovim plugins
	@[ -x "$(BREW)" ] || { echo "❌ Homebrew not found"; exit 1; }
	@$(BREW) update && $(BREW) upgrade && $(BREW) bundle install --global && $(BREW) cleanup
	@$(MAKE) -s nvim

# =============================================================================
# Setup
# =============================================================================

.PHONY: check-deps homebrew setup-shell packages link nvim claude

check-deps:
	@command -v curl >/dev/null || { echo "❌ curl required"; exit 1; }
	@command -v git  >/dev/null || { echo "❌ git required";  exit 1; }

homebrew:
	@[ -x "$(BREW)" ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

setup-shell:
	@if [ "$$SHELL" != "$(HOMEBREW_PREFIX)/bin/zsh" ] && [ "$$SHELL" != "/bin/zsh" ]; then \
		grep -q "$(HOMEBREW_PREFIX)/bin/zsh" /etc/shells || echo "$(HOMEBREW_PREFIX)/bin/zsh" | sudo tee -a /etc/shells; \
		chsh -s "$(HOMEBREW_PREFIX)/bin/zsh"; \
	fi

packages: homebrew
	@[ -f "$(CONFIG)/homebrew/Brewfile" ] || { echo "❌ Brewfile not found"; exit 1; }
	@$(BREW) update && $(BREW) bundle install --global

link:
	@mkdir -p $(HOME)/.local/{bin,share,state} $(HOME)/.cache $(HOME)/.claude
	@for f in .zshenv .zshrc .zprofile; do \
		[ -f "$(ZSH_DIR)/$$f" ] && ln -sf "$(ZSH_DIR)/$$f" "$(HOME)/$$f"; \
	done
	@[ -f "$(CONFIG)/editorconfig/.editorconfig" ] && ln -sf "$(CONFIG)/editorconfig/.editorconfig" "$(HOME)/.editorconfig" || true
	@[ -f "$(CONFIG)/prettier/.prettierrc" ]       && ln -sf "$(CONFIG)/prettier/.prettierrc"       "$(HOME)/.prettierrc"   || true

nvim:
	@command -v nvim >/dev/null && nvim --headless +'Lazy! sync' +qa 2>/dev/null || true

claude:
	@[ -f "$(CONFIG)/CLAUDE.md" ] && ln -sf "$(CONFIG)/CLAUDE.md" "$(HOME)/.claude/CLAUDE.md" || true

# =============================================================================
# Maintenance
# =============================================================================

.PHONY: clean uninstall info

clean: ## Remove broken symlinks and caches
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@command -v brew >/dev/null && brew cleanup || true

uninstall: ## Remove dotfile symlinks
	@rm -f $(addprefix $(HOME)/,$(SYMLINKS)) $(HOME)/.claude/CLAUDE.md
	@echo "Dotfiles removed. Homebrew remains."

info: ## Show system info and validate config
	@printf "OS: %s %s\nArch: %s\nShell: %s\nBrew: %s\nConfig: %s\n" \
		"$$(sw_vers -productName)" "$$(sw_vers -productVersion)" \
		"$(ARCH)" "$$SHELL" "$(HOMEBREW_PREFIX)" "$(CONFIG)"
	@echo "---"
	@[ -x "$(BREW)" ]         && echo "✅ Homebrew"  || echo "❌ Homebrew"
	@for f in $(SYMLINKS); do \
		[ -L "$(HOME)/$$f" ]   && echo "✅ $$f"       || echo "❌ $$f"; \
	done
	@for d in $(HOME)/.local/bin $(HOME)/.cache $(HOME)/.local/share $(HOME)/.local/state; do \
		[ -d "$$d" ]           && echo "✅ $$d"        || echo "❌ $$d missing"; \
	done
	@[ -f "$(HOME)/.zshrc" ]  && zsh -n "$(HOME)/.zshrc"  && echo "✅ .zshrc syntax OK"  || true
	@[ -f "$(HOME)/.zshenv" ] && zsh -n "$(HOME)/.zshenv" && echo "✅ .zshenv syntax OK" || true
