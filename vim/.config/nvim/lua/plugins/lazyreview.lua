return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>gv",
      function()
        Snacks.terminal("lazyreview", { cwd = LazyVim.root.git(), win = { style = "lazygit" } })
      end,
      desc = "LazyReview",
    },
  },
}
