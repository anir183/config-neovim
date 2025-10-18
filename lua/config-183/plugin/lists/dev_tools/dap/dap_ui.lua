--[[ dap_ui.lua: ui windows for the dap ]]

return {
	"rcarriga/nvim-dap-ui",
	name = "dap-ui",
	dependencies = {
		"dap",
		"nio",
		"dap-virtual-text",
	},
	opts = {},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup(opts)

		require("nvim-dap-virtual-text").setup({
			-- hides sensitive tokens... just in case
			display_callback = function(variable)
				local name = string.lower(variable.name)
				local value = string.lower(variable.name)

				if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
					return " ******"
				end

				if #variable.value > 15 then
					return " " .. string.sub(variable.value, 1, 15) .. "... "
				end

				return " " .. variable.value
			end,
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>dt",
			function()
				require("dapui").toggle()
			end,
			desc = "[plugin/dapui]: [D]ap ui [T]oggle",
		},
		{
			mode = "n",
			"<leader>dr",
			function()
				require("dapui").open({ reset = true })
			end,
			desc = "[plugin/dapui]: [D]ap ui [R]eset",
		},
	},
}
