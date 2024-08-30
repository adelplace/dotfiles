return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "shfmt",
        "stylua",
        "shellcheck",
        "delve",
        "sql-formatter",
      },
    },
  },
}
