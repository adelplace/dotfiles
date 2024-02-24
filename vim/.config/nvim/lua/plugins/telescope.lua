return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            vertical = {
              width = 0.95,
            },
            horizontal = {
              width = 0.95,
            },
          },
          path_display = { "truncate" },
        },
      })
    end,
  },
}
