return {
  {
    "hachy/cmdpalette.nvim",
    config = function()
      require("cmdpalette").setup({
        win = {
          height = 0.3,
          width = 0.5,
          border = "rounded",
        }
      })

      vim.keymap.set("n", "<leader>:", "<Plug>(cmdpalette)")
    end,
  },
}
