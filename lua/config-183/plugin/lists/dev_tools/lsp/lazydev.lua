--[[ lazydev.lua: neovim config oriented setup for lua-ls ]]

return {
	"folke/lazydev.nvim",
	name = "lazydev",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
		integrations = {
			blink = true,
		},
	},
}
