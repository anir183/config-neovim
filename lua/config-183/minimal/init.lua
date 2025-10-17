--[[ init.lua: minimal configuration with only essential setup ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.minimal then
	return
end

print("Launched in Minimal Mode")

require("config-183.minimal.options")
require("config-183.minimal.keymaps")
