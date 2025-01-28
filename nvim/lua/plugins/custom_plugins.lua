return {
  {
    "numToStr/Navigator.nvim",
    opts = {
      {
        auto_save = nil,
        disable_on_zoom = false,
        mux = "auto",
      },
    },
    keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>" },
      { "<C-l>", "<cmd>NavigatorRight<cr>" },
      { "<C-k>", "<cmd>NavigatorUp<cr>" },
      { "<C-j>", "<cmd>NavigatorDown<cr>" },
      { "<C-\\>", "<cmd>NavigatorPrevious<cr>" },
    },
  },
}
