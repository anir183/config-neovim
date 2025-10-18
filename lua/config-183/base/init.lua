--[[ init.lua: things dealing with core neovim stuff without major changes ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.base then
	return
end

require("config-183.base.options")
require("config-183.base.keymaps")
require("config-183.base.autocmds")

vim.filetype.add(CONF_183.settings.additional_filetypes)
