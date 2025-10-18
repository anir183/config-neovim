--[[ treesitter.lua: treesitter syntax highlighting ]]

return {
	"nvim-treesitter/nvim-treesitter",
	name = "treesitter",
	build = ":TSUpdate",
	init = function(plugin)
		-- pre load the query predicates
		require("nvim-treesitter.query_predicates")

		-- prefer pasrser installations via git
		require("nvim-treesitter.install").prefer_git = true
	end,
	opts = {
		ensure_installed = {
			"lua",
			"vimdoc",
			"comment",
			"markdown",
			"markdown_inline",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		local configs = require("nvim-treesitter.parsers").get_parser_configs()
		for name, body in pairs(CONF_183.settings.treesitter_parsers) do
			configs[name] = body
		end
	end
}
