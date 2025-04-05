--[[ formatter ]]

return {
	"stevearc/conform.nvim",
	name = "conform",
	dependencies = { "mason_tool_installer" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = OPTS.formatters,
			formatters = OPTS.custom_formatters,
			format_on_save = { lsp_format = "never", timeout_ms = 5000 },
		})

		MAP(
			{ "n", "v" },
			"<leader>fm",
			conform.format,
			{ desc = "plugins/conform: format the file or selection" }
		)
	end,
}
