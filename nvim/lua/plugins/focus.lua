return {
  {
    "nvim-focus/focus.nvim",
    version = "*",
    config = function()
      require("focus").setup({
        enable = true,
        commands = true,
        autoresize = {
          enable = true,
          width = 0,
          height = 0,
          minwidth = 0,
          minheight = 0,
          height_quickfix = 10,
        },
        split = {
          bufnew = false,
          tmux = false,
        },
        ui = {
          number = false,
          relativenumber = false,
          hybridnumber = false,
          absolutenumber_unfocussed = false,
          cursorline = true,
          cursorcolumn = false,
          colorcolumn = {
            enable = false,
            list = '+1',
            width = 120,
          },
          signcolumn = true,
          winhighlight = true,
        }
      })
      -- Custom highlight groups for better visual distinction
      local function setup_highlights()
        -- Focused window
        vim.api.nvim_set_hl(0, "FocusedWindow", { bg = "NONE" })
        -- Unfocused window - slightly dimmed
        vim.api.nvim_set_hl(0, "UnfocusedWindow", {
          bg = "#2a2a2a",
          blend = 10 
        })
        -- Window separators
        vim.api.nvim_set_hl(0, "WinSeparator", {
          fg = "#89b4fa",  -- Catppuccin blue
          bold = true
        })
      end
      -- Apply highlights after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = setup_highlights,
      })
      -- Apply highlights immediately
      setup_highlights()
      -- Key mappings for focus management
      vim.keymap.set('n', '<leader>wf', ':FocusToggle<CR>', { desc = "Toggle Focus" })
      vim.keymap.set('n', '<leader>we', ':FocusEqualise<CR>', { desc = "Equalise Windows" })
      vim.keymap.set('n', '<leader>wm', ':FocusMaximise<CR>', { desc = "Maximise Window" })
    end,
  }
}
