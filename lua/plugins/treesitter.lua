-- Treesitter object
local TreeSitter = require("nvim-treesitter.configs")

-- treesitter
TreeSitter.setup({
	ensure_installed = {
		"rust",
		"c",
		"cpp",
		"lua",
		"python",
		"dart",
		"css",
		"html",
		"javascript",
		"typescript",
		"tsx",
		"java",
		"kotlin",
		"zig",
		"bash",
		"query",
		"smali",
		"markdown",
		"markdown_inline",
		"vimdoc",
		"org",
	},
	ignore_install = { "latex" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = function(_, bufnr)
			-- NOTE: disable ultimate-autopair to improve performance
			require("ultimate-autopair").disable()

			local max_filesize = 100 * 1024 -- 100 KB
			return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max_filesize
		end,
	},
	autopairs = {
		enable = true,
		disable = function(_, bufnr)
			-- TODO: this one isn't triggering at all??
			require("ultimate-autopair").disable()
			local max_filesize = 100 * 1024 -- 100 KB
			return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max_filesize
		end,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<M-]>",
			node_incremental = "<M-]>",
			node_decremental = "<M-[>",
		},
	},
	indent = {
		enable = false,
		disable = {},
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
