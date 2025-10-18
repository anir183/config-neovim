--[[ oil.lua: editable file explorer ]]

return {
	"stevearc/oil.nvim",
	name = "oil",
	dependencies = "devicons",
	opts = {
		default_file_explorer = false,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
		},
	},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>E",
			function()
				vim.cmd.Oil()
			end,
			desc = "[plugin/oil]: open the oil file [E]xplorer",
		},
	},
}
