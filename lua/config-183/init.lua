--[[ init.lua: pre configurations and initialize modules ]]

CONF_183 = {
	augrp_name = {},
	augrp = {},
	functions = {},
	settings = {},
}

-- load custom or if not available, default settings
CONF_183.settings = vim.tbl_deep_extend(
	"force",
	require("config-183.settings.defaults"),
	pcall(require, "config-183.settings.custom") and
		require("config-183.settings.custom") or {}
)

-- auto command groups
CONF_183.augrp_name = "augroup-183"
CONF_183.augrp = vim.api.nvim_create_augroup(CONF_183.augrp_name, {
	clear = true
})

-- verbose printing
CONF_183.functions.vprint = function(...)
	if not (vim.g.VERBOSE or CONF_183.settings.verbose_mode) then
		return
	end
	vim.print(...)
end

-- mapping functions
CONF_183.functions.map = function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, lhs, rhs, opts)
end
CONF_183.functions.nmap = function(lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set("n", lhs, rhs, opts)
end

-- check if modules are enabled
if not CONF_183.settings.module_toggles then
	return
end

-- when opened in vscode via vscode-neovim extension
if vim.g.vscode then
	print("Launched in VSCode Mode")
	-- require("config-183.vscode")
end

-- minimal mode
if vim.g.MINIMAL or CONF_183.settings.minimal_mode then
	print("Launched in Minimal Mode")
	-- require("config-183.minimal")
	return
end

-- normal configuration
require("config-183.base")
-- require("config-183.custom")
-- require("config-183.plugin")
