--[[ formatter ]]

-- try to format thrice before failing
-- async failure is common for some reason
local function format(from_keymap, count)
	if from_keymap and count < 1 then
		vim.notify("Starting format!")
	end

	require("conform").format({
		async = true,
		quiet = true,
	}, function(err, did_edit)
		if not err then
			if did_edit then
				vim.notify("Formatted file!")
			elseif from_keymap then
				vim.notify("No formatting required!")
			end
		else
			if count <= 3 then
				format(from_keymap, count + 1)
			elseif from_keymap then
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
				format(false, 0)
			end,
		})

		MAP({ "n", "v" }, "<leader>fm", function()
			format(true, 0)
		end, { desc = "plugins/conform: format the file or selection" })
	end,
}
