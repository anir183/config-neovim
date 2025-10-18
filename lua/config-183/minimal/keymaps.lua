--[[ keymaps.lua: only important keymaps ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.minimal.keymaps then
	return
end

local map = CONF_183.functions.map
local nmap = CONF_183.functions.nmap

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- moving text
-- WARNING : using "<cmd>" instead of ":" breaks these commands
nmap("<C-j>", "v:m '>+1<CR>gv=<ESC>", "[base]: move the current line up")
nmap("<C-k>", "v:m '<-2<CR>gv=<ESC>", "[base]: move the current line down")
map("v", "<C-j>", ":m '>+1<CR>gv=<ESC>gv", "[base]: move current selection up")
map(
	"v",
	"<C-k>",
	":m '<-2<CR>gv=<ESC>gv",
	"[base]: move current selection down"
)

-- modification or extensions of existing keymaps
map({ "n", "v" }, "x", "\"_x", "[base]: remove without copying")
map("x", "<leader>p", "\"_dP", "[base]: paste over selection without copying")
map({ "n", "v" }, "<leader>y", "\"+y", "[base]: yank to system clipboard")
nmap("<leader>Y", "\"+Y", "[base]: yank till end of line to system clipboard")
map({ "n", "v" }, "<leader>d", "\"_d", "[base]: delete without copying")
nmap("<leader>D", "\"_D", "[base]: delete till end of line without copying")
map(
	{ "n", "v" },
	"<leader>c",
	"\"_c",
	"[base]: delete and edit without copying"
)
nmap("<leader>C", "\"_C", "[base]: delete till eol and edit without copying")

-- quick fix list
nmap("<leader>q", vim.cmd.copen, "[base]: open the [Q]uick fix list")
nmap("<leader>Q", vim.cmd.ccl, "[base]: close the [Q]uick fix list")
nmap("]q", vim.cmd.cnext, "[base]: walk forward in [Q]uick fix list")
nmap("[q", vim.cmd.cprev, "[base]: walk backward in [Q]uick fix list")
