--[[ undotree.lua: navigable undo history tree ]]

return {
	"mbbill/undotree",
	name = "undotree",
	init = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_SplitWidth = 40
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>u",
			function() vim.cmd.UndotreeToggle() end,
			desc = "[plugin/undotree]: toggle [U]ndo history tree"
		},
	}
}
