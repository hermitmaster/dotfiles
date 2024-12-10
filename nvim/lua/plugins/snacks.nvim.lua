return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "header" },
          { title = "Recent Files", padding = 1 },
          { section = "recent_files", cwd = true, limit = 10, padding = 1 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys", padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
