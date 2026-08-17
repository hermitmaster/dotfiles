return {
  {
    -- Navigation between Neovim and Wezterm panes.
    "numToStr/Navigator.nvim",
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          -- Neo-tree maps <Tab> to "select" (multi-select) buffer-locally, which
          -- shadows the global <Tab> window-switch keymap. "noop" makes neo-tree
          -- skip creating the buffer-local map so the global one falls through.
          ["<Tab>"] = "noop",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          visible = true,
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
}
