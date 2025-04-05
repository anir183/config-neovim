--[[ formatter ]]

-- try to format thrice before failing
-- async failure is common for some reason
local function format(count)
	count = count and count or 1

	require("conform").format({
		async = true,
	}, function(err, did_edit)
		if not err then
			if did_edit then
				vim.notify("Formatted file!")
			end
		else
			if count <= 3 then
				format(count + 1)
			else
				vim.notify("Could not format!\n" .. err)
			end
		end
	end)
end

return {
	"stevearc/conform.nvim",
	name = "conform",
	dependencies = { "mason_tool_installer" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = OPTS.formatters,
			formatters = OPTS.custom_formatters,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = AUGRP,
			callback = function()
				format()
			end,
		})

		MAP({ "n", "v" }, "<leader>fm", function()
			format()
		end, { desc = "plugins/conform: format the file or selection" })
	end,
}
