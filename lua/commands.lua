--
-- autocommands
--

local U = require("utils")

-- Highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.hl.on_yank({ higroup = "TermCursor", timeout = 400 })
	end,
})

-- help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- when to check if the file has been changed in another program
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})

-- insert mode when it enters terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	command = [[
     if line("'\"") > 0 && line("'\"") <= line("$")
         exe "normal! g`\""
     endif
    ]],
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- nasm
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.S", "*.s", "*.asm", "*.inc" },
	command = "setlocal filetype=asm syntax=nasm commentstring=;\\%s",
})

-- remove trailing whitespaces
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if vim.bo.buftype ~= "" or not vim.bo.modifiable then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

-- do not autocoment on newlines
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal fo-=c fo-=r fo-=o",
})

-- exit quickfix window on enter keypress
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	command = "nnoremap <buffer> <CR> <CR>:cclose<CR>",
})

-- NOTE: ok, this is totally insane and crazy
-- I don't know if it is related to this or not
-- but I gotta find out why this works
local function should_save_view(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return false
	end
	if vim.bo[buf].buftype ~= "" then
		return false
	end
	local ft = vim.bo[buf].filetype
	if ft == "" or ft:match("^Neogit") or ft:match("^diffview") or ft == "qf" or ft == "help" then
		return false
	end
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" or not vim.uv.fs_stat(name) then
		return false
	end
	return not U.is_buf_huge(buf)
end

-- save folds
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
	callback = function(ev)
		if should_save_view(ev.buf) then
			vim.cmd([[silent! mkview]])
		end
	end,
})

-- load folds
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function(ev)
		if should_save_view(ev.buf) then
			vim.cmd([[silent! loadview]])
		end
	end,
})

--
-- user commands
--

vim.api.nvim_create_user_command("Scratch", function()
	CreateScratchBuffer(true)
end, {})

vim.api.nvim_create_user_command("Scratchh", function()
	CreateScratchBuffer(false)
end, {})

vim.api.nvim_create_user_command("TimeStamp", function()
	InsertDateStamp()
end, {})

-- LSP
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
	desc = "Show LSP Info",
})

vim.api.nvim_create_user_command("LspLog", function(_)
	local state_path = vim.fn.stdpath("state")
	local log_path = vim.fs.joinpath(state_path, "lsp.log")

	vim.cmd(string.format("edit %s", log_path))
end, {
	desc = "Show LSP log",
})

vim.api.nvim_create_user_command("LspRestart", "lsp restart", {
	desc = "Restart LSP",
})

-- Treesitter
local max_filesize = 1024 * 1024
vim.api.nvim_create_autocmd("FileType", {
	desc = "Setup native Treesitter features",
	callback = function(args)
		local bufnr = args.buf
		local file_path = vim.api.nvim_buf_get_name(bufnr)

		local ok, stats = pcall(vim.uv.fs_stat, file_path)
		local disable_ts = ok and stats and stats.size > max_filesize

		if disable_ts then
			vim.bo[bufnr].syntax = "on"
			return
		end

		pcall(vim.treesitter.start, bufnr)
	end,
})
