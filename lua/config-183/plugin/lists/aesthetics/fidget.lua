--[[ fidget.lua: lsp progress visualizer and vim.notify handler ]]

return {
	"j-hui/fidget.nvim",
	name = "fidget",
	opts = {
		notification = {
			override_vim_notify = true,
			view = {
				group_separator_hl = "Normal",
			},
			window = {
				normal_hl = "Normal",
				winblend = 0,
				y_padding = 2,
			},
		},
	},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>nh",
			"<CMD>Fidget history<CR>",
			desc = "[plugin/fidget]: open [N]otification [H]istory",
		},
		{
			mode = "n",
			"<leader>nc",
			"<CMD>Fidget clear<CR>",
			desc = "[plugin/fidget]: [N]otifications [C]leared",
		},
	},
}
