local theme_parser = {
	["everforest"] = "everforest",
	["gruvbox"] = "gruvbox",
	["kanagawa"] = "seoul256",
	["rose-pine"] = "rose-pine-alt",
	["rose-pine-dawn"] = "rose-pine",
}

require("lualine").setup({
	options = {
		theme = theme_parser[vim.g.theme],
	},
})
