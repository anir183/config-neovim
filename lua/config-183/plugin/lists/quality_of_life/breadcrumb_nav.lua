--[[ breadcrumb_nav.lua: navigate through breadcrumbs ]]

return {
	"hasansujon786/nvim-navbuddy",
	name = "navbuddy",
	dependencies = { "lspconfig", "navic", "comment", "nui" },
	opts = {
		window = {
			size = {
				height = "70%",
				width = "80%",
			},
		},
		lsp = {
			auto_attach = true,
		},
		custom_hl_group = "Visual",
	},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>bn",
			function()
				require("nvim-navbuddy").open()
			end,
			desc = "[plugin/navbuddy]: open [B]readcrumbs [N]avigation",
		},
	},
}
