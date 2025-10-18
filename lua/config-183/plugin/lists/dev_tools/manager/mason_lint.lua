--[[ mason_lint.lua: bridge between nvim-lint and mason ]]

return {
	"rshkarin/mason-nvim-lint",
	name = "mason-lint",
	dependencies = {
		"mason",
		"lint",
	},
	opts = {
		automatic_installation = true,
	},
}
