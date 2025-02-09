-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- substitute
vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

function InsertCucumberCmd()
  local filepath = vim.fn.expand("%:.")
  local lnumbr = vim.fn.search("Scenario:", "cbn")
  local scenario = vim.fn.substitute(vim.fn.getline(lnumbr), "Scenario: ", "", "g")
  local cucumber = "npm run cucumber " .. filepath .. ' -- --name="' .. vim.fn.trim(scenario) .. '"'
  vim.fn.setreg("+", cucumber) -- write to clippoard
end
vim.keymap.set("n", "<leader>tx", InsertCucumberCmd, { noremap = true, silent = true, desc = "Copy cucumber cmd" })

vim.api.nvim_set_keymap("n", "<leader>pa", "ggVGp", { noremap = true, silent = true, desc = "Select all & past" })
vim.api.nvim_set_keymap("n", "<leader>sa", "ggVG", { noremap = true, silent = true, desc = "Select all" })

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

local tb = require("telescope.builtin")

vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]], { desc = "Replace" })
vim.keymap.set("v", "<space>ss", function()
  tb.live_grep({ default_text = vim.getVisualSelection() })
end, { desc = "Search" })

vim.keymap.set("v", "<space>sR", function()
  local pattern = vim.fn.input("Search pattern: ")
  return vim.cmd(":%s/" .. vim.getVisualSelection() .. "/" .. pattern .. "/gc")
end, { desc = "Replace" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts" },
  callback = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.removeUnusedImports" },
        diagnostics = {},
      },
    })
  end,
})
