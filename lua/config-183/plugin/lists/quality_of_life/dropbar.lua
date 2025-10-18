--[[ dropbar.lua: breadcrumbs and dropbar ]]

return {
	"Bekaboo/dropbar.nvim",
	name = "dropbar",
	dependencies = "devicons",
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>;",
			function() require("dropbar.api").pick() end,
			desc = "[plugin/dropbar]: pick symbols in winbar"
		},
	},
}
