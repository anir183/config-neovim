--[[ default options in case the user hasnt provided any ]]

return {
	plugins = {
		-- generic lazy syntax
		-- {
		-- 	"plugin/link",
		-- 	name = "",
		-- 	...
		-- },
	},
	additional_filetypes = {
		-- add new filetype corrsponding to extension
		extension = {
			-- ext = "filetype",
		},
		-- add new filetype corrsponding to filename
		filename = {
			-- ["name.ext"] = "filetype",
		},
		-- add new filetype corrsponding to pattern
		pattern = {
			-- ["regex_pattern"] = "filetype",
		},
	},
	after = function()
		-- anything here gets executed on VimEnter after the config has been definitely loaded
	end,
	ts_parsers = {
		-- additional parser and/or configurations
		-- parser_name = { parser parameters }
		dotenv = {
			install_info = {
				url = "https://github.com/pnx/tree-sitter-dotenv",
				branch = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "dotenv",
		},
	},
	lsps = {
		-- list of lsp names can be found in mason via the :Mason command
		-- lsp_name = { lspopts }, -- alternatively false to only install and not setup
		lua_ls = { settings = { Lua = { callSnippet = "Replace" } } },
	},
	formatters = {
		-- mason package names can differ from formatter names
		-- list of names can be found in mason via the :Mason command
		mason = {
			-- "mason_package_names",
			-- "clang-format",
		},
		-- possible formatters https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
		-- filetype = { "formatter1", "foramtter2", stop_after_first = false },
		-- c = { "clang-format" },
	},
	-- setup examples in https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
	custom_formatters = {
		-- formatter = {
		-- 	command = "whatever",
		-- 	env = {} "whatever",
		-- 	...
		-- },
	},
	linters = {
		-- mason package names can differ from linter names
		-- list of names can be found in mason via the :Mason command
		mason = {
			-- "mason_package_names",
		},
		-- possible linters https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
		-- filetype = { "linter1", "linter2" },
	},
	-- setup examples in https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#custom-linters
	custom_linters = {
		-- linter = {
		-- 	cmd = "",
		-- 	stdin = true,
		-- 	args = {},
		-- 	...
		-- },
	},
	-- setup examples in https://github.com/jay-babu/mason-nvim-dap.nvim?tab=readme-ov-file#advanced-customization
	daps = { -- for daps available in mason
		-- dap_name = function(config) handler code end, [OR]
		-- dap_name = nil,
	},
	-- setup examples in https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	dap_other = { -- for daps manuallt installed
		-- {
		-- 	adapter_name = {
		-- 		type = "",
		-- 		command = "",
		-- 		args = {},
		-- 		...
		-- 	},
		-- 	configuration_name = {
		-- 		type = "",
		-- 		name = "",
		-- 		...
		-- 	},
		-- },
	},
	cloak_patterns = {
		{
			file_pattern = { "*.env", ".env*" },
			cloak_pattern = { "=.+", ":.=" },
			replace = nil,
		},
	},
}
