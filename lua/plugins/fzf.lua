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

-- commands
vim.api.nvim_create_user_command("FzfBuffers", require("fzf-lua").buffers, {})
vim.api.nvim_create_user_command("FzfFiles", require("fzf-lua").files, {})
vim.api.nvim_create_user_command("FzfOldfiles", require("fzf-lua").oldfiles, {})
vim.api.nvim_create_user_command("FzfQuickfix", require("fzf-lua").quickfix, {})
vim.api.nvim_create_user_command("FzfLoclist", require("fzf-lua").loclist, {})
vim.api.nvim_create_user_command("FzfLines", require("fzf-lua").lines, {})
vim.api.nvim_create_user_command("FzfBlines", require("fzf-lua").blines, {})
vim.api.nvim_create_user_command("FzfTabs", require("fzf-lua").tabs, {})
vim.api.nvim_create_user_command("FzfArgs", require("fzf-lua").args, {})
-- commands grep
vim.api.nvim_create_user_command("FzfGrep", require("fzf-lua").grep, {})
vim.api.nvim_create_user_command("FzfGrepLast", require("fzf-lua").grep_last, {})
vim.api.nvim_create_user_command("FzfGrepCword", require("fzf-lua").grep_cword, {})
vim.api.nvim_create_user_command("FzfGrepCWORD", require("fzf-lua").grep_cWORD, {})
vim.api.nvim_create_user_command("FzfGrepVisual", require("fzf-lua").grep_visual, {})
vim.api.nvim_create_user_command("FzfGrepProject", require("fzf-lua").grep_project, {})
vim.api.nvim_create_user_command("FzfGrepCurbuf", require("fzf-lua").grep_curbuf, {})
vim.api.nvim_create_user_command("FzfGrepLiveCurbuf", require("fzf-lua").lgrep_curbuf, {})
vim.api.nvim_create_user_command("FzfGrepLive", require("fzf-lua").live_grep, {})
vim.api.nvim_create_user_command("FzfGrepLiveResume", require("fzf-lua").live_grep_resume, {})
vim.api.nvim_create_user_command("FzfGrepLiveGlob", require("fzf-lua").live_grep_glob, {})
vim.api.nvim_create_user_command("FzfGrepLiveNative", require("fzf-lua").live_grep_native, {})
-- commands git
vim.api.nvim_create_user_command("FzfGitFiles", require("fzf-lua").git_files, {})
vim.api.nvim_create_user_command("FzfGitStatus", require("fzf-lua").git_status, {})
vim.api.nvim_create_user_command("FzfGitCommits", require("fzf-lua").git_commits, {})
vim.api.nvim_create_user_command("FzfGitBcommits", require("fzf-lua").git_bcommits, {})
vim.api.nvim_create_user_command("FzfGitBranches", require("fzf-lua").git_branches, {})
-- commands lsp
vim.api.nvim_create_user_command("FzfLspReferences", require("fzf-lua").lsp_references, {})
vim.api.nvim_create_user_command("FzfLspDefinitions", require("fzf-lua").lsp_definitions, {})
vim.api.nvim_create_user_command("FzfLspDeclarations", require("fzf-lua").lsp_declarations, {})
vim.api.nvim_create_user_command("FzfLspTypedefs", require("fzf-lua").lsp_typedefs, {})
vim.api.nvim_create_user_command("FzfLspImplementations", require("fzf-lua").lsp_implementations, {})
vim.api.nvim_create_user_command("FzfLspDocumentSymbols", require("fzf-lua").lsp_document_symbols, {})
vim.api.nvim_create_user_command("FzfLspWorkspaceSymbols", require("fzf-lua").lsp_workspace_symbols, {})
vim.api.nvim_create_user_command("FzfLspLiveWorkspaceSymbols", require("fzf-lua").lsp_live_workspace_symbols, {})
vim.api.nvim_create_user_command("FzfLspCodeActions", require("fzf-lua").lsp_code_actions, {})
vim.api.nvim_create_user_command("FzfLspDocumentDiagnostics", require("fzf-lua").lsp_document_diagnostics, {})
vim.api.nvim_create_user_command("FzfLspWorkspaceDiagnostics", require("fzf-lua").lsp_workspace_diagnostics, {})
-- commands misc
vim.api.nvim_create_user_command("FzfMiscResume", require("fzf-lua").resume, {})
vim.api.nvim_create_user_command("FzfMiscBuiltin", require("fzf-lua").builtin, {})
vim.api.nvim_create_user_command("FzfMiscHelpTags", require("fzf-lua").help_tags, {})
vim.api.nvim_create_user_command("FzfMiscManPages", require("fzf-lua").man_pages, {})
vim.api.nvim_create_user_command("FzfMiscColorschemes", require("fzf-lua").colorschemes, {})
vim.api.nvim_create_user_command("FzfMiscCommands", require("fzf-lua").commands, {})
vim.api.nvim_create_user_command("FzfMiscCommandHistory", require("fzf-lua").command_history, {})
vim.api.nvim_create_user_command("FzfMiscSearchHistory", require("fzf-lua").search_history, {})
vim.api.nvim_create_user_command("FzfMiscMarks", require("fzf-lua").marks, {})
vim.api.nvim_create_user_command("FzfMiscJumps", require("fzf-lua").jumps, {})
vim.api.nvim_create_user_command("FzfMiscChanges", require("fzf-lua").changes, {})
vim.api.nvim_create_user_command("FzfMiscRegisters", require("fzf-lua").registers, {})
vim.api.nvim_create_user_command("FzfMiscKeymaps", require("fzf-lua").keymaps, {})
vim.api.nvim_create_user_command("FzfMiscSpellSuggest", require("fzf-lua").spell_suggest, {})
vim.api.nvim_create_user_command("FzfMiscTags", require("fzf-lua").tags, {})
vim.api.nvim_create_user_command("FzfMiscBtags", require("fzf-lua").btags, {})
vim.api.nvim_create_user_command("FzfMiscFiletypes", require("fzf-lua").filetypes, {})
vim.api.nvim_create_user_command("FzfMiscPackadd", require("fzf-lua").packadd, {})
