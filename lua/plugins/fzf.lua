-- Fzf object
local Fzf = require("fzf-lua")
local FzfActions = require("fzf-lua.actions")

-- TODO: these might be useless
vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info"
vim.env.FZF_DEFAULT_COMMAND =
	"rg --files --hidden --glob '!.git/**' --glob '!.github/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules' --glob '!resources' --glob '!lib/**' --glob '!.cache/**'"

Fzf.setup({
	fzf_opts = {
		["--inline-info"] = "",
		["--prompt"] = "❯ ",
		["--pointer"] = "❯ ",
		["--marker"] = "❯ ",
		["--ansi"] = "",
		["--height"] = "100%",
		["--layout"] = "reverse",
		["--border"] = "none",
	},
	file_ignore_patterns = {
		"^tests/",
		"^.dart_tool/",
		"^.idea/",
		"^.git/",
		"^lib/",
		"^.cache/",
		"^resources/",
		"^.github/",
		"^build/",
		"target"
	},
	files = {
		prompt = "Files❯ ",
	},
	winopts = {
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		-- hl = {
		-- 	border = "FloatBorder",
		-- },
		preview = {
			title = true,
			winopts = {
				number = false,
				relativenumber = false,
				cursorline = true,
				cursorlineopt = "both",
				cursorcolumn = false,
				signcolumn = "no",
				list = false,
				foldenable = false,
				foldmethod = "manual",
			},
		},
	},
	previewers = {
		man = {
			cmd = "man %s | col -bx",
		},
	},
	grep = {
		rg_opts = "--trim --column --line-number --no-heading --color=always --smart-case --hidden",
	},
	actions = {
		files = {
			["default"] = FzfActions.file_edit_or_qf,
			["ctrl-x"] = FzfActions.file_split,
			["ctrl-v"] = FzfActions.file_vsplit,
			["ctrl-t"] = FzfActions.file_tabedit,
			["alt-q"] = FzfActions.file_sel_to_qf,
		},
		buffers = {
			["default"] = FzfActions.buf_edit,
			["ctrl-x"] = FzfActions.buf_split,
			["ctrl-v"] = FzfActions.buf_vsplit,
			["ctrl-t"] = FzfActions.buf_tabedit,
		},
	},
	keymap = {
		builtin = {
			["<F1>"] = "toggle-help",
			["<F2>"] = "toggle-fullscreen",
			-- Only valid with the 'builtin' previewer
			["<F3>"] = "toggle-preview-wrap",
			["<F4>"] = "toggle-preview",
			["<F5>"] = "toggle-preview-ccw",
			["<F6>"] = "toggle-preview-cw",
			["<S-left>"] = "preview-page-reset",
			["<PageDown>"] = "preview-page-down",
			["<PageUp>"] = "preview-page-up",
		},
		fzf = {
			["ctrl-z"] = "abort",
			["ctrl-u"] = "unix-line-discard",
			["shift-down"] = "half-page-down",
			["shift-up"] = "half-page-up",
			["ctrl-a"] = "beginning-of-line",
			["ctrl-e"] = "end-of-line",
			["alt-a"] = "toggle-all",
			-- Only valid with fzf previewers (bat/cat/git/etc)
			["f3"] = "toggle-preview-wrap",
			["f4"] = "toggle-preview",
			["page-down"] = "preview-page-down",
			["page-up"] = "preview-page-up",
		},
	},
})

-- Commands
-- show files
vim.api.nvim_set_keymap("n", "<leader>zF", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
-- show buffers
vim.api.nvim_set_keymap(
	"n",
	"<leader>zb",
	"<cmd>lua require('fzf-lua').buffers()<CR>",
	{ noremap = true, silent = true }
)
-- show commands
vim.api.nvim_set_keymap("n", "<leader>zc", "<cmd>lua require('fzf-lua').commands()<CR>", {})
-- manpages
vim.api.nvim_set_keymap("n", "<leader>zm", "<cmd>lua require('fzf-lua').man_pages()<CR>", {})
-- execute rg with fzf
vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua require('fzf-lua').grep_project()<CR>", {})

-- show commits
vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", {})
-- show files under git
vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>lua require('fzf-lua').git_files()<CR>", {})

-- show mappings
vim.api.nvim_set_keymap("n", "<F1>", "<cmd>lua require('fzf-lua').keymaps()<CR>", {})
