return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      { "<leader>C", group = "Copilot" },
      { "<leader>Cc", "<cmd>CopilotChatOpen<CR>", desc = "Open Copilot Chat" },
      { "<leader>Cs", "<cmd>CopilotChatClose<CR>", desc = "Close Copilot Chat" },
    },
  },
}
