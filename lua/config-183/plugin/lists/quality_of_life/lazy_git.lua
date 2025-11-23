--[[ lazy_git.lua: lazygit intergration inside of neovi ]]

return {
	"kdheepak/lazygit.nvim",
	name = "lazygit",
	dependencies = "plenary",
	lazy = false,
	keys = {
		{
			mode = "n",
			"<leader>lg",
			"<CMD>LazyGit<CR>",
			desc = "[plugin/lazygit]: open lazy git",
		},
		{
			mode = "n",
			"<leader>la",
			function()
				CONF_183.functions.plugin_actions_menu({
					["config"] = function()
						vim.cmd("LazyGitConfig")
					end,
					["open-file-root"] = function()
						vim.cmd("LazyGitCurrentFile")
					end,
					["project-commits"] = function()
						vim.cmd("LazyGitFilter")
					end,
					["buffer-commits"] = function()
						vim.cmd("LazyGitFilterCurrentFile")
					end,
					["log"] = function()
						vim.cmd("LazyGitLog")
					end,
				})
			end,
			desc = "[plugin/lazygit]: open lazy git actions",
		},
	},
}
