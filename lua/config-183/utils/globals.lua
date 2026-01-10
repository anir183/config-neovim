--[[
--
-- ./lua/config-183/utils/globals.lua
--
-- setup globally available variables, options and functions
--
--]]

---@class GlobalVars
--- commonly used variables that are better globally available
VARS_183 = {}
---@class GlobalFuncs
--- commonly used functions that are better globally available
FUNCS_183 = {}

---@class AugrpVars
--- variables related to auto-command groups
VARS_183.augrp = {}
---@type string name of the auto-command group
VARS_183.augrp.name = "anir183"
---@type integer id of the create auto-command group
VARS_183.augrp.id = vim.api.nvim_create_augroup(VARS_183.augrp.name, {
	clear = true,
})

---@class PathVars
VARS_183.paths = {}
---@type string os specific path separator
VARS_183.paths.separator = package.config:sub(1,1)
---@type string directory where general config files are stored
VARS_183.paths.config = vim.fn.stdpath("config")
---@type string directory where data files are stored
VARS_183.paths.data = vim.fn.stdpath("data")

---@param mode string | string[] mode where the keymap can be used
---@param lhs string the actual keymap
---@param rhs string | function command or callback to run when keymap triggers
---@param desc? string desciption of what the keymap does
---@param opts? vim.keymap.set.Opts extra options for the keymap
---@return nil
FUNCS_183.map = function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc

	vim.keymap.set(mode, lhs, rhs, opts)
end

---@param lhs string the actual keymap
---@param rhs string | function command or callback to run when keymap triggers
---@param desc? string desciption of what the keymap does
---@param opts? vim.keymap.set.Opts extra options for the keymap
---@return nil
FUNCS_183.nmap = function(lhs, rhs, desc, opts)
	FUNCS_183.map("n", lhs, rhs, desc, opts)
end

---@params ... any components of the path
---@return string joined_path final joined path using os based separator
FUNCS_183.join_paths = function(...)
	return table.concat({...}, VARS_183.paths.separator)
end

---@class LazyVars
--- variables related to lazy.nvim package manager
VARS_183.lazy = {}
---@type string path where lazy.nvim is installed
VARS_183.lazy.path = FUNCS_183.join_paths(
	VARS_183.paths.data,
	"lazy",
	"lazy.nvim"
)
---@type string path where lazy.nvim packages lock file is stored
VARS_183.lazy.lock_path = FUNCS_183.join_paths(
	VARS_183.paths.data,
	"lazy-lock.json"
)
---@type string repository where the lazy.nvim package is hosted
VARS_183.lazy.repo = "https://github.com/folke/lazy.nvim.git"
---@type string[] installation command to pull down the remote repo
VARS_183.lazy.install_cmd = {
	"git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	VARS_183.lazy.repo,
	VARS_183.lazy.path,
}
---@class LazyPriorities
--- different priority levels to control plugin configuration order
VARS_183.lazy.priorities = {}
---@type integer
VARS_183.lazy.priorities.highest = 200
---@type integer
VARS_183.lazy.priorities.high = 100
---@type integer
VARS_183.lazy.priorities.default = 50
---@type integer
VARS_183.lazy.priorities.low = 25
