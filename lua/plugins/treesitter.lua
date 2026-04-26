-- Treesitter object
local TreeSitter = require("nvim-treesitter")

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

local ensureInstalled = {
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
	"vim",
}
local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
	:filter(function(parser)
		return not vim.tbl_contains(alreadyInstalled, parser)
	end)
	:totable()
require("nvim-treesitter").install(parsersToInstall)

-- treesitter
TreeSitter.setup({
	ignore_install = { "latex" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = function(_, bufnr)
			local max_filesize = 1024 * 1024 -- 100 KB
			local disable = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max_filesize
			if disable then
				-- NOTE: disable ultimate-autopair to improve performance
				require("ultimate-autopair").disable()
				return true
			else
				return false
			end
		end,
	},
	autopairs = {
		enable = true,
		disable = function(_, bufnr)
			local max_filesize = 1024 * 1024 -- 100 KB
			local disable = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max_filesize
			if disable then
				-- NOTE: disable ultimate-autopair to improve performance
				require("ultimate-autopair").disable()
				return true
			else
				return false
			end
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
