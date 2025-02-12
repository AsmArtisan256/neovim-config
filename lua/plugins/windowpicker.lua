vim.api.nvim_set_keymap(
	"n",
	"-",
	"<cmd>lua require('nvim-window').pick()<CR>",
	{ noremap = false, silent = true }
)
