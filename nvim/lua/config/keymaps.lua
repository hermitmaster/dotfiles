-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<Tab>", "<cmd>wincmd w<cr>", { desc = "Next Window" })
vim.keymap.set("n", "<S-Tab>", "<cmd>wincmd W<cr>", { desc = "Previous Window" })

-- Navigator.nvim keymaps
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Go to Left Window" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Go to Right Window" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Go to Upper Window" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Go to Lower Window" })
vim.keymap.set({ "n", "t" }, "<C-\\>", "<CMD>NavigatorPrevious<CR>", { desc = "Go to Previous Window" })
