--[[ signature.lua: lsp signatures ]]

return {
	"ray-x/lsp_signature.nvim",
	name = "lsp-signature",
	opts = {
		floating_window = false,
		floating_window_off_x = 2,
		floating_window_off_y = 1,
		doc_lines = 0,
		hint_prefix = {
			above = "🡯 ",
			current = "🡨 ",
			below = "🡬 ",
		},
		handler_opts = {
			border = "none",
		},
	},
	lazy = false,
	keys = {
		{
			mode = { "i", "s", "n" },
			"<C-h>",
			function() require("lsp_signature").toggle_float_win() end,
			desc = "[plugin/lsp_signature]: toggle signature widow",
		},
	},
}
