return {
  {
    -- Add golangci_lint_ls to the enabled LSP servers.
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = { "golangci-lint" },
        },
      },
    },
    opts = {
      servers = {
        golangci_lint_ls = {},
      },
    },
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
  {
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
  },
  {
    -- Add the gci formatter to the formatters list for Go files.
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = { "gci" },
      },
    },
    opts = function(_, opts)
      table.insert(opts.formatters_by_ft.go, "gci")

      local goprivate = os.getenv("GOPRIVATE") or ""

      if goprivate then
        opts.formatters.gci = {
          append_args = {
            "--custom-order",
            "-s",
            "standard",
            "-s",
            "default",
          },
        }
        for entry in string.gmatch(goprivate, "([^,]+)") do
          vim.list_extend(opts.formatters.gci.append_args, { "-s", "prefix(" .. entry .. ")" })
        end
      end
    end,
  },
}
