return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
  {
    -- Navigation between Neovim and Wezterm panes.
    "numToStr/Navigator.nvim",
    opts = {},
  },
  {
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
    -- Add the gci formatter to the formatters list for Go files.
    "stevearc/conform.nvim",
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
            "-s",
            "prefix(hq-stash.corp.proofpoint.com)",
            "-s",
            "prefix(github.com/PFPT)",
            "-s",
            "dot",
            "-s",
            "alias",
            "-s",
            "localmodule",
          },
        }
      end
    end,
  },
}
