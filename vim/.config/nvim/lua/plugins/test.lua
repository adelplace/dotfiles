return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "olimorris/neotest-phpunit",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run Watch",
      },
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "./node_modules/.bin/jest --maxWorkers=1",
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        ["neotest-phpunit"] = {},
      },
    },
  },
}
