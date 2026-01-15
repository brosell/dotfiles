-- default indent (fallback)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = false

-- Cursorline only in active window
vim.opt.cursorline = true

-- Auto commands for cursorline management
vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = "CursorLineOnlyInActiveWindow",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = "CursorLineOnlyInActiveWindow", 
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.opt.colorcolumn = "100"                        -- Show column at 100 characters

vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor

vim.g.blamer_min_offset_column = 100
vim.g.blamer_date_format = '%Y-%m-%d'

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- use system clipboard by default
vim.opt.clipboard = "unnamedplus"
-- copy to xclip to windows clipboard
vim.keymap.set('v', '<leader>yx', ':w !xclip -selection clipboard<CR>', { noremap = true, silent = true })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- natural cursor movement when wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', '<Down>', 'gj')
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', '<Down>', '<C-o>gj')
vim.keymap.set('i', '<Up>', '<C-o>gk')

-- Split behavior
vim.opt.splitbelow = false                          -- Horizontal splits go below
vim.opt.splitright = true                          -- Vertical splits go right

-- Set up line numbers
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

-- clear highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- Folding settings
vim.opt.foldmethod = "expr"                             -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99                                  -- Start with all folds open

-- Spelling
vim.opt.spell = true
vim.keymap.set('n', '<C-z>', 'z=1<CR>', {desc='Fix spelling'})
vim.opt.spelloptions:append("camel")

-- Markdown table format shortcut
-- map <Leader>| in visual mode to format the selection as a table
-- requires `apt install bsdmainutils`
vim.keymap.set('v', '<Leader>|', ":!column -t -s '|' -o '|'<CR>", { desc = "Format Markdown Table with column" })


-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function FloatingTerminal()
    -- If terminal is already open, close it (toggle behavior)
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    -- Create buffer if it doesn't exist or is invalid
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        -- Set buffer options for better terminal experience
        vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
    end

    -- Calculate window dimensions
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Set transparency for the floating window
    vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

    -- Set transparent background for the window
    vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
        'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

    -- Define highlight groups for transparency
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

    -- Start terminal if not already running
    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in ipairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    -- Set up auto-close on buffer leave 
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc><Esc>", function()
    if terminal_state.is_open then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

