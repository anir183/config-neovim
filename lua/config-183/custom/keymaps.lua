--[[ keymaps.lua: keymaps built with core functions but create new
--                functionality ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.custom.keymaps then
	return
end

local map = CONF_183.functions.map
local nmap = CONF_183.functions.nmap

-- toggle relative line number
nmap("<leader>rl", function()
	vim.opt.relativenumber = not vim.opt.relativenumber._value
end, "[custom]: toggle [R]elative [L]ine numbers")

-- toggle fold column
nmap("zt", function()
	local fc = vim.opt.foldcolumn._value
	vim.opt.foldcolumn = fc == "0" and "auto:9" or "0"
end, "[custom]: toggle fold column")

-- edit options in a popup
nmap(
	"<leader>op",
	"<CMD>" .. CONF_183.settings.cmd_pre .. "EditOptions<CR>",
	"[custom]: edit configuration [OP]tions"
)

-- change color column
nmap("<leader>cl", function()
	vim.ui.input({
		prompt = "color column pos: ",
	}, function(input)
		if not input then
			return
		end

		vim.opt.colorcolumn = input
	end)
end, "[custom]: change the [C]olor co[L]umn position")

-- change indentation style
nmap(
	"<leader>in",
	"<CMD>" .. CONF_183.settings.cmd_pre .. "ChangeIndent<CR>",
	"[custom]: change [IN]dentation style"
)

-- toggle cursor movement
nmap("<leader>lc", function()
	vim.opt.scrolloff = 999 - vim.opt.scrolloff._value
end, "[custom]: togg[L]e between moving text or moving [C]ursor")

-- substitute standalone words or substrings
nmap(
	"<leader>sb",
	"<CMD>" .. CONF_183.settings.cmd_pre .. "SubstituteWord<CR>",
	"[custom]: [S]u[B]stitute a string (even non-standalone)"
)
