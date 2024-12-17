return {
  {
    -- Override the default Copilot source with the native blink copilot source.
    -- The default source is a translation layer for a nvim-cmp source.
    "saghen/blink.cmp",
    dependencies = {
      "fang2hou/blink-copilot",
      {
        -- Disable the default copilot source
        "giuxtaposition/blink-cmp-copilot",
        enabled = false,
      },
    },
    opts = {
      sources = {
        providers = {
          copilot = {
            module = "blink-copilot",
            opts = {
              max_completions = 3,
              max_attempts = 4,
            },
          },
        },
      },
    },
  },
  {
    -- Add the golangci-lint to the enabled LSP servers.
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = { "golangci-lint" },
      },
    },
    opts = {
      servers = {
        golangci_lint_ls = {},
      },
    },
  },
  {
    -- Add the gci formatter to the formatters list for Go files.
    "stevearc/conform.nvim",
    requires = {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = { "gci" },
      },
    },
    opts = function(_, opts)
      local goprivate = os.getenv("GOPRIVATE")
      if goprivate == "hq-stash.corp.proofpoint.com" then
        opts.formatters.gci = {
          args = {
            "write",
            "--skip-generated",
            "--skip-vendor",
            "--custom-order",
            "-s",
            "standard",
            "-s",
            "default",
            "-s",
            "prefix(hq-stash.corp.proofpoint.com)",
            "-s",
            "prefix(github.com/PFPT)",
            "$FILENAME",
          },
        }
      end
      table.insert(opts.formatters_by_ft.go, "gci")
    end,
  },
  {
    -- Unhide filtered items in the filesystem tree.
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          visible = true,
        },
      },
    },
  },
  {
    -- Use super-tab keymap preset for blink.cmp.
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
}
