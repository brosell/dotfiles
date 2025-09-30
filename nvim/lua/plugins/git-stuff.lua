return {
  {
    "tpope/vim-fugitive"
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
    end
  },
  {
    'oribarilan/lensline.nvim',
    -- https://github.com/oribarilan/lensline.nvim
    -- tag = '2.0.0', -- or: 
    branch = 'release/2.x',  -- for latest non-breaking updates
    event = 'LspAttach',
    config = function()
      require('lensline').setup {
        profiles = {
          {
            name = 'minimal',
            style = {
              placement = 'inline',
              prefix = '',
              render = "focused", -- optionally render lenses only for focused function
            },
          },
        },
      }
    end,
  }
}
