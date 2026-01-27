return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",  -- Use stable branch, not the rewrite
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
