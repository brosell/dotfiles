return {
  {
    "gpanders/editorconfig.nvim",
    lazy = false,
  },
  {
    "tpope/vim-sleuth",
    lazy = false,
    config = function()
      -- Keybindings
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Format visual selection (indents using =)
      -- Select with V or v, then press <Leader>= (e.g., \= or ,=)
      keymap("v", "<Leader>=", "=", { desc = "Indent selection" })

      -- LSP format current buffer
      -- Press <Leader>f in normal mode to format buffer via LSP
 --      keymap("n", "<Leader>f", function()
	-- if vim.lsp.buf.server_ready() then
	--   vim.lsp.buf.format({ async = true })
	-- else
	--   vim.notify("LSP is not attached to this buffer", vim.log.levels.WARN)
	-- end
 --      end, { desc = "Format buffer via LSP", silent = true })	
    end,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  }
}



