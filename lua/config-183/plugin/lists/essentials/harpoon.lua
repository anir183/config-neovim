--[[ harpoon.lua: quick file and buffer switcher ]]

return {
	"ThePrimeagen/harpoon",
	name = "harpoon",
	branch = "harpoon2",
	dependencies = "plenary",
	opts = {
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		},
	},
	lazy = false,
	keys = {
		-- general
		{
			mode = "n",
			"<leader>H",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "[plugin/harpoon]: open [H]arpoon list"
		},
		{
			mode = "n",
			"<leader>h",
			function() require("harpoon"):list():add() end,
			desc = "[plugin/harpoon]: add file to [H]arpoon list"
		},

		-- navigation
		{
			mode = "n",
			"<A-1>",
			function() require("harpoon"):list():select(1) end,
			desc = "[plugin/harpoon]: navigate to file [1]"
		},
		{
			mode = "n",
			"<A-2>",
			function() require("harpoon"):list():select(2) end,
			desc = "[plugin/harpoon]: navigate to file [2]"
		},
		{
			mode = "n",
			"<A-3>",
			function() require("harpoon"):list():select(3) end,
			desc = "[plugin/harpoon]: navigate to file [3]"
		},
		{
			mode = "n",
			"<A-4>",
			function() require("harpoon"):list():select(4) end,
			desc = "[plugin/harpoon]: navigate to file [4]"
		},
		{
			mode = "n",
			"<A-5>",
			function() require("harpoon"):list():select(5) end,
			desc = "[plugin/harpoon]: navigate to file [5]"
		},
		{
			mode = "n",
			"]h",
			function() require("harpoon"):list():next() end,
			desc = "[plugin/harpoon]: navigate to next file in list"
		},
		{
			mode = "n",
			"[h",
			function() require("harpoon"):list():prev() end,
			desc = "[plugin/harpoon]: navigate to previous file in list"
		},
	}
}
