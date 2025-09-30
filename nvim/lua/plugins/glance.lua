return {
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
    config = function()
      require('glance').setup({
        -- detached = false,
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
        list = {
          position = 'left', -- Position of the list window 'left'|'right'
          width = 0.33, -- Width as percentage (0.1 to 0.5)
        },

        theme = {
          enable = true, -- Generate colors based on current colorscheme
          mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
      })

      -- vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
      -- vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
      -- vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
      -- vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
    end,
    keys = {
      { '<leader>gM', '<CMD>Glance implementations<CR>', mode = { 'n' }, },
      { '<leader>gD', '<CMD>Glance definitions<CR>', mode = { 'n' }, },
      { '<leader>gR', '<CMD>Glance references<CR>', mode = { 'n' }, },
      { '<leader>gY', '<CMD>Glance type_definitions<CR>', mode = { 'n' }, },
    },
  }
}
