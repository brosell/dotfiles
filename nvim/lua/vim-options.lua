-- default indent (fallback)
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.opt.wrap = false

vim.opt.cursorline = true

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Set up line numbers
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

