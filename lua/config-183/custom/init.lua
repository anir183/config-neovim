--[[ init.lua: things dealing with core neovim stuff to create new or changed
--             functionality ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.custom then
	return
end

require("config-183.custom.netrw")
require("config-183.custom.commands")
require("config-183.custom.keymaps")
require("config-183.custom.statusline")
