--[[ repl_highlights.lua: highlighting in the dap ui repl window ]]

return pcall(require, "nvim-treesitter")
		and {
			"LiadOz/nvim-dap-repl-highlights",
			name = "dap-repl-highlights",
			dependencies = "treesitter",
		}
	or {}
