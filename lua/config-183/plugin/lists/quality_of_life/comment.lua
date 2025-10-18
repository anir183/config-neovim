--[[ comment.lua: selection and quick commenting ]]

return {
	"numToStr/Comment.nvim",
	name = "comment",
	opts = {
		mappings = {
			basic = false,
			extra = false,
		},
	},
	lazy = false,
	keys = {
		-- comment leaders
		{
			mode = "n",
			"<C-c>",
			"<PLUG>(comment_toggle_linewise)",
			desc = "[plugin/comment]: linewise commenting leader",
		},
		{
			mode = "n",
			"<C-x>",
			"<PLUG>(comment_toggle_blockwise)",
			desc = "[plugin/comment]: blockwise commenting leader",
		},

		-- single line or count comment
		{
			mode = "n",
			"<C-c><C-c>",
			function()
				if vim.api.nvim_get_vvar("count") == 0 then
					return "<PLUG>(comment_toggle_linewise_current)"
				else
					return "<PLUG>(comment_toggle_linewise_count)"
				end
			end,
			expr = true,
			desc = "[plugin/comment]: comment current line",
		},
		{
			mode = "n",
			"<C-x><C-x>",
			function()
				if vim.api.nvim_get_vvar("count") == 0 then
					return "<PLUG>(comment_toggle_blockwise_current)"
				else
					return "<PLUG>(comment_toggle_blockwise_count)"
				end
			end,
			expr = true,
			desc = "[plugin/comment]: block-comment current line",
		},

		-- visual mode comment
		{
			mode = "x",
			"<C-c><C-c>",
			"<PLUG>comment_toggle_linewise_visual",
			desc = "[plugin/comment]: comment current selection",
		},
		{
			mode = "x",
			"<C-x><C-x>",
			"<PLUG>comment_toggle_blockwise_visual",
			desc = "[plugin/comment]: block-comment current selection",
		},
	},
}
