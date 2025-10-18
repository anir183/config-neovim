--[[ mason_dap.lua: bridge between dap and mason ]]

return {
	"jay-babu/mason-nvim-dap.nvim",
	name = "mason-dap",
	dependencies = {
		"mason",
		"dap",
	},
	opts = {
		automatic_installation = true,
	},
	config = function(_, opts)
		local mason_dap = require("mason-nvim-dap")

		-- variables be used in the mason-dap setup function
		local ensure_installed = {}
		local handlers = {
			function(config)
				mason_dap.default_setup(config)
			end,
		}

		-- populate the variables from settings data
		for name, handler in pairs(CONF_183.settings.daps) do
			table.insert(ensure_installed, dap_name)

			if handler then
				handlers[dap_name] = handler
			end
		end

		-- setup mason_dap
		mason_dap.setup(vim.tbl_deep_extend("force", {
			ensure_installed = ensure_installed,
			handlers = handlers,
		}, opts))

		-- defer config of all daps to give mason-nvim-dap time to setup
		vim.defer_fn(function()
			local dap = require("dap")

			for _, setup in ipairs(CONF_183.settings.custom_daps) do
				local index = 1
				for name, opts in pairs(dap_setup) do
					if index == 1 then
						dap.adapters[name] = opts
					elseif index == 2 then
						dap.configurations[name] = opts
					end

					index = index + 1
				end
			end
		end, 10)
	end,
}
