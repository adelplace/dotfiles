return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>gx",
      function()
        Snacks.terminal("lazydiff", { cwd = LazyVim.root.git(), win = { style = "lazygit" } })
      end,
      desc = "LazyDiff",
    },
  },
}
