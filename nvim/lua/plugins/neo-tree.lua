local function show_neo_tree_hover(state)
	if vim.g.neo_tree_hover_win and vim.api.nvim_win_is_valid(vim.g.neo_tree_hover_win) then
		vim.api.nvim_win_close(vim.g.neo_tree_hover_win, true)
	end

	local node = state.tree:get_node()
	if not node then
		return
	end

	local full_path = node:get_id()
	local filename = node.name
	local _, hover_win = vim.lsp.util.open_floating_preview(
		{ "# " .. filename, "", "Path: " .. full_path },
		"markdown",
		{ border = "rounded", focusable = false }
	)

	vim.g.neo_tree_hover_win = hover_win
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		window = {
			mappings = {
				["K"] = show_neo_tree_hover,
				["L"] = function(state)
					local bufnr = state.bufnr
					local group = vim.api.nvim_create_augroup("NeoTreeHoverToggle_" .. bufnr, { clear = true })

					if vim.b[bufnr].neo_tree_hover_toggle then
						vim.b[bufnr].neo_tree_hover_toggle = false
						vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
						if vim.g.neo_tree_hover_win and vim.api.nvim_win_is_valid(vim.g.neo_tree_hover_win) then
							vim.api.nvim_win_close(vim.g.neo_tree_hover_win, true)
						end
						return
					end

					vim.b[bufnr].neo_tree_hover_toggle = true

					vim.api.nvim_create_autocmd("CursorMoved", {
						group = group,
						buffer = bufnr,
						callback = function()
							if vim.b[bufnr].neo_tree_hover_toggle then
								show_neo_tree_hover(state)
							end
						end,
					})

					show_neo_tree_hover(state)
				end,
			},
		},
	},
	config = function(_, opts)
		-- Pass the opts table into the setup function
		require("neo-tree").setup(opts)

		-- Your existing custom global keymaps
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
