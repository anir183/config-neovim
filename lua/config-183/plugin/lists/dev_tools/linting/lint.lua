--[[ lint.lua: linting engine ]]

return {
	"mfussenegger/nvim-lint",
	name = "lint",
	dependencies = "mason",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = CONF_183.settings.linters
		lint.linters = CONF_183.settings.custom_linters

		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWritePre",
			"InsertLeave",
		}, {
			group = CONF_183.augrp,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>ln",
			function()
				require("lint").try_lint()
			end,
			desc = "[plugin/nvim-lint]: perform [L]i[N]ting on current file",
		},
	},
}
