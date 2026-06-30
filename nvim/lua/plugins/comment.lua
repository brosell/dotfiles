return {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
        require('Comment').setup({
            pre_hook = function(ctx)
                local ok, parser = pcall(vim.treesitter.get_parser, 0)
                if ok and parser then
                    parser:parse()
                end
                local ts_result = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
                -- Always return a commentstring so Comment.nvim never falls through
                -- to its own ft.calculate, which uses a deprecated treesitter API on nvim 0.12+
                return ts_result or vim.bo.commentstring
            end,
        })
    end,
}

-- Normal mode
--  gcc - line style comment
--  gbc - block style comment
--  gcO - comment line above
--  gco - comment below
--  gcA - comment end of line
-- Visual Mode
--  gc
--  gb
