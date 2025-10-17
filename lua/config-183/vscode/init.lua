--[[ init.lua: setup for when neovim is launched from within vscode as a vim
--             emulator ]]

-- check if this module is enabled
if not CONF_183.settings.module_toggles.minimal.keymaps then
	return
end

print("Launched in VSCode Mode")

-- TODO: Configure ig?
