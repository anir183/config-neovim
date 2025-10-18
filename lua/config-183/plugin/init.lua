--[[ init.lua: initialize plugins with lazy plugin manager ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.plugin then
	return
end

CONF_183.lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
CONF_183.lazy.repo = "https://github.com/folke/lazy.nvim.git"
CONF_183.lazy.gitcmd = {
	"git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	CONF_183.lazy.repo,
	CONF_183.lazy.path,
}
CONF_183.lazy.plugin_priorities = {
	highest = 1000,
	high = 500,
	low = 250,
	lowest = 125,
}

-- install lazy and add it to runtime path
if not (vim.uv or vim.loop).fs_stat(CONF_183.lazy.path) then
	local gitcmd_output = vim.fn.system(CONF_183.lazy.gitcmd)

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone Lazy.nvim:\n", "ErrorMsg" },
			{ gitcmd_output, "WarningMsg" },
			{ "\nPress any key to exit..." }
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt_global.rtp:prepend(CONF_183.lazy.path)

-- plugin actions
-- accepts a key-value table as { choice-name: choice-function() }
CONF_183.functions.plugin_actions_menu = function(commands)
	local choice_list = {}
	for key, _ in pairs(commands) do
		table.insert(choice_list, key)
	end

	vim.ui.select(choice_list, {
		prompt = "choose action",
	}, function(choice)
		if not choice then
			return
		end

		local func = commands[choice]
		if not func then
			vim.api.nvim_echo({
				{ "Error: Command does not have a function to run", "ErrorMsg" }
			}, true, {})
			return
		end

		func()
	end)
end

-- setup lazy.nvim
local enabled = CONF_183.settings.module_toggles.plugin
require("lazy").setup(CONF_183.settings.test_plugins or {
	spec = {
		enabled.dependencies and {
			import = "config-183.plugin.lists.dependencies"
		} or {},
		enabled.essentials and {
			import = "config-183.plugin.lists.essentials"
		} or {},
		enabled.dev_tools and {
			{ import = "config-183.plugin.lists.dev_tools.manager" },
			{ import = "config-183.plugin.lists.dev_tools.lsp" },
			{ import = "config-183.plugin.lists.dev_tools.completion" },
			{ import = "config-183.plugin.lists.dev_tools.dap" },
			{ import = "config-183.plugin.lists.dev_tools.formatting" },
			{ import = "config-183.plugin.lists.dev_tools.linting" },
		} or {},
		enabled.aesthetics and { 
			import = "config-183.plugin.lists.aesthetics"
		} or {},
		enabled.quality_of_life and {
			import = "config-183.plugin.lists.quality_of_life"
		} or {},
		CONF_183.settings.plugins or {}
	},

	-- lockfile
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

	-- never lazy load
	defaults = {
		lazy = false,
	},

	-- disable luarocks
	rocks = {
		enabled = false,
	},

	-- check for updates but dont notify
	checker = {
		enabled = true,
		notify = false,
	},

	-- check for changes but dont notify
	change_detection = {
		enabled = true,
		notify = false,
	},
})

-- keymap to open lazy window
CONF_183.functions.nmap(
	"<leader>lz",
	vim.cmd.Lazy,
	"[plugin/lazy]: open [L]a[Z]y"
)
