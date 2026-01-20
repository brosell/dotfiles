return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then return tail end
          return string.format("%s\t\t%s", tail, parent)
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "TelescopeResults",
          callback = function(ctx)
            vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          git_status = { path_display = filenameFirst, },
          find_files = { path_display = filenameFirst, },
          oldfiles = { path_display = filenameFirst, },
          live_grep = { path_display = filenameFirst, },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      -- vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
