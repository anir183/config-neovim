--[[ theme.lua: using catppuccin frappe as editor theme ]]

return CONF_183.settings.module_toggles.plugin.aesthetics.theme
		and {
			"catppuccin/nvim",
			name = "catppuccin",
			priority = CONF_183.lazy.plugin_priorities.high,
			opts = {
				flavour = "frappe",
				transparent_background = true,
				float = {
					transparent = true,
				},
				show_end_of_buffer = true,
			},
			config = function(_, opts)
				require("catppuccin").setup(opts)
				vim.cmd.colorscheme("catppuccin")
				vim.api.nvim_set_hl(
					0,
					"IncSearch",
					{ bg = "#ea999c", fg = "#232634" }
				)

				-- statusline
				local fmt_str = "%%#%s#%s%%*" -- format string
				CONF_183.statusline.component_functions.filename = function()
					local flname = vim.fn.expand("%:p:t")
					flname = flname == "" and vim.fn.expand("%") or flname
					flname = flname == "" and "unnamed" or flname
					return fmt_str:format("DiffFile", "[" .. flname .. "]")
				end

				CONF_183.statusline.component_functions.position = function()
					return fmt_str:format(
						"DiffIndexLine",
						"[%02l:%02c ~ %2p%%]"
					)
				end

				CONF_183.statusline.component_functions.indent = function()
					local type = vim.opt_local.expandtab._value and "spaces"
						or "tabs"
					local len = vim.opt_local.tabstop._value

					return fmt_str:format(
						"Label",
						("[" .. type .. " : " .. len .. "]")
					)
				end
			end,
		}
	or {}
