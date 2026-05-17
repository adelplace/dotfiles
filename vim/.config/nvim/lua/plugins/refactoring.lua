return {
  {
    "ThePrimeagen/refactoring.nvim",
    config = function(_, opts)
      require("refactoring").setup(opts)
      -- refactoring.nvim has no telescope extension; skip load_extension
    end,
  },
}
