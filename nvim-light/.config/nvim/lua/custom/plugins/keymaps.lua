vim.keymap.set('n', '<C-Left>', ':vert resize +1<CR>')
vim.keymap.set('n', '<C-Right>', ':vert resize -1<CR>')
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>bo', '%bdelete|edit #|normal`"', { desc = 'Close Other Buffers' })
vim.keymap.set('n', '<leader>yp', ':let @+ = expand("%")<CR>', { desc = 'Copy file path' })

return {}
