--[[ statusline.lua: custom statusline formatting ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.custom.statusline then
	return
end

-- remove statusline background
local hl = vim.api.nvim_set_hl
hl(0, "StatusLine", { bg = "none" })
hl(0, "StatusLineNC", { bg = "none" })
hl(0, "StatusLineTerm", { bg = "none" })
hl(0, "StatusLineTermNC", { bg = "none" })

CONF_183.statusline.mode_strs = {
	["n"] = " normal ",
	["niI"] = " insert [normal] ",
	["niR"] = " replace [normal] ",
	["nt"] = " terminal [normal] ",
	["i"] = " insert ",
	["R"] = " replace ",
	["v"] = " visual ",
	["V"] = " visual [line] ",
	[""] = " visual [block] ",
	["c"] = " command ",
	["!"] = " command [external] ",
	["t"] = " terminal ",
}

-- components used in the statusline
local fmt_str = "%%#%s#%s%%*" -- format string
CONF_183.statusline.component_functions = {
	filename = function()
		return fmt_str:format("Dictionary", " %t ")
	end,

	position = function()
		return fmt_str:format("CursorLine", " %l:$-c ~ %2p%% ")
	end,

	mode = function()
		local mode = CONF_183.statusline.mode_strs[vim.fn.mode()]
		return fmt_str:format("IncSearch", mode)
	end,

	indent = function()
		local type = vim.opt_local.expandtab._value and "spaces" or "tabs"
		local len = vim.opt_local.tabstop._value

		return fmt_str:format(
			"CursorLineNr",
			("[" .. type .. " : " .. len .. "] ")
		)
	end,

	warnings = function()
		local count = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN]
		return fmt_str:format("DiagnosticWarn", " " .. (count or ""))
	end,

	errors = function()
		local count = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR]
		count = count and " " .. count or " "
		return fmt_str:format("DiagnosticError", count)
	end,
}

-- get component function
CONF_183.statusline.get_component = function(cmp_name)
	return "%{%v:lua.CONF_183.statusline.component_functions." ..
			cmp_name .. "()%}"
end

-- build statusline
local component = CONF_183.statusline.get_component
CONF_183.statusline.arrangement = {
	-- left
	component("mode"),
	component("warnings"),
	component("errors"),
	"%r",
	"%w",
	"%h",
	"%m",

	"%=",

	-- right
	component("filename"),
	component("indent"),
	component("position"),
}
vim.opt_global.statusline = table.concat(CONF_183.statusline.arrangement , "")
