--[[ git_signs.lua: git information and actions ]]

return {
	"lewis6991/gitsigns.nvim",
	name = "git-signs",
	lazy = false,
	opts = {
		signcolumn = false,
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)

		-- git information function for statusline
		CONF_183.statusline.component_functions.gitinfo = function()
			local git_info = vim.b.gitsigns_status_dict
			if not git_info or git_info.head == "" then
				return ""
			end

			local head = git_info.head
			local added = git_info.added and (" +" .. git_info.added) or ""
			local changed = git_info.changed and (" ~" .. git_info.changed)
				or ""
			local removed = git_info.removed and (" -" .. git_info.removed)
				or ""
			if git_info.added == 0 then
				added = ""
			end
			if git_info.changed == 0 then
				changed = ""
			end
			if git_info.removed == 0 then
				removed = ""
			end

			local fmt_str = "%%#%s#%s%%*"
			return table.concat({
				fmt_str:format("Exception", "["),
				fmt_str:format("Exception", head),
				fmt_str:format("DiagnosticSignOk", added),
				fmt_str:format("DiagnosticSignWarn", changed),
				fmt_str:format("DiagnosticSignError", removed),
				fmt_str:format("Exception", "]"),
			})
		end

		-- add gitinfo to the statusline arrangement
		local component = CONF_183.statusline.get_component
		CONF_183.statusline.arrangement = {
			-- left
			component("mode"),
			component("diagnostics"),
			" ",
			"%r",
			"%w",
			"%h",
			"%m",

			"%=",

			-- right
			component("gitinfo"),
			" ",
			component("filename"),
			" ",
			component("indent"),
			" ",
			component("position"),
		}
		vim.opt_global.statusline =
			table.concat(CONF_183.statusline.arrangement, "")
	end,
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
			"[g",
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
