return {
    'github/copilot.vim',
    config = function ()
      -- Set up Copilot with custom key mappings
      -- vim.g.copilot_no_tab_map = true
		      -- vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
		      -- vim.api.nvim_set_keymap('i', '<C-k>', 'copilot#Accept("<C-k>")', { expr = true, silent = true, noremap = true })
		      -- vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("<C-l>")', { expr = true, silent = true, noremap = true })
		      -- vim.api.nvim_set_keymap('i', '<C-h>', 'copilot#Accept("<C-h>")', { expr = true, silent = true, noremap = true })
								--
    end,
    opts = {
        -- add any options here
    }
}


