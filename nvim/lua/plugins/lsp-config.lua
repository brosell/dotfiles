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

			-- Use vim.lsp.config instead of lspconfig
			vim.lsp.config('ts_ls', {
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
			vim.lsp.config('solargraph', {
				capabilities = capabilities,
			})
			vim.lsp.config('html', {
				capabilities = capabilities,
				handlers = handlers,
			})
			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
				handlers = handlers,
			})

			-- Enable the LSP servers
			vim.lsp.enable('ts_ls')
			vim.lsp.enable('solargraph')
			vim.lsp.enable('html')
			vim.lsp.enable('lua_ls')

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
			vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
			vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })

			vim.keymap.set("v", "qf", vim.lsp.buf.format, { remap = false })

			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { remap = false })
			-- Add border to the diagnostic popup window
			vim.diagnostic.config({
				virtual_text = {
					prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
				},
				float = { border = border },
			})

			-- K - hover with border, not focusable
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					vim.keymap.set('n', 'K', function()
						vim.lsp.buf.hover({border="single", focusable=false})
					end, {desc="lsp hover", buffer=args.buf})
					-- more keymaps here
				end})
		end,
	},
}
