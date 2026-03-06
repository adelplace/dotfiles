return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
      javascript = {},
      javascriptreact = {},
      typescript = {},
      typescriptreact = {},
      vue = {},
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = {
          "--config",
          vim.fn.stdpath("config") .. "/lua/plugins/cfg_linters/global.markdownlint-cli2.yaml",
          "--",
        },
      },
    },
  },
}
