--[[ keymaps.lua: keymaps or remaps to base neovim command or functions ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.base.keymaps then
	return
end

local map = CONF_183.functions.map
local nmap = CONF_183.functions.nmap

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

nmap("<leader>ms", vim.cmd.messages, "[base]: open [M]essage[S] window")

-- moving text
-- WARNING : using "<cmd>" instead of ":" breaks these commands
nmap(
	"<C-j>",
	"v:m '>+1<CR>gv=<ESC>",
	"[base]: move the current line up"
)
nmap(
	"<C-k>",
	"v:m '<-2<CR>gv=<ESC>",
	"[base]: move the current line down"
)
map(
	"v",
	"<C-j>",
	":m '>+1<CR>gv=<ESC>gv",
	"[base]: move current selection up"
)
map(
	"v",
	"<C-k>",
	":m '<-2<CR>gv=<ESC>gv",
	"[base]: move current selection down"
)

-- stationary cursor
nmap(
	"J",
	"mzJ`z",
	"[base]: dont move the cursor when joining next line"
)
nmap(
	"<C-d>",
	"<C-d>zz",
	"[base]: keep cursor centered when scrolling down"
)
nmap(
	"<C-u>",
	"<C-u>zz",
	"[base]: keep cursor centered when scrolling up"
)
nmap(
	"n",
	"nzzzv",
	"[base]: keep cursor centered when navigating search results"
)
nmap(
	"N",
	"Nzzzv",
	"[base]: keep cursor centered when navigating search results"
)

-- modification or extensions of existing keymaps
map({ "n", "v" }, "x", "\"_x", "[base]: remove without copying")
map(
	"x",
	"<leader>p",
	"\"_dP",
	"[base]: paste over selection without copying"
)
map(
	{ "n", "v" },
	"<leader>y",
	"\"+y",
	"[base]: yank to system clipboard"
)
nmap(
	"<leader>Y",
	"\"+Y",
	"[base]: yank till end of line to system clipboard"
)
map(
	{ "n", "v" },
	"<leader>d",
	"\"_d",
	"[base]: delete without copying"
)
nmap(
	"<leader>D",
	"\"_D",
	"[base]: delete till end of line without copying"
)
map(
	{ "n", "v" },
	"<leader>c",
	"\"_c",
	"[base]: delete and edit without copying"
)
nmap(
	"<leader>C",
	"\"_C",
	"[base]: delete till eol and edit without copying"
)

-- split resizing
nmap("-", function()
	vim.cmd.wincmd("<")
end, "[base]: increase window width")
nmap("+", function()
	vim.cmd.wincmd(">")
end, "[base]: decrease window width")
nmap("<leader>-", function()
	vim.cmd.wincmd("-")
end, "[base]: increase window height")
nmap("<leader>+", function()
	vim.cmd.wincmd("+")
end, "[base]: decrease window height")

-- quick fix list
nmap("<leader>q", vim.cmd.copen, "[base]: open the [Q]uick fix list")
nmap("<leader>Q", vim.cmd.ccl, "[base]: close the [Q]uick fix list")
nmap("]q", vim.cmd.cnext, "[base]: walk forward in [Q]uick fix list")
nmap("[q", vim.cmd.cprev, "[base]: walk backward in [Q]uick fix list")

-- location list
nmap("<leader>l", vim.cmd.lopen, "[base]: open the [L]ocation list")
nmap("<leader>L", vim.cmd.lcl, "[base]: close the [L]ocation list")
nmap("]l", vim.cmd.lnext, "[base]: walk forward in [L]ocation list")
nmap("[l", vim.cmd.lprev, "[base]: walk backward in [L]ocation list")

-- lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = AUGRP,
	callback = function()
		nmap(
			"<leader>rn",
			vim.lsp.buf.rename,
			"[base/lsp]: [R]e[N]ame symbol"
		)
		nmap(
			"<leader>ic",
			vim.lsp.buf.incoming_calls,
			"[base/lsp]: [I]ncoming [C]alls"
		)
		nmap(
			"<leader>oc",
			vim.lsp.buf.outgoing_calls,
			"[base/lsp]: [O]utgoing [C]alls"
		)
		nmap(
			"<leader>ds",
			vim.lsp.buf.document_symbol,
			"[base/lsp]: [D]ocument [C]ymbol"
		)
		map(
			{ "n", "x" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			"[base/lsp]: open [C]ode [A]ctions"
		)
		nmap(
			"gD",
			vim.lsp.buf.declaration,
			"[base/lsp]: [G]oto [D]eclaration"
		)
		nmap(
			"gd",
			vim.lsp.buf.definition,
			"[base/lsp]: [G]oto [D]efinition"
		)
		nmap(
			"gr",
			vim.lsp.buf.references,
			"[base/lsp]: [G]et [R]eferences"
		)
		nmap(
			"gi",
			vim.lsp.buf.implementation,
			"[base/lsp]: [G]et [I]mplementations"
		)
	end,
})
