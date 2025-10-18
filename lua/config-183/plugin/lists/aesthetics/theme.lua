--[[ theme.lua: using catppuccin frappe as editor theme ]]

return CONF_183.settings.module_toggles.plugin.aesthetics.theme and {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = CONF_183.lazy.plugin_priorities.high,
	opts = {
		flavour = "frappe",
		transparent_background = true,
		float = {
			transparent = true,
		},
		show_end_of_buffer = true
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ea999c", fg = "#232634" })
	end
} or {}
