return {
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()

      vim.keymap.set("n", "<C-h>", "<cmd>NavigatorLeft<cr>")
      vim.keymap.set("n", "<C-l>", "<cmd>NavigatorRight<cr>")
      vim.keymap.set("n", "<C-k>", "<cmd>NavigatorUp<cr>")
      vim.keymap.set("n", "<C-j>", "<cmd>NavigatorDown<cr>")
      vim.keymap.set("n", "<C-\\>", "<cmd>NavigatorPrevious<cr>")
    end,
  },
}
