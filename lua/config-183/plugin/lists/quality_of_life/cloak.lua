--[[ cloak.lua: hide sensitive tokens ]]

return {
	"laytan/cloak.nvim",
	name = "cloak",
	opts = {
		cloak_character = "*",
		patterns = CONF_183.settings.cloak_patterns,
	},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>ct",
			function() vim.cmd.CloakToggle() end,
			desc = "[plugin/cloak]: [C]loak hiding [T]oggle"
		},
		{
			mode = "n",
			"<leader>CT",
			function() vim.cmd.CloakPreviewLine() end,
			desc = "[plugin/cloak]: [C]loak curren[T] line preview"
		},
	},
}
