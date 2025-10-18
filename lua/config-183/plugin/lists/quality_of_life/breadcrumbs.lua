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
				-- get breadcrumbs location and trim it
				local location = (navic.get_location() or ""):gsub("%s+", "")

				-- hide winbar if no data availabel or data is empty
				if navic.is_available() and location ~= "" then
					vim.opt.winbar = "%{%v:lua.require(\"nvim-navic\")"
						.. ".get_location()%}"
				else
					vim.opt.winbar = ""
				end
			end,
		})
	end,
}
