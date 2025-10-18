--[[ mason_lspconfig.lua: bridge between lspconfig and mason ]]

return {
	"williamboman/mason-lspconfig.nvim",
	name = "mason-lspconfig",
	dependencies = {
		"mason",
		"lspconfig",
	},
	opts = {
		automatic_installation = true,
	},
	config = function(_, opts)
		local ensure_installed = {}

		for name, _ in pairs(CONF_183.settings.lsps) do
			table.insert(ensure_installed, name)
		end

		require("mason-lspconfig").setup(vim.tbl_deep_extend("force", {
			ensure_installed = ensure_installed,
		}, opts))
	end,
}
