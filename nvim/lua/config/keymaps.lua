-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Tab>", "<cmd>wincmd w<cr>", { desc = "Next Window" })
vim.keymap.set("n", "<S-Tab>", "<cmd>wincmd W<cr>", { desc = "Previous Window" })