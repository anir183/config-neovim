--[[ breadcrumbs.lua: breadcrumbs bar ]]

return {
	"SmiteshP/nvim-navic",
	name = "navic",
	opts = {
		lsp = {
			auto_attach = true,
		},
	},
	config = function(_, opts)
		local navic = require("nvim-navic")

		navic.setup(opts)

		vim.api.nvim_create_autocmd("CursorMoved", {
			group = CONF_183.augrp,
			callback = function()
				if navic.is_available() then
					vim.opt.winbar = '%{%v:lua.require("nvim-navic")' ..
										".get_location()%}"
				else
					vim.opt.winbar = ""
				end
			end,
		})
	end,
}
