local LspConfig = require("lspconfig")
-- local Telescope = require("telescope.builtin")

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

local function fzf_goto_definition()
	local log = require("vim.lsp.log")

	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		require("fzf-lua").lsp_definitions({ sync = true })
	end

	return handler
end

local function fzf_goto_references()
	local log = require("vim.lsp.log")

	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		require("fzf-lua").lsp_references({ sync = true })
	end

	return handler
end

-- setup handlers with border
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	-- ["textDocument/definition"] = require('fzf-lua').lsp_definitions,
	["textDocument/definition"] = function()
		require("fzf-lua").lsp_definitions()
	end,
	["textDocument/references"] = fzf_goto_references(),
}

-- floating windows with SANE BACKGROUND color
-- vim.cmd([[highlight NormalFloat ctermbg=black]])

-- OPTIONAL: LSP settings (for overriding per client)
-- vim.cmd([[highlight FloatBorder ctermfg=white]])

local function config(_config)
	local _capabilities = vim.lsp.protocol.make_client_capabilities()
	_capabilities.textDocument.completion.completionItem.snippetSupport = true

	return vim.tbl_deep_extend("force", {
		-- capabilities = require("cmp_nvim_lsp").default_capabilities(_capabilities),
		capabilities = require("blink.cmp").get_lsp_capabilities(_capabilities),
	}, _config or {})
end

local on_attach = function(client, bufnr)
	-- attach lsp signature
	require("lsp_signature").on_attach({
		bind = true,
		hint_enable = true,
		hint_prefix = "",
		floating_window = false,
		extra_trigger_chars = { "(", "," },
		handler_opts = { border = "single" },
	})

	local opts = { noremap = true, silent = true }

	-- general mappings using FZF
	-- jump to definition
	-- vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
	-- jump to implementation
	-- vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>lua require('fzf-lua').lsp_implementations()()<CR>", opts)
	-- jump to type definition
	-- vim.api.nvim_set_keymap("n", "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>cy", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
	-- jump to references
	-- vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
	-- rename
	vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- documentation
	vim.api.nvim_set_keymap("n", "K", ":call Show_documentation()<CR>", opts)
	-- code action
	vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	-- line diagnostics
	vim.api.nvim_set_keymap("n", "gd", "<cmd>lua Show_line_diagnostics()<CR>", opts)

	local methods = vim.lsp.protocol.Methods
	if client:supports_method(methods.textDocument_inlayHint) then
		vim.keymap.set("n", "<F10>", function()
			local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not is_enabled)
		end, { desc = "[t]oggle inlay [h]ints" })
	end

	-- formatting
	-- if client.resolved_capabilities.document_formatting then
	--     vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- end

	-- range formatting
	-- if client.resolved_capabilities.document_range_formatting then
	--     vim.api.nvim_set_keymap('v', '<leader>ff', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
	-- end

	-- document highlight
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
			  "hi! LspReferenceRead cterm=bold ctermbg=237 guibg=gray29
			  "hi! LspReferenceText cterm=bold ctermbg=237 guibg=gray29
			  "hi! LspReferenceWrite cterm=bold ctermbg=237 guibg=gray29

			  "hi DiagnosticUnderlineError cterm=underline gui=underline guisp=#840000
			  "hi DiagnosticUnderlineHint cterm=underline  gui=underline guisp=#07455b
			  "hi DiagnosticUnderlineWarn cterm=underline  gui=underline guisp=#2f2905
			  "hi DiagnosticUnderlineInfo cterm=underline  gui=underline guisp=#265478
        ]])

		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end
end

-- Diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "x",
		source = "always",
	},
})

-- Lua
LspConfig.lua_ls.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
	settings = {
		Lua = {
			completion = { workspaceWord = false },
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			telemetry = { enable = false },
		},
	},
}))

-- C/C++
LspConfig.clangd.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
	-- root_dir = LspConfig.util.root_pattern("compile_commands.json", ".git"),
	cmd = {
		-- see clangd --help-hidden
		"clangd",
		"--background-index",
		-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
		-- to add more checks, create .clang-tidy file in the root directory
		-- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
		"--clang-tidy",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--header-insertion=never",
	},
}))

-- Python
LspConfig.pyright.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
}))

-- HTML/CSS/JS???
LspConfig.html.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
	settings = {
		html = {
			format = {
				templating = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
}))

LspConfig.ts_ls.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 1000, allow_incremental_sync = true },
}))

-- Rust Tools
LspConfig.rust_analyzer.setup({
	on_attach = on_attach,
	handlers = handlers,
})
-- require("rust-tools").setup({
-- 	server = config({
-- 		on_attach = on_attach,
-- 		handlers = handlers,
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				lens = { enable = true },
-- 				checkOnSave = { command = "clippy" },
-- 				assist = {
-- 					importGranularity = "module",
-- 					importPrefix = "self",
-- 				},
-- 				cargo = {
-- 					loadOutDirsFromCheck = true,
-- 				},
-- 				procMacro = {
-- 					enable = false,
-- 				},
-- 			},
-- 		},
-- 	}),
-- })

-- Zig
LspConfig.zls.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
	settings = {
		enable_autofix = true,
	},
}))

-- Kotlin
-- LspConfig.kotlin_language_server.setup(config({
-- 	on_attach = on_attach,
-- 	handlers = handlers,
-- 	flags = { debounce_text_changes = 500 },
-- }))

-- LaTeX
LspConfig.texlab.setup(config({
	on_attach = on_attach,
	handlers = handlers,
	flags = { debounce_text_changes = 500 },
	settings = {
		build = {
			-- this doesnt seem to work
			executable = "lualatex",
			args = { "-shell-escape", "-interaction=nonstopmode", "-synctex=1", "%f" },
		},
		chktex = {
			onOpenAndSave = false,
			onEdit = false,
		},
	},
}))

function Show_line_diagnostics()
	local opts = {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = border,
		source = "if_many",
		prefix = "",
	}
	vim.diagnostic.open_float(nil, opts)
end
