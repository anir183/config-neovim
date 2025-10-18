--[[ blink.lua: auto completion engine ]]

return {
	"saghen/blink.cmp",
	name = "blink",
	main = "blink.cmp",
	version = "1.*",
	dependencies = "lazydev",
	opts = {
		keymap = {
			preset = "none",
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		sources = {
			default = {
				"lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- top priority
				},
			},
		},
	},
	config = function(_, opts)
		local blink = require("blink.cmp")
		local map = CONF_183.functions.map
		local nmap = CONF_183.functions.nmap

		blink.setup(opts)

		-- keypress emulation
		local feedkeys = function(keys)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(vim.keycode(keys), true, true, true), "ni", false)
		end

		-- hide or cancel completion menu
		map({ "i", "s" }, "<C-c>", function()
			if blink.is_visible() then
				blink.hide()
			else
				feedkeys("<C-c>")
			end
		end, "[plugin/blink]: hide completion menu")
		map({ "i", "s" }, "<C-x>", function()
			if blink.is_visible() then
				blink.cancel()
			else
				feedkeys("<C-x>")
			end
		end, "[plugin/blink]: cancel completion and hide")

		-- navigate completion menu
		map({ "i", "s" }, "<TAB>", function()
			if blink.is_visible() then
				blink.select_next()
				return
			end

			if not blink.snippet_forward() then
				feedkeys("<TAB>")
			end
		end, "[plugin/blink]: next item in completion menu")
		map({ "i", "s" }, "<S-TAB>", function()
			if blink.is_visible() then
				blink.select_prev()
				return
			end

			if not blink.snippet_backward() then
				feedkeys("<S-TAB>")
			end
		end, "[plugin/blink]: prev item in completion menu")

		-- accept completion
		map({ "i", "s" }, "<CR>", function()
			if not blink.accept() then
				feedkeys("<CR>")
			end
		end, "[plugin/blink]: accept completion suggestion")

		-- documentation window
		map({ "i", "s" }, "<C-k>", function()
			if blink.is_documentation_visible() then
				blink.hide_documentation()
			elseif blink.is_visible() then
				blink.show_documentation()
			else
				feedkeys("<C-k>")
			end
		end, "[plugin/blink]: toggle documentation window")
		map({ "i", "s" }, "<C-d>", function()
			if not blink.scroll_documentation_down(1) then
				feedkeys("<C-d>")
			end
		end, "[plugin/blink]: scroll down docs window")
		map({ "i", "s" }, "<C-u>", function()
			if not blink.scroll_documentation_up(1) then
				feedkeys("<C-u>")
			end
		end, "[plugin/blink]: scroll up docs window")
	end,
}
