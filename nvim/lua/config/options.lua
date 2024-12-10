-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.colorcolumn = "+1"
-- vim.opt.diffopt:append("vertical")
-- vim.opt.fillchars = { eob = " ", vert = "│" }
-- vim.opt.listchars = { eol = "↵", extends = "↷", precedes = "↶", tab = "→ " }

vim.filetype.add({
  extension = {
    tfvars = "terraform",
  },
})
