-- taken from https://github.com/dmtrKovalenko/dotfiles/blob/main/.config/nvim/lua/plugins/sidebar.lua
require("outline").setup({
	outline_window = {
		position = "right",
		width = 35,
		auto_close = false,
		focus_on_open = false,
		relative_width = false,
		no_provider_message = "",
	},
})

-- for some reason I have to press <C-b> twice??
-- OHHH, I know, it's because of tmux!!
vim.keymap.set("n", "<C-b>", "<cmd>Outline<CR>", {})
