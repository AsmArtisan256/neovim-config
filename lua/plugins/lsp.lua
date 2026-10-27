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

-- floating windows with SANE BACKGROUND color
-- vim.cmd([[highlight NormalFloat ctermbg=black]])

-- OPTIONAL: LSP settings (for overriding per client)
-- vim.cmd([[highlight FloatBorder ctermfg=white]])

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

local on_attach = function(client, bufnr)
	local map = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
	end

	-- general mappings using FZF
	-- jump to definition
	-- vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map("<leader>cd", function()
		require("fzf-lua").lsp_definitions()
	end, "Goto Definition")
	-- jump to implementation
	-- vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	map("<leader>ci", function()
		require("fzf-lua").lsp_implementations()
	end, "Goto Implementation")
	-- jump to type definition
	-- vim.api.nvim_set_keymap("n", "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	map("<leader>cy", function()
		require("fzf-lua").lsp_typedefs()
	end, "Goto Type Definition")
	-- jump to references
	-- vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	map("<leader>cr", function()
		require("fzf-lua").lsp_references()
	end, "Goto References")
	-- rename
	map("<leader>rn", vim.lsp.buf.rename, "Rename")
	-- documentation
	map("K", Show_documentation, "Hover Documentation")
	-- code action
	map("<leader>a", vim.lsp.buf.code_action, "Code Action")

	-- line diagnostics
	map("gd", function()
		Show_line_diagnostics()
	end, "Line Diagnostics")

	local methods = vim.lsp.protocol.Methods
	if client:supports_method(methods.textDocument_inlayHint) then
		map("<F10>", function()
			local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
		end, "[t]oggle inlay [h]ints")
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

		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_augroup })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = highlight_augroup,
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = highlight_augroup,
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

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua
vim.lsp.config("lua_ls", {
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
})

-- C/C++
vim.lsp.config("clangd", {
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
})

-- Python
vim.lsp.config("pyright", {
	flags = { debounce_text_changes = 500 },
})

-- HTML/CSS/JS???
vim.lsp.config("html", {
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
})

vim.lsp.config("ts_ls", {
	flags = { debounce_text_changes = 1000, allow_incremental_sync = true },
})

-- Rust Tools
vim.lsp.config("rust_analyzer", {})

-- Zig
vim.lsp.config("zls", {
	flags = { debounce_text_changes = 500 },
	settings = {
		enable_autofix = true,
	},
})

-- LaTeX
vim.lsp.config("texlab", {
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
})

vim.lsp.config("kotlin_lsp", {
	flags = { debounce_text_changes = 500 },
	cmd = { "kotlin-lsp", "--stdio" },
	single_file_support = true,
	filetypes = { "kotlin" },
	root_markers = {
		"build.gradle",
		"build.gradle.kts",
		"pom.xml",
		"settings.gradle",
		".git",
	},
	settings = {},
})

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"zls",
	"pyright",
	"kotlin_lsp",
	"rust_analyzer",
	"org",
})

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

-- local configs = require("lspconfig.configs")

-- if not configs.kotlin_lsp then
-- 	configs.kotlin_lsp = {
-- 		default_config = {
-- 			cmd = { "kotlin-lsp" },
-- 			filetypes = { "kotlin", "java" },
-- 			root_markers = {
-- 				"build.gradle",
-- 				"build.gradle.kts",
-- 				"pom.xml",
-- 				"settings.gradle",
-- 				".git",
-- 			},
-- 			settings = {},
-- 		},
-- 	}
-- end
