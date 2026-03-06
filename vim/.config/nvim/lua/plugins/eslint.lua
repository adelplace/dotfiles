return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
              "eslint.config.js",
              "eslint.config.cjs",
              "eslint.config.mjs",
              "package.json",
              ".git"
            )(fname)
          end,
          settings = {
            useFlatConfig = true,
            workingDirectory = { mode = "auto" },
          },
        },
      },
    },
  },
}
