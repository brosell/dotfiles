return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim', },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>oe", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "x" }, "<leader>op", function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
    vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
    vim.keymap.set("n",        "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
    vim.keymap.set("n",        "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
  end
}
