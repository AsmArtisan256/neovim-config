-- NvimTree object
local NvimTree = require("nvim-tree")

NvimTree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	sync_root_with_cwd = true,
	hijack_directories = {
		enable = false,
		auto_open = false,
	},
	renderer = {
		root_folder_label = false,
		indent_markers = {
			enable = false,
		},
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	view = {
		preserve_window_proportions = true,
		side = "right",
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
})

vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1, folder_arrows = 1 }

vim.g.nvim_tree_icons = {
	git = {
		unstaged = "~",
		staged = "+",
		unmerged = "",
		renamed = ">",
		untracked = "",
		deleted = "-",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
	lsp = {
		warning = "⊗",
		error = "⊗",
	},
}
