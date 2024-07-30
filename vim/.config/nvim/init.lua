-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").tsserver.setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
})
