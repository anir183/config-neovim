--[[
--
-- ./lua/config-183/plugins/init.lua
--
-- bootstrap lazy.nvim and setup plugins
--
--]]

--[[ install lazy and add to runtime path ]]
if not (vim.uv or vim.loop).fs_stat(VARS_183.lazy.path) then
	local cmd_out = vim.fn.system(VARS_183.lazy.install_cmd)

	if vim.v.shell_error ~= 0 then
		print("Failed Lazy Install", cmd_out)
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(VARS_183.lazy.path)

--[[ setup and initate lazy ]]
require("lazy").setup({
	spec = {{
		import = "config-183.plugins.list"
	}},
	lockfile = VARS_183.lazy.lock_path,
	defaults = {
		lazy = false,
	},
	rocks = {
		enabled = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = true,
		notify = false,
	}
})
