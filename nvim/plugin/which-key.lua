vim.opt.timeout = true
vim.opt.timeoutlen = 300

require("which-key").setup()

require("which-key").register({
	["<Leader>c"] = { name = "+Code" },
	["<Leader>f"] = { name = "+Find" },
	["<leader>q"] = { name = "+Quit" },
})
