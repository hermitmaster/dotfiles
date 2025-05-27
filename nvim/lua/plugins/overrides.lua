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
        -- https://github.com/LazyVim/LazyVim/issues/6185#issuecomment-2978701551
        ["<Tab>"] = {
          require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
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
  {
    "Exafunction/codeium.nvim",
    enabled = os.getenv("USER") == "drausch",
  },
}
