-- multiple cursors
-- credits to https://github.com/dmtrKovalenko/dotfiles/blob/main/.config/nvim/lua/plugins/multicursor.lua

local mc = require("multicursor-nvim")
mc.setup({
	-- set to true if you want multicursor undo history
	-- to clear when clearing cursors
	shallowUndo = false,

	-- set to empty table to disable signs
	signs = { " ┆", " │", " ┃" },
})

vim.keymap.set({ "n", "x" }, "<C-S-d>", function()
	mc.matchAddCursor(1)
end)

-- Add or skip cursor above/below the main cursor.
vim.keymap.set({ "n", "v" }, "<C-A-j>", function()
	mc.lineAddCursor(1)
end)
-- vim.keymap.set({ "n", "v" }, "<C-A-down>", function()
-- 	mc.lineSkipCursor(1)
-- end)

vim.keymap.set("n", "<esc>", function()
	if not mc.cursorsEnabled() then
		mc.enableCursors()
	elseif mc.hasCursors() then
		mc.clearCursors()
	else
		-- Default <esc> handler.
	end
end)

-- Customize how cursors look.
vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
