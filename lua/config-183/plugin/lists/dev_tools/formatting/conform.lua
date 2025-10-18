--[[ conform.lua: file formatting engine ]]

-- format function using conform which tries 3 times in case of error before
-- giving up
local function format(silent, try_num)
	silent = silent or false

	if not try_num or try_num < 1 then
		try_num = 0
		if not silent then
			vim.notify("Starting Format!")
		end
	end

	local curr_file_path = vim.fn.expand("%:p")

	-- try to format the file
	local success = pcall(require("conform").format, {
		async = true,
		quiet = true,
	}, function(err, edited_file)
		-- formatting successful
		if not err then
			if edited_file then
				if not silent then
					vim.notify("Formatted File!")
				end
				vim.cmd("silent! w " .. curr_file_path)
			elseif not silent then
				vim.notify("File is already Correctly Formatted!")
			end

		-- formatting unsuccessful, rety unless exceeded try limit
		else
			if try_num <= 3 then
				format(silent, try_num + 1)
			elseif not silent then
				vim.notify("Could not Format File!\n" .. err)
			end
		end
	end)

	if not success and not silent then
		vim.notify("Could not Format Files after 3 tries!")
	end
end

return {
	"stevearc/conform.nvim",
	name = "conform",
	dependencies = "mason",
	opts = {
		formatters_by_ft = CONF_183.settings.formatters,
		formatters = CONF_183.custom_formatters,
	},
	config = function(_, opts)
		local conform = require("conform")

		conform.setup(opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = CONF_183.augrp,
			callback = function()
				format(true)
			end,
		})
	end,
	lazy = false,
	keys = {
		{
			mode = { "n", "v" },
			"<leader>fm",
			format,
			desc = "[plugin/conform]: [F]or[M]at file or selections",
		},
	},
}
