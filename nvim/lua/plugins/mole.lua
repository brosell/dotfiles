return {
  "zion-off/mole.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
  config = function()
    require("mole").setup({
      -- where session files are saved
      session_dir = vim.fn.stdpath("data") .. "/mole", -- ~/.local/share/nvim/mole

      -- "location" = file path + line range
      -- "snippet" = file path + line range + selected text in a fenced code block
      capture_mode = "snippet",

      -- open the side panel automatically when starting a session
      auto_open_panel = true,

      -- custom session name: nil = timestamp, string = fixed name, function = called to get name
      session_name = nil,

      -- show vim.notify messages
      notify = true,

      -- keybindings
      keys = {
        annotate = "<leader>ma",       -- visual mode
        start_session = "<leader>ms",  -- normal mode
        stop_session = "<leader>mq",   -- normal mode
        toggle_window = "<leader>mw",  -- normal mode
      },

      -- side panel
      window = {
        width = 0.3, -- fraction of editor width
      },

      -- inline input popup
      input = {
        width = 50,
        border = "rounded",
      },
    })
  end,
}
