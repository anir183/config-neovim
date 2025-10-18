--[[ snacks.lua: fuzzy finder, picker and some other cool utilities ]]

return {
	"folke/snacks.nvim",
	name = "snacks",
	dependencies = "devicons",
	priority = CONF_183.lazy.plugin_priorities.high,
	init = function()
		vim.g.snacks_animate = false
	end,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		image = { enabled = false },
		indent = { enabled = false },
		input = { enabled = true },
		notifier = { enabled = false },
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<C-p>"] = {
							"toggle_preview",
							mode = { "i", "n" },
						},
					},
				},
				list = {
					keys = {
						["<C-p>"] = "toggle_preview",
					},
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = {
			enabled = false,
			debounce = 0,
		},
		terminal = {
			start_insert = false,
			auto_insert = false,
			auto_close = true,
		},
		zen = {
			toggles = {
				dim = false,
			},
		},
	},
	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)

		-- invoke lsp action on file rename via oil.nvim
		vim.api.nvim_create_autocmd("User", {
			group = CONF_183.augrp,
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					snacks.rename.on_rename_file(
						event.data.actions.src_url,
						event.data.actions.dest_url
					)
				end
			end
		})
	end,
	lazy = false,
	keys = {
		-- search, find and picker keymaps
		{
			mode = "n",
			"<leader>/",
			function() Snacks.picker.lines() end,
			desc = "[plugin/snacks]: search in buffer"
		},
		{
			mode = "n",
			"<leader>?",
			function() Snacks.picker.search_history() end,
			desc = "[plugin/snacks]: search history"
		},
		{
			mode = { "n", "x" },
			"<leader>*",
			function() Snacks.picker.grep_word() end,
			desc = "[plugin/snacks]: grep word under cursor"
		},
		{
			mode = "n",
			"<leader>q:",
			function() Snacks.picker.command_history() end,
			desc = "[plugin/snacks]: command history"
		},
		{
			mode = "n",
			"<leader>ff",
			function() Snacks.picker.files() end,
			desc = "[plugin/snacks]: [F]ind [F]iles"
		},
		{
			mode = "n",
			"<leader>FF",
			function()
				Snacks.picker.files({
					hidden = true,
					ignored = true,
				})
			end,
			desc = "[plugin/snacks]: [F]ind [F]iles hidden and ignored incl"
		},
		{
			mode = "n",
			"<leader>FI",
			function()
				Snacks.picker.files({
					ignored = true,
				})
			end,
			desc = "[plugin/snacks]: [F]ind [F]iles ignored incl"
		},
		{
			mode = "n",
			"<leader>FH",
			function()
				Snacks.picker.files({
					hidden = true,
				})
			end,
			desc = "[plugin/snacks]: [F]ind [F]iles hidden incl"
		},
		{
			mode = "n",
			"<leader>fc",
			function()
				Snacks.picker.files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "[plugin/snacks]: [F]ind files in [C]onfig directory"
		},
		{
			mode = "n",
			"<leader>fr",
			function() Snacks.picker.recent() end,
			desc = "[plugin/snacks]: [F]ind [R]ecently visited files"
		},
		{
			mode = "n",
			"<leader>fk",
			function() Snacks.picker.keymaps() end,
			desc = "[plugin/snacks]: [F]ind [K]eymaps"
		},
		{
			mode = "n",
			"<leader>gg",
			function() Snacks.picker.grep() end,
			desc = "[plugin/snacks]: [G]lobal [G]rep"
		},
		{
			mode = "n",
			"<leader>fh",
			function() Snacks.picker.help() end,
			desc = "[plugin/snacks]: [F]ind in [H]elp pages"
		},
		{
			mode = "n",
			"<leader>fq",
			function() Snacks.picker.qflist() end,
			desc = "[plugin/snacks]: [F]ind in [Q]uick fix list"
		},
		{
			mode = "n",
			"<leader>fl",
			function() Snacks.picker.loclist() end,
			desc = "[plugin/snacks]: [F]ind in [L]ocation list"
		},

		-- choose snacks pickers
		{
			mode = "n",
			"<leader>sp",
			function()
				CONF_183.functions.plugin_actions_menu({
					["explorer"] = Snacks.explorer,
					["smart"] = Snacks.picker.smart,
					["find-buffers"] = Snacks.picker.buffers,
					["find-config"] = function()
						Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
					end,
					["find-projects"] = Snacks.picker.projects,
					["grep-buffers"] = Snacks.picker.grep_buffers,
					["git-files"] = Snacks.picker.git_files,
					["git-branches"] = Snacks.picker.git_branches,
					["git-log"] = Snacks.picker.git_log,
					["git-logline"] = Snacks.picker.git_log_line,
					["git-status"] = Snacks.picker.git_status,
					["git-stash"] = Snacks.picker.git_stash,
					["git-diff"] = Snacks.picker.git_diff,
					["git-logfile"] = Snacks.picker.git_log_file,
					["search-registers"] = Snacks.picker.registers,
					["search-autocmds"] = Snacks.picker.autocmds,
					["search-commands"] = Snacks.picker.commands,
					["search-diagnostics"] = Snacks.picker.diagnostics,
					["search-diag-buff"] = Snacks.picker.diagnostics_buffer,
					["search-highlights"] = Snacks.picker.highlights,
					["search-keymaps"] = Snacks.picker.keymaps,
					["search-undo"] = Snacks.picker.undo,
					["search-man"] = Snacks.picker.man,
					["search-lazy"] = Snacks.picker.lazy,
				})
			end,
			desc = "[plugin/snacks]: choose [S]nacks [P]icker"
		},

		-- words keymaps
		{
			mode = "n",
			"<leader>wo",
			function() Snacks.words.enable() end,
			desc = "[plugin/snacks]: enable [WO]rds"
		},
		{
			mode = "n",
			"<leader>WO",
			function() Snacks.words.disable() end,
			desc = "[plugin/snacks]: disable [WO]rds"
		},
		{
			mode = "n",
			"<C-l>",
			function()
				vim.cmd("mode")
				vim.cmd("redraw!")
				vim.cmd("nohlsearch")
				Snacks.words.clear()
			end,
			desc = "[plugin/snacks]: clear words and also clear screen"
		},
		{
			mode = "n",
			"]w",
			function() Snacks.words.jump(vim.v,count1, true) end,
			desc = "[plugin/snacks]: jump to next word reference"
		},
		{
			mode = "n",
			"[w",
			function() Snacks.words.jump(-vim.v.count1, true) end,
			desc = "[plugin/snacks]: jump to previous word references"
		},

		-- terminal keymaps
		{
			mode = "n",
			"<leader>tt",
			function() Snacks.terminal.toggle() end,
			desc = "[plugin/snacks]: [T]oggle [T]erminal window"
		},
		{
			mode = "n",
			"<leader>to",
			function() Snacks.terminal.open() end,
			desc = "[plugin/snacks]: [O]pen a [T]erminal window"
		},

		-- zen mode keymaps
		{
			mode = "n",
			"<leader>zt",
			function() Snacks.zen.zen() end,
			desc = "[plugin/snacks]: [Z]en mode [T]oggle"
		},
		{
			mode = "n",
			"<leader>zz",
			function() Snacks.zen.zoom() end,
			desc = "[plugin/snacks]: toggle [Z]en in [Z]oom mode"
		},

		-- snacks actions menu
		{
			mode = "n",
			"<leader>sa",
			function()
				CONF_183.functions.plugin_actions_menu({
					["dim-enable"] = Snacks.dim.enable,
					["dim-disable"] = Snacks.dim.disable,
					["git-blame"] = Snacks.git.blame_line,
					["git-browse"] = Snacks.gitbrowse.open,
					["lazy-git"] = Snacks.lazygit.open,
					["rename-file"] = Snacks.rename.rename_file,
					["scratch-toggle"] = Snacks.scratch,
					["scratch-select"] = Snacks.scratch.select,
					["word-enable"] = Snacks.words.enable,
					["word-disable"] = Snacks.words.disable,
					["word-clear"] = Snacks.words.clear,
					["word-jump"] = Snacks.words.jump,
					["zen"] = Snacks.zen,
					["zen-zoom"] = Snacks.zen.zoom,
				})
			end,
			desc = "[plugin/snacks]: choose from [S]nacks [A]ctions"
		},
	},
}
