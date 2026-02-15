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
      session_name = function()
        -- Get current directory name
        local root = vim.fn.getcwd()
        local pwd = vim.fn.fnamemodify(root, ":t")

        -- Try to get git branch name
        local branch = ""
        local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
        if handle then
          branch = handle:read("*a"):gsub("%s+", "")
          handle:close()
        end

        -- Build name: pwd_branch or just pwd
        local name = pwd
        if branch ~= "" then
          name = pwd .. "_" .. branch
        end

        -- Sanitize: replace problematic characters with hyphens
        -- Replace: / \ : * ? " < > | and spaces
        name = name:gsub("[/\\:*?\"<>| ]", "-")
        return name
      end,

      -- show vim.notify messages
      notify = true,

      -- keybindings
      keys = {
        annotate = "<leader>ma",       -- visual mode
        -- start_session = "<leader>ms",  -- normal mode
        -- stop_session = "<leader>mq",   -- normal mode
        -- toggle_window = "<leader>mw",  -- normal mode
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
