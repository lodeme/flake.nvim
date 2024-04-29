require("rose-pine").setup({
	styles = {
		transparency = vim.g.transparent_background,
	},
})

if vim.g.theme == "rose-pine" then
	vim.cmd("colorscheme rose-pine-moon")
end

if vim.g.theme == "rose-pine-dawn" then
	vim.cmd("colorscheme rose-pine-dawn")
end
