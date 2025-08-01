-- Set up auto indent behavior to always match the existing file
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = false
vim.opt.wrap = false

vim.opt.cursorline = true

-- Enhanced cursorline highlight override after theme load
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#383c44" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#383c44", fg = "#ffffff", bold = true })
  end,
})

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

