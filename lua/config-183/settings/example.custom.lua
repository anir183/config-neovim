--[[ example.custom.lua: my custom configuration settings as an example ]]

return {
	-- neovim modes
	minimal_mode = false,
	verbose_mode = false,

	-- size of netrw sidebar
	netrw_winsize = 17,

	-- prefix for custom commands
	cmd_pre = "CMD",

	-- extra plugins to be installed
	-- uses generic lazy syntax
	plugins = {
		{
			"nvim-flutter/flutter-tools.nvim",
			name = "flutter-tools",
			dependencies = { "plenary", "lspconfig", "dap" },
			config = function()
				require("flutter-tools").setup({
					debugger = {
						enabled = true,
					},
				})
			end,
		},
		{
			"pmizio/typescript-tools.nvim",
			name = "typescript-tools",
			dependencies = { "plenary", "lspconfig" },
			config = function()
				require("typescript-tools").setup({})
			end,
		},
	},

	-- disable all other plugins to create a plugin testing environment
	-- false or nil to use normal plugins
	test_plugins = false,

	-- to be executed on the VimEnter event, after config is loaded
	after = function()
		-- vim.opt.bla = bla;
	end,

	-- lsps and their setup
	-- lsp names to be taken from mason
	lsps = {
		html = {},
		cssls = {},
		emmet_language_server = {},
		lua_ls = {
			settings = {
				Lua = {
					callSnippet = "Replace",
				},
			},
		},
		clangd = {},
	},

	-- formatters and their setup
	-- formatter names to be taken from conform (https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
	formatters = {
		lua = { "stylua", lsp_format = "never" },
		json = { "fixjson", lsp_format = "never" },
	},

	-- setup custom formatters not available on mason or conform
	-- follow https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
	custom_formatters = {
		-- formatter_name = {
		--     command = "whatever",
		--     env = ...,
		--     ...
		-- }
	},

	-- linters and their setup
	-- linter names to be taken from nvim-lint (https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)
	linters = {
		json = { "jsonlint" },
	},

	-- setup custom formatters not available on mason or nvim-lint
	-- follow https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#custom-linters
	custom_linters = {
		-- linter_name = {
		--     cmd = "whatever",
		--     stdin = true,
		--     args = {},
		--     ...
		-- }
	},

	-- daps and their setup
	-- dap names to be taken from mason
	-- setup examples in https://github.com/jay-babu/mason-nvim-dap.nvim?tab=readme-ov-file#advanced-customization
	daps = {
		-- dap1_name = function(config) <handler code> end,
		-- dap2_name = nil,
	},

	-- setup custom daps not available on mason
	-- follow https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	custom_daps = {
		-- {
		--     adapter_name = {
		--         type = "",
		--         command = "",
		--         args = {},
		--         ...
		--     },
		--     configuration_name = {
		--         type = "",
		--         name = "",
		--         ...
		--     }
		-- },
	},

	-- add new filetypes according to extension, filename or regex patterns
	additional_filetypes = {
		extension = {
			env = "dotenv",
		},
		filename = {
			[".env"] = "dotenv",
		},
		pattern = {
			["%.env%.[%w_.-]+"] = "dotenv",
		},
	},

	-- setup custom treesitter not included with treesitter
	treesitter_parsers = {
		dotenv = {
			install_info = {
				url = "https://github.com/pnx/tree-sitter-dotenv",
				branch = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "dotenv",
		},
	},

	-- patterns and file types to obscure for safety
	cloak_patterns = {
		{
			file_pattern = { ".env", ".env.*" },
			cloak_pattern = { "=.+" },
			replace = nil,
		},
		{
			file_pattern = { "*secret.json", "secret*.json" },
			cloak_pattern = { ":.+" },
			replace = nil,
		},
	},

	-- toggle different configuration modules on and off
	-- toggling a module-group turns off all modules under it
	-- module_toggles = { } -- keeps defaults
	-- module_toggles = false -- turn off all modules
	module_toggles = {}
}
