return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            vim.fn.expand("~/.config/markdownlint-cli2/.markdownlint-cli2.yaml"),
            "--",
          },
        },
      },
    },
  },
}
