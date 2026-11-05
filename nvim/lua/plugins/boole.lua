return {
  "nat-418/boole.nvim",
  config = function()
    local CHECKBOXES = { "[ ]", "[/]", "[x]", "[-]" }

    local function cycle_task_checkbox()
      local line = vim.api.nvim_get_current_line()
      local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1

      for i, state in ipairs(CHECKBOXES) do
        local start_col, end_col = line:find(state, 1, true)
        if start_col and cursor_col >= start_col and cursor_col <= end_col then
          local prev_i = i - 1
          if prev_i < 1 then
            prev_i = #CHECKBOXES
          end
          local next_state = CHECKBOXES[prev_i]
          vim.api.nvim_set_current_line(
            line:sub(1, start_col - 1) .. next_state .. line:sub(end_col + 1)
          )
          return true
        end
      end

      return false
    end

    local boole = require("boole")
    boole.setup({
      mappings = {
        increment = "<C-a>",
      },
      additions = {
        { "public", "private", "protected" },
        { "describe", "fdescribe", "xdescribe" },
        { "it", "xit", "fit" },
        { "let", "const" },
      },
    })

    vim.keymap.set({ "n", "v" }, "<C-x>", function()
      if vim.fn.mode() == "n" and cycle_task_checkbox() then
        return
      end
      boole.run("decrement")
    end, { desc = "Decrement / cycle task checkbox" })
  end,
}
