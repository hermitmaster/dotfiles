-- Tooling -- LSP servers, formatters, linters, debug adapters -- is installed by
-- Homebrew from homebrew/Brewfile, not by Mason.
--
-- Mason itself stays enabled on purpose, so anything without a formula is still
-- installed automatically. All this file does is prune the tools Homebrew already
-- put on PATH out of Mason's install lists, so the two stop duplicating work.
--
-- To hand a tool back to Mason, remove it from the relevant list below (and from
-- the Brewfile).

-- Mason package names, as they appear in mason.nvim's `ensure_installed`: the
-- non-LSP tools, plus delve for nvim-dap.
local brew_tools = {
  "delve",
  "gofumpt",
  "goimports",
  "golangci-lint",
  "hadolint",
  "markdown-toc",
  "markdownlint-cli2",
  "prettier",
  "shellcheck",
  "shfmt",
  "stylua",
  "tflint",
}

-- lspconfig server names. `marksman` is deliberately absent: its Homebrew formula
-- depends on a full dotnet@9 runtime, so Mason keeps managing its 42MB
-- self-contained binary instead.
local brew_servers = {
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "gopls",
  "helm_ls",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff",
  "taplo",
  "terraformls",
  "yamlls",
}

return {
  {
    "mason-org/mason.nvim",
    -- `opts` has to be a function here, not a table: mason.nvim declares
    -- `opts_extend = { "ensure_installed" }`, so a table would append to the list
    -- instead of replacing it. A function receives the list already merged from
    -- LazyVim core and every enabled extra, which is what we filter.
    opts = function(_, opts)
      local drop = {}
      for _, tool in ipairs(brew_tools) do
        drop[tool] = true
      end
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not drop[tool]
      end, opts.ensure_installed or {})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- `mason = false` does two things: it keeps the server out of
    -- mason-lspconfig's `ensure_installed`, and it makes LazyVim call
    -- `vim.lsp.enable()` on the server directly. The second half is the important
    -- one -- mason-lspconfig's `automatic_enable` only enables servers it
    -- installed itself, so without this the server would be configured but never
    -- actually started.
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      for _, server in ipairs(brew_servers) do
        local sopts = opts.servers[server]
        -- `server = true` is LazyVim shorthand for "default options".
        if sopts == true then
          sopts = {}
          opts.servers[server] = sopts
        end
        -- Skip anything no enabled extra configures (nil) or that has been
        -- explicitly disabled (false) -- don't resurrect either.
        if type(sopts) == "table" then
          sopts.mason = false
        end
      end
    end,
  },
}
