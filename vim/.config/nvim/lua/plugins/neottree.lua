return {

  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "left",
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
    },
    default_component_configs = {
      git_base = "master",
    },
  },
  keys = {
    { "<leader>ge", "<cmd>:Neotree git_status git_base=master<cr>", desc = "󰙅 Git Explorer" },
  },
}
