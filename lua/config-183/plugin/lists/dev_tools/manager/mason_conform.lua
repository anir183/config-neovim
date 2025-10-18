--[[ mason_conform.lua: bridge between conform and mason ]]

return {
	"zapling/mason-conform.nvim",
	name = "mason-conform",
	dependencies = {
		"mason",
		"conform",
	},
	opts = {}
}
