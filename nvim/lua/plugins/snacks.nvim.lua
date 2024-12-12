return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { title = "Recent Files", padding = 1 },
          { section = "recent_files", cwd = true, limit = 10, padding = 3 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys", padding = 3 },
          { section = "startup" },
        },
      },
    },
  },
}
