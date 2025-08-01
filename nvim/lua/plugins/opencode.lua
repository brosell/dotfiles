return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim', },
  ---@type opencode.Config
  opts = {
    -- Set these according to https://models.dev/
    provider_id = vim.env.OPENCODE_PROVIDER_ID or "openai",
    model_id = vim.env.OPENCODE_MODEL_ID or "codex-mini-latest",
  },
  -- stylua: ignore
  keys = {
    { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
    { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
    { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
    { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select opencode prompt', mode = { 'n', 'v', }, },
    { '<leader>on', function() require('opencode').create_session() end, desc = 'New session', },
  },
}
