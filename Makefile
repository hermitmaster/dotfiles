# Dotfiles Makefile for macOS

SHELL := /bin/zsh
.DEFAULT_GOAL := help

CONFIG   := $(HOME)/.config
ZSH_DIR  := $(CONFIG)/zsh
HOMEBREW_PREFIX := /opt/homebrew
BREW     := $(HOMEBREW_PREFIX)/bin/brew

SYMLINKS := .zshenv .zshrc .zprofile

# Created by `link` and verified by `info`; keep the two in step by listing
# them once. .claude is not XDG, but link owns it, so info should check it.
MANAGED_DIRS := \
	$(HOME)/.local/bin \
	$(HOME)/.local/share \
	$(HOME)/.local/state \
	$(HOME)/.local/state/zsh \
	$(HOME)/.cache \
	$(HOME)/.cache/zsh/completions \
	$(HOME)/.claude

# =============================================================================
# Primary
# =============================================================================

.PHONY: help install bootstrap update

help: ## Show this help
	@echo "Dotfiles Setup for macOS\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\nQuick start: make install"

install: check-deps homebrew link packages nvim ## Full installation
	@echo "✅ Done. Restart your terminal or: source ~/.zshenv && source ~/.zshrc"

bootstrap: check-deps homebrew link ## Minimal setup (no packages)
	@echo "✅ Bootstrap complete. Run 'make packages' for tools."

update: ## Update Homebrew packages and Neovim plugins
	@[ -x "$(BREW)" ] || { echo "❌ Homebrew not found"; exit 1; }
	@$(BREW) update && $(BREW) upgrade && $(BREW) bundle install --global
	@$(BREW) bundle cleanup --global --force
	@$(MAKE) -s nvim
	@$(MAKE) -s completions

# =============================================================================
# Setup
# =============================================================================

.PHONY: check-deps homebrew packages link nvim completions

check-deps:
	@command -v curl >/dev/null || { echo "❌ curl required"; exit 1; }
	@command -v git  >/dev/null || { echo "❌ git required";  exit 1; }

homebrew:
	@[ -x "$(BREW)" ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

packages: homebrew
	@[ -f "$(CONFIG)/homebrew/Brewfile" ] || { echo "❌ Brewfile not found"; exit 1; }
	@$(BREW) update && $(BREW) bundle install --global

link:
	@mkdir -p $(MANAGED_DIRS)
	@for f in $(SYMLINKS); do \
		[ -f "$(ZSH_DIR)/$$f" ] && ln -sf "$(ZSH_DIR)/$$f" "$(HOME)/$$f"; \
	done

nvim:
	@command -v nvim >/dev/null && nvim --headless +'Lazy! sync' +qa 2>/dev/null || true

# Regenerate cached zsh completions for upgraded tools by running one login
# shell, so the next interactive shell does not pay the cost. The generation
# logic itself lives in zsh/.zshrc; this just triggers it.
completions: ## Regenerate cached zsh completions
	@zsh -lic true >/dev/null 2>&1 || true

# =============================================================================
# Maintenance
# =============================================================================

.PHONY: clean uninstall info

clean: ## Remove broken symlinks and caches
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true
	@command -v brew >/dev/null && brew cleanup || true

uninstall: ## Remove dotfile symlinks
	@rm -f $(addprefix $(HOME)/,$(SYMLINKS))
	@echo "Dotfiles removed. Homebrew remains."

info: ## Show system info and validate config
	@printf "OS: %s %s\nArch: %s\nShell: %s\nBrew: %s\nConfig: %s\n" \
		"$$(sw_vers -productName)" "$$(sw_vers -productVersion)" \
		"$$(uname -m)" "$$SHELL" "$(HOMEBREW_PREFIX)" "$(CONFIG)"
	@echo "---"
	@[ -x "$(BREW)" ]         && echo "✅ Homebrew"  || echo "❌ Homebrew"
	@for f in $(SYMLINKS); do \
		[ -L "$(HOME)/$$f" ]   && echo "✅ $$f"       || echo "❌ $$f"; \
	done
	@for d in $(MANAGED_DIRS); do \
		[ -d "$$d" ]           && echo "✅ $$d"        || echo "❌ $$d missing"; \
	done
	@for f in $(SYMLINKS); do \
		[ -f "$(HOME)/$$f" ]   && zsh -n "$(HOME)/$$f" && echo "✅ $$f syntax OK" || true; \
	done
