return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        cssls = {},
        html = {},
        terraformls = {
          filetypes = {
            "hcl",
            "terraform",
            "terraform-vars",
          },
        },
      },
    },
  },
}
