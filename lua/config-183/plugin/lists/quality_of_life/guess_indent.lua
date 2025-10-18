--[[ guess_indent.lua: auto guess indentation ]]

return {
	"nmac427/guess-indent.nvim",
	name = "guess-indent",
	opts = {
		auto_cmd = false,
	},
	config = function(_, opts)
		require("guess-indent").setup(opts)

		vim.api.nvim_create_user_command(
			CONF_183.settings.cmd_pre .. "AutoSetIndent",
			function()
				local ft = vim.bo.filetype
				local ftstates = {
					help = false,
					netrw = false,
					oil = false,
					tutor = false,
					nofile = false,
					terminal = false,
					prompt = false,
					snacks_picker_input = false,
					snacks_terminal = false,
				}

				if ft == "" or ftstates[ft] == false then
					return
				end

				vim.cmd.GuessIndent()
				vim.opt_local.listchars:remove("leadmultispace")
				vim.opt_local.listchars:append({
					leadmultispace = "▎"
						.. ("∙"):rep(vim.opt_local.tabstop._value - 1),
				})
			end,
			{ desc = "[plugin/guess-indent]: auto set indent" }
		)

		CONF_183.functions.auto_indent = function()
			vim.cmd(CONF_183.settings.cmd_pre .. "AutoSetIndent")
		end

		vim.api.nvim_create_autocmd("BufEnter", {
			group = CONF_183.augrp,
			command = CONF_183.settings.cmd_pre .. "AutoSetIndent",
		})
	end,
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>ai",
			"<CMD>" .. CONF_183.settings.cmd_pre .. "AutoSetIndent<CR>",
			desc = "[plugin/guess-indent]: [A]uto set [I]ndent",
		},
	},
}
