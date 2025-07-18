-- Set up auto indent behavior to always match the existing file
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = false
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

