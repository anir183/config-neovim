--[[ todo_comments.lua: highlighting for special comment tags ]]

return {
	"folke/todo-comments.nvim",
	name = "todo-comments",
	dependencies = "plenary",
	opts = {},
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>tq",
			function() vim.cmd.TodoQuickFix() end,
			desc = "[plugin/todo-comments]: show [T]odo comments in [Q]f list"
		},
		{
			mode = "n",
			"]t",
			function() require("todo-comments").jump_next() end,
			desc = "[plugin/todo-comments]: jump to next todo comment"
		},
		{
			mode = "n",
			"[t",
			function() require("todo-comments").jump_prev() end,
			desc = "[plugin/todo-comments]: jump to previous todo comment"
		},
	},
}
