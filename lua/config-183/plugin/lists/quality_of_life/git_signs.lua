--[[ git_signs.lua: git information and actions ]]

return {
	"lewis6991/gitsigns.nvim",
	name = "git-signs",
	lazy = false,
	opts = {
		signcolumn = false,
		numhl = true,
	},
	keys = {
		-- navigate hunks
		{
			mode = "n",
			"]g",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]g", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
		},
		{
			mode = "n",
			"]g",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[g", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
		},

		-- git-signs functions
		{
			mode = "n",
			"<leader>ga",
			function()
				CONF_183.functions.plugin_actions_menu({
					["toggle-signs"] = require("gitsigns").toggle_signs,
					["toggle-number-hl"] = require("gitsigns").toggle_numhl,
					["toggle-line-hl"] = require("gitsigns").toggle_linehl,
					["toggle-word-diff"] = require("gitsigns").toggle_word_diff,
					["toggle-blame-vtext"] = require("gitsigns").toggle_current_line_blame,
					["toggle-stage-hunk"] = require("gitsigns").stage_hunk,
					["stage-buffer"] = require("gitsigns").stage_buffer,
					["reset-buffer"] = require("gitsigns").reset_buffer,
					["reset-buffer-index"] = require("gitsigns").reset_buffer_index,
					["blame-file"] = require("gitsigns").blame,
					["blame-line"] = require("gitsigns").blame_line,
					["diff-file"] = require("gitsigns").diffthis,
					["change-base"] = function()
						vim.ui.input({
							prompt = "new base: ",
						}, function(input)
							if not input then
								require("gitsigns").change_base()
								return
							end

							require("gitsigns").change_base(input)
						end)
					end,
					["preview-hunk"] = require("gitsigns").preview_hunk,
					["preview-hunk-inline"] = require("gitsigns").preview_hunk_inline,
					["set-quickfix-list"] = require("gitsigns").setqflist,
					["show-commit"] = require("gitsigns").show_commit,
					["show-revision"] = require("gitsigns").show,
					["refresh"] = require("gitsigns").refresh,
				})
			end,
			desc = "[plugin/snacks]: choose from [G]it-sign [A]ctions",
		},
	},
}
