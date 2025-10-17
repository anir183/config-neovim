--[[ autocmds.lua: setting up some autocommands ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.base.autocmds then
	return
end

local aucmd = vim.api.nvim_create_autocmd
local augrp = CONF_183.augrp

-- disable color column in netrw and help pages
aucmd("FileType", {
	group = augrp,
	pattern = { "netrw", "help" },
	callback = function()
		vim.opt_local.colorcolumn = "0"
		vim.opt_local.statuscolumn = "%s"
		vim.opt_local.statusline = nil
	end,
})

-- highlight yanked text
aucmd("TextYankPost", {
	group = augrp,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 50,
		})
	end,
})

-- disable number column when in netrw
aucmd({
	"WinEnter",
	"FocusGained",
	"BufReadPre",
	"FileReadPre",
}, {
	group = augrp,
	pattern = { "netrw" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

-- make and load views to retain folds
aucmd({
	"BufWritePre",
	"BufWinLeave",
	"BufLeave",
}, {
	group = augrp,
	command = "silent! mkview",
})
aucmd("BufWinEnter", {
	group = augrp,
	command = "silent! loadview",
})

-- execute when config is loaded
aucmd("VimEnter", {
	group = augrp,
	callback = CONF_183.settings.after,
})
