return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()

			local border = {
				{ '┌', 'FloatBorder' },
				{ '─', 'FloatBorder' },
				{ '┐', 'FloatBorder' },
				{ '│', 'FloatBorder' },
				{ '┘', 'FloatBorder' },
				{ '─', 'FloatBorder' },
				{ '└', 'FloatBorder' },
				{ '│', 'FloatBorder' },
			}

			-- Add the border on hover and on signature help popup window
			local handlers = {
				['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				handlers = handlers,
				settings = {
					typescript = {
						preferences = {
							importModuleSpecifier = "relative"
						}
					}
				}
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
			vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
			vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })

			vim.keymap.set("v", "qf", vim.lsp.buf.format, { remap = false })

			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { remap = false })
			-- Add border to the diagnostic popup window
			vim.diagnostic.config({
				virtual_text = {
					prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
				},
				float = { border = border },
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
	}
}
