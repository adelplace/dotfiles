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
          path_display = { shorten = 4 },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          grep_string = {
            additional_args = { "--hidden" },
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
        },
      })
    end,
  },
}
