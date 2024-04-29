require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			ovveride_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf") -- telescope-fzf-native.nvim
require("telescope").load_extension("helpgrep") -- telescope-helpgrep.nvim

local builtin = require("telescope.builtin")

-- Find
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ile" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[g]it file" })
vim.keymap.set("n", "<leader>ft", builtin.live_grep, { desc = "[t]ext" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[b]uffer" })
vim.keymap.set("n", "<leader>fS", builtin.treesitter, { desc = "Treesitter [S]ymbols" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[h]elp" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[c]ommands" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[r]esume search" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[k]eymap" })
vim.keymap.set("n", "<leader>cs", builtin.lsp_workspace_symbols, { desc = "LSP [s]ymbols" })

-- Code
vim.keymap.set("n", "<leader>cq", builtin.quickfix, { desc = "[q]uickfix" })
vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, { desc = "LSP [s]ymbols" })
vim.keymap.set("n", "<leader>cr", builtin.lsp_references, { desc = "[r]eferences" })
vim.keymap.set("n", "<leader>cd", builtin.lsp_definitions, { desc = "[d]efinition" })
vim.keymap.set("n", "<leader>ct", builtin.lsp_type_definitions, { desc = "[t]ype definition" })
vim.keymap.set("n", "<leader>cm", builtin.lsp_implementations, { desc = "[i]mplementations" })
