--[[ plugins adding some pretty cool qol features but are not "necessary" for me]]

return {

	-- auto calculate indentation (useful for non-personal projects)
	{
		"nmac427/guess-indent.nvim",
		name = "guess_indent",
		config = function()
			require("guess-indent").setup({})
		end,
	},

	-- pretty good file explorer
	{
		"stevearc/oil.nvim",
		name = "oil",
		dependencies = { "devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = false,
				skip_confirm_for_simple_edits = true,
				view_options = {
					show_hidden = true,
				},
			})

			NMAP(
				"<leader>E",
				vim.cmd.Oil,
				{ desc = "plugins/oil: open the oil file explorer" }
			)
		end,
	},

	-- a breakvrumbs bar among other things
	{
		"Bekaboo/dropbar.nvim",
		name = "dropbar",
		config = function()
			local dropbar_api = require("dropbar.api")

			vim.keymap.set(
				"n",
				"<Leader>;",
				dropbar_api.pick,
				{ desc = "Pick symbols in winbar" }
			)
			vim.keymap.set(
				"n",
				"[;",
				dropbar_api.goto_context_start,
				{ desc = "Go to start of current context" }
			)
			vim.keymap.set(
				"n",
				"];",
				dropbar_api.select_next_context,
				{ desc = "Select next context" }
			)
		end,
	},

	-- lsp progress messages
	{
		"j-hui/fidget.nvim",
		name = "fidget",
		config = function()
			require("fidget").setup({})
		end,
	},

	-- hide sensitive tokens, just in case
	{
		"laytan/cloak.nvim",
		name = "cloak",
		config = function()
			require("cloak").setup({
				cloak_character = "*",
				patterns = OPTS.cloak_patterns,
			})

			NMAP(
				"<leader>ct",
				vim.cmd.CloakToggle,
				{ desc = "plugins/cloak: toggle cloak hiding" }
			)
			NMAP(
				"<leader>CT",
				vim.cmd.CloakPreviewLine,
				{ desc = "plugins/cloak: preview current line" }
			)
		end,
	},

	-- color picker
	{
		"uga-rosa/ccc.nvim",
		name = "color_picker",
		config = function()
			require("ccc").setup()

			NMAP(
				"<leader>cp",
				vim.cmd.CccPick,
				{ desc = "plugins/colorpicker: pick a color" }
			)
			NMAP(
				"<leader>ch",
				vim.cmd.CccHighlighterToggle,
				{ desc = "plugins/colorpicker: toggle color highlighting" }
			)
			NMAP(
				"<leader>cc",
				vim.cmd.CccConvert,
				{ desc = "plugins/colorpicker: convert color into other forms" }
			)
		end,
	},

	-- quick commenting
	{
		"numToStr/Comment.nvim",
		name = "comment",
		config = function()
			-- missing fields not required for this config
			---@diagnostic disable-next-line: missing-fields
			require("Comment").setup({
				mappings = { basic = false, extra = false },
			})

			NMAP("<C-c>", "<Plug>(comment_toggle_linewise)", {
				desc = "plugins/comment: leader for linewise commenting motions",
			})
			NMAP("<C-x>", "<Plug>(comment_toggle_blockwise)", {
				desc = "plugins/comment: leader for blockwise commenting motions",
			})

			NMAP("<C-c><C-c>", function()
				return vim.api.nvim_get_vvar("count") == 0
						and "<plug>(comment_toggle_linewise_current)"
					or "<plug>(comment_toggle_linewise_count)"
			end, {
				expr = true,
				desc = "plugins/comment: toggle single line commenting of the line",
			})
			NMAP("<C-x><C-x>", function()
				return vim.api.nvim_get_vvar("count") == 0
						and "<plug>(comment_toggle_blockwise_current)"
					or "<plug>(comment_toggle_blockwise_count)"
			end, {
				expr = true,
				desc = "plugins/comment: toggle block commenting of the line",
			})

			MAP("x", "<C-c><C-c>", "<Plug>(comment_toggle_linewise_visual)", {
				desc = "plugins/comment: toggle single line commenting selection",
			})
			MAP(
				"x",
				"<C-x><C-x>",
				"<Plug>(comment_toggle_blockwise_visual)",
				{ desc = "plugins/comment: toggle block commenting selection" }
			)
		end,
	},

	-- highlighting for special comment tags
	{
		"folke/todo-comments.nvim",
		name = "todo_comments",
		dependencies = { "plenary" },
		config = function()
			local todo_comments = require("todo-comments")
			todo_comments.setup()

			NMAP(
				"]t",
				function()
					todo_comments.jump_next()
				end,
				{ desc = "plugins/todocomments: jump to the next todo comment" }
			)
			NMAP("[t", function()
				todo_comments.jump_prev()
			end, {
				desc = "plugins/todocomments: jump to the previous todo comment",
			})
			NMAP("tl", vim.cmd.TodoQuickFix, {
				desc = "plugins/todocomments: show all todo comments in project quick fix list",
			})
		end,
	},

	-- undo history in tree format for easier navigation
	{
		"mbbill/undotree",
		name = "undotree",
		init = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 40
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
		config = function()
			NMAP(
				"<leader>u",
				vim.cmd.UndotreeToggle,
				{ desc = "plugins/undotree: toggle the undo history tree" }
			)
		end,
	},
}
