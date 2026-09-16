# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This repo **is** `~/.config` itself — it is cloned directly to `$XDG_CONFIG_HOME`, not
symlinked into place from elsewhere. Editing a file here edits the live config for the
running tool. There is no build step and no "deploy": consequences are immediate.

The only exception is the three zsh dotfiles, which must live at `$HOME` and are
symlinked out of `zsh/` by `make link`.

macOS-only (Apple Silicon; Intel is not supported), zsh-only.

## Commands

```bash
make install     # Full setup: check-deps homebrew link packages nvim
make bootstrap   # Minimal: check-deps homebrew link (no packages)
make update      # brew update && upgrade && bundle install --global, bundle cleanup, then nvim
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
  interpolate them (`GOPATH`, `JAVA_HOME`, `STARSHIP_CONFIG`). Never set PATH here.
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

### The prompt is starship, at a non-default path

`starship/starship.toml` is a replica of the Pure prompt that `.zshrc` used to build
out of `zstyle` calls, down to the ANSI palette indexes and the one-line layout that
Pure needed `prompt_newline=' '` plus `PROMPT=" $PROMPT"` to produce.

**It is only found there because `.zshenv` exports `STARSHIP_CONFIG`.** starship's own
default is `$XDG_CONFIG_HOME/starship.toml` — the repo root — so the config goes
inert, silently falling back to starship's stock preset, if that export is ever
dropped. The nested path exists to match every other tool's directory.

Two Pure behaviours did not survive and are not recoverable through config: starship
renders synchronously and never background-fetches, so the git segment can lag on a
large repo and `⇡`/`⇣` only move after a manual fetch. Inside `starship.toml`, the
zero-width spaces in `[git_status]` are load-bearing — they let one conditional group
emit exactly one `*`; replacing them with `''` kills the dirty marker.

### Brewfile is the single source of truth for packages

`homebrew/Brewfile` is consumed via `brew bundle install --global`, and `make update`
follows it with `brew bundle cleanup --global --force`, so **anything not in the
Brewfile gets uninstalled**. Adding a tool means adding it here, not `brew install`-ing
it.

Cleanup is an explicit `make update` step, not an ambient setting: it used to ride on a
`HOMEBREW_BUNDLE_INSTALL_CLEANUP=1` export in `.zshenv`, which Homebrew deprecated in
favour of the standalone subcommand. Because that export reached every shell, it also
made a bare `brew bundle install` (and `make packages`) uninstall things as a side
effect — cleanup now happens only where it is written down.

The file branches on `ENV['USER'] == 'hermitmaster'` (personal) vs else (work): work
machines get `azure-cli`, `kubelogin`, `snyk-cli`, `yubico-authenticator`; the personal
machine gets `openemu` and Homebrew-core `opencode`. Tap trust is declared inline
(`trusted: true`) rather than in `homebrew/trust.json`, which is gitignored.

Claude Code is installed via `cask 'claude-code@latest'`.

Neovim's tooling is deliberately *not* in here: LSP servers, formatters, linters, and
the Go debug adapter are Mason's job, so they update on Mason's schedule rather than
with `make update`.

`tflint` used to be the one exception, pinned as a **cask**
(`terraform-linters/tap/tflint`) because no `tflint` formula exists — and `brew
'tflint'` fails the whole `brew bundle install`. It was dropped: the enabled
`lazyvim.plugins.extras.lang.terraform` extra means Mason installs it, so the cask was
only shadowed. If you ever put it back, it is a `cask`, never a `brew`.

### Vim-aware pane navigation is split across two files

`Ctrl-h/j/k/l` moves between panes, but passes through to Neovim when the focused pane
is running vim. The two halves of that contract live in:

- `wezterm/wezterm.lua` — `isVim()` checks `pane:get_foreground_process_name()`
- `nvim/lua/plugins/overrides.lua` — `numToStr/Navigator.nvim` handles the vim side

`Ctrl-/` (split down 20%) and `Ctrl-\` (split right 30%, launching `claude`) are bound
in WezTerm only. **Change one, change both** — the terminal and the Neovim side have to
agree or a keystroke is swallowed by whichever one is not expecting it.

tmux used to be a third implementation of the same contract; it was removed, so WezTerm
is now the only multiplexer.

### Neovim is a thin LazyVim overlay

`init.lua` is two lines into `config/lazy.lua`. Customization goes in exactly two
places: `lua/config/` (`options`/`keymaps`/`autocmds` — LazyVim loads these at fixed
points, and `options.lua` is currently comments only) and `lua/plugins/` (specs merged
over LazyVim's). `lazy-lock.json` is gitignored, so plugin versions are deliberately
not pinned across machines; `checker.enabled = true` polls for updates.

Mason owns Neovim's tooling end to end — LSP servers, formatters, linters, and the Go
debug adapter all come from whatever LazyVim and its enabled extras put in
`ensure_installed`. There is no `lua/plugins/mason.lua`; the repo does not override any
of it. This was briefly inverted (Brewfile formulas plus a prune spec) and reverted,
so tools like `gopls`, `stylua`, `shellcheck`, and `tflint` are intentionally absent
from the Brewfile — adding one back there does **not** hand the tool to Homebrew on
its own.

The reason: `$XDG_DATA_HOME/nvim/mason/bin` precedes `$HOMEBREW_PREFIX/bin` in
`.zprofile`, so anything Mason has on disk **shadows the brew copy of the same tool**.
Going the other way means `:MasonUninstall` plus a `mason = false` on the matching
lspconfig server (`mason-lspconfig`'s `automatic_enable` only starts servers it
installed itself), which is exactly the complexity this revert removed.

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
