return {
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({
        tint = -30,  -- Negative value darkens unfocused windows
        saturation = 0.6,  -- Desaturate unfocused windows
        transforms = require("tint").transforms.SATURATE_TINT,
        tint_background_colors = true,
        highlight_ignore_patterns = { "WinSeparator", "Status.*" },
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
          -- Don't tint these special buffer types
          return buftype == "terminal"
            or buftype == "quickfix"
            or filetype == "neo-tree"
            or filetype == "alpha"
        end
      })
    end,
  }
}
