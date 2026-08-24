# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This repo **is** `~/.config` itself — it is cloned directly to `$XDG_CONFIG_HOME`, not
symlinked into place from elsewhere. Editing a file here edits the live config for the
running tool. There is no build step and no "deploy": consequences are immediate.

The only exception is the three zsh dotfiles, which must live at `$HOME` and are
symlinked out of `zsh/` by `make link`.

macOS-only (Apple Silicon and Intel), zsh-only.

## Commands

```bash
make install     # Full setup: check-deps homebrew link setup-shell packages nvim
make bootstrap   # Minimal: check-deps homebrew link setup-shell (no packages)
make update      # brew update && upgrade && bundle install --global --force-cleanup, then nvim
make link        # Symlink .zshenv/.zshrc/.zprofile → $HOME; mkdir XDG dirs
make packages    # brew bundle install --global from homebrew/Brewfile
make nvim        # nvim --headless +'Lazy! sync' +qa
make info        # System info + validate symlinks, XDG dirs, zsh -n syntax check
make clean       # Delete broken $HOME symlinks (maxdepth 1) + brew cleanup
make uninstall   # Remove the dotfile symlinks; Homebrew remains
```

`make info` is the closest thing to a test suite — it `zsh -n` syntax-checks `.zshrc`
and `.zshenv` and verifies every symlink and XDG directory. Run it after touching
anything under `zsh/`.

To check a single shell file without the rest: `zsh -n zsh/.zshrc`.

There are no Neovim Lua tests, and no Lua test runner in the Brewfile.

### Verifying a change

Shell config changes need a **new shell** to take effect (`exec zsh`, or a new WezTerm
pane), not just `source`. `.zprofile` in particular only runs for login shells — a
plain `source ~/.zprofile` will re-prepend PATH entries rather than reproduce a clean
login environment.

## Architecture

### The zsh three-file split is load-order-critical

macOS `path_helper` runs from `/etc/zprofile` and **reorders PATH** if PATH is set
earlier. This dictates the split:

- **`.zshenv`** — env vars only, every shell. Sets `XDG_*` first, then vars that
  interpolate them (`GOPATH`, `JAVA_HOME`, `HOMEBREW_CELLAR`). Never set PATH here.
- **`.zprofile`** — PATH and fpath only, login shells, after `path_helper`. Uses
  `typeset -gU` for dedup and the `(N)` glob qualifier so missing dirs vanish silently.
- **`.zshrc`** — interactive only: aliases, completion, prompt, `setopt`, hooks.

Two ordering constraints inside `.zshrc`: `compinit` runs early with a 24-hour cache
check (`(#qN.mh+24)` → full `compinit`, else fast `compinit -C`), and
`zsh-syntax-highlighting` must be sourced **last** or highlighting breaks.

Every tool integration in `.zshrc` is guarded by `(( $+commands[foo] ))` or a file
test, so the config stays sourceable on a machine where `make packages` hasn't run.
Preserve that pattern when adding tools.

`$HOME/.zshenv.local` is sourced at the end of `.zshenv` for machine-local secrets and
overrides — it is intentionally outside this repo.

### Brewfile is the single source of truth for packages

`homebrew/Brewfile` is consumed via `brew bundle install --global`, and
`HOMEBREW_BUNDLE_INSTALL_CLEANUP=1` (set in `.zshenv`) means **anything not in the
Brewfile gets uninstalled** on `make update`. Adding a tool means adding it here, not
`brew install`-ing it.

The file branches on `ENV['USER'] == 'hermitmaster'` (personal) vs else (work): work
machines get `azure-cli`, `kubelogin`, `copier`, `snyk-cli`, `yubico-authenticator`;
the personal machine gets `openemu` and Homebrew-core `opencode`. Tap trust is declared
inline (`trusted: true`) rather than in `homebrew/trust.json`, which is gitignored.

Claude Code is installed via `cask 'claude-code@latest'`.

Neovim's tooling is in here too: LSP servers, formatters, linters, and the Go debug
adapter are Brewfile formulas rather than Mason packages, so `make update` keeps them
current with everything else. See `nvim/lua/plugins/mason.lua` for the Neovim half of
that split. Note `tflint` is a **cask** (`terraform-linters/tap/tflint`) — there is no
`tflint` formula, and `brew 'tflint'` fails the whole `brew bundle install`.

### Vim-aware pane navigation is duplicated in three places

`Ctrl-h/j/k/l` moves between panes, but passes through to Neovim when the focused pane
is running vim. The same contract is implemented independently in:

- `wezterm/wezterm.lua` — `isVim()` checks `pane:get_foreground_process_name()`
- `tmux/tmux.conf` — `$is_vim` shell-outs to `ps -o state= -o comm=`
- `nvim/lua/plugins/overrides.lua` — `numToStr/Navigator.nvim` handles the vim side

`Ctrl-/` (split down 20%) and `Ctrl-\` (split right 30%, launching `claude`) are
likewise bound in both WezTerm and tmux. **Change one, change all three** — a keybinding
added to only WezTerm silently does nothing under tmux.

### Neovim is a thin LazyVim overlay

`init.lua` is two lines into `config/lazy.lua`. Customization goes in exactly two
places: `lua/config/` (`options`/`keymaps`/`autocmds` — LazyVim loads these at fixed
points, and `options.lua` is currently comments only) and `lua/plugins/` (specs merged
over LazyVim's). `lazy-lock.json` is gitignored, so plugin versions are deliberately
not pinned across machines; `checker.enabled = true` polls for updates.

Mason stays enabled but is nearly idle. `lua/plugins/mason.lua` filters every
Homebrew-provided tool out of `mason.nvim`'s `ensure_installed`, and sets `mason = false`
on the matching LSP servers so LazyVim enables them from PATH via `vim.lsp.enable()`
instead of through `mason-lspconfig` — whose `automatic_enable` only starts servers it
installed itself, which is why that flag is load-bearing and not just cosmetic. Both
prunes must be `opts` **functions**: `mason.nvim` declares
`opts_extend = { "ensure_installed" }`, so an `opts` table would append to the list
rather than replace it. All Mason has left to install is `marksman`, skipped because its
formula depends on a full `dotnet@9` runtime.

The gotcha: `$XDG_DATA_HOME/nvim/mason/bin` precedes `$HOMEBREW_PREFIX/bin` in
`.zprofile`, so anything Mason has on disk **shadows the brew copy of the same tool**.
Adding a formula is therefore not enough — `:MasonUninstall` the old package too, or
nothing changes.

### Gitignore encodes a secrets/state boundary

Many directories here are runtime state written by tools, not configuration. `.gitignore`
excludes credentials (`alice/`, `aws-sso/`, `gh/hosts.yml`) and tool caches (`argocd/`,
`helm/`, `snyk/`, `containers/`, `configstore/`, `homebrew/trust.json`). Before adding a
new tool's directory, decide which side of that line it falls on — several ignored dirs
(`gcloud/`, `devin/`, `github-copilot/`) are listed but not currently present.

## Conventions

Conventional commits (`feat:`, `fix:`, `chore:`) with no ticket ID — this is a personal
repo, so the ticket-ID requirement in the global `~/.claude/CLAUDE.md` does not apply
here. Recent history is predominantly `chore:`.

`git/config` sets `pull.rebase`, `branch.autosetuprebase = always`, `push.default =
current`, `push.autoSetupRemote`, `delta` as pager, and `zdiff3` conflict style. Work
identity is layered via `includeIf "gitdir:~/work/"` → `~/work/.gitconfig`.

## Known drift

- **`~/.claude/CLAUDE.md` is hand-maintained and untracked.** The Makefile used to
  symlink repo-root `CLAUDE.md` over it; that target was removed because the global file
  had diverged. Global infra conventions live there, not here.
