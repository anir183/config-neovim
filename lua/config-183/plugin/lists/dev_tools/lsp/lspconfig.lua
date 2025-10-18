--[[ lspconfig.lua: premade configuration for different lsps ]]

return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	dependencies = {
		"mason-lspconfig",
		"blink",
	},
	config = function()
		for name, opts in pairs(CONF_183.settings.lsps) do
			if not opts then
				goto continue
			end

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				opts.capabilities or {}
			)

			local glc = require("blink.cmp").get_lsp_capabilities
			opts.capabilities = glc(capabilities)

			vim.lsp.enable(name)
			vim.lsp.config(name, opts)

			::continue::
		end
	end,
}
