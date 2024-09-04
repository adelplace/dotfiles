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
  local cucumber = "npm run cucumber " .. filepath
  vim.fn.setreg("+", cucumber) -- write to clippoard
end

vim.keymap.set("n", "<leader>tx", InsertCucumberCmd, { noremap = true, silent = true, desc = "Copy cucumber cmd" })
