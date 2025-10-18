--[[ ccc.lua: color picker ]]

return {
	"uga-rosa/ccc.nvim",
	name = "color-picker",
	opts = {},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>cp",
			function()
				vim.cmd.CccPick()
			end,
			desc = "[plugin/color-picker]: open [C]olor [P]icker",
		},
		{
			mode = "n",
			"<leader>ch",
			function()
				vim.cmd.CccHighlighterToggle()
			end,
			desc = "[plugin/color-picker]: toggle [C]olor [H]ighlighting",
		},
		{
			mode = "n",
			"<leader>cc",
			function()
				vim.cmd.CccConvert()
			end,
			desc = "[plugin/color-picker]: [C]onvert [C]olor",
		},
	},
}
