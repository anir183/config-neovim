--[[ mason.lua: plugin for managing different dev tools ]]

return {
	"williamboman/mason.nvim",
	name = "mason",
	opts = {},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>mn",
			function()
				vim.cmd.Mason()
			end,
			desc = "[plugin/mason]: open [M]aso[N] window",
		},
	},
}
