return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim", -- optional
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>Xc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    {
      "<leader>Xe",
      "<cmd>ChatGPTEditWithInstruction<CR>",
      desc = "Edit with instruction",
    },
    {
      "<leader>Xg",
      "<cmd>ChatGPTRun grammar_correction<CR>",
      desc = "Grammar Correction",
    },
    { "<leader>Xt", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
    { "<leader>Xk", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
    { "<leader>Xd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
    { "<leader>Xa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
    { "<leader>Xc", "<cmd>ChatGPTCompleteCode<CR>", desc = "Complete" },
    {
      "<leader>Xo",
      "<cmd>ChatGPTRun optimize_code<CR>",
      desc = "Optimize Code",
    },
    { "<leader>Xs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
    { "<leader>Xf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
    {
      "<leader>Xx",
      "<cmd>ChatGPTRun explain_code<CR>",
      desc = "Explain Code",
    },
    {
      "<leader>Xr",
      "<cmd>ChatGPTRun roxygen_edit<CR>",
      desc = "Roxygen Edit",
    },
    {
      "<leader>Xl",
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      desc = "Code Readability Analysis",
    },
  },
}
