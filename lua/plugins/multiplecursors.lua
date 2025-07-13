-- multiple cursors

vim.g.VM_theme = "neon"
vim.g.VM_highlight_matches = "underline"

vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1

vim.g.VM_maps = {
	["Find Under"] = "<A-n>",
	["Find Subword Under"] = "<A-n>",
	["Undo"] = "u",
	["Redo"] = "<C-r>",
	["Add Cursor Up"] = "<A-C-Up>",
	["Add Cursor Down"] = "<A-C-Down>",
	["Select l"] = "",
	["Select h"] = "",
    -- fix incompatibilities between autocompletion
    -- and multiple cursors plugin
    -- this does make the plugin usage way worse tbh
	["I BS"] = "",
	["Goto Next"] = "]v",
	["Goto Prev"] = "[v",
	["I CtrlB"] = "<M-b>",
	["I CtrlF"] = "<M-f>",
	["I Return"] = "<A-CR>",
	["I Down Arrow"] = "",
	["I Up Arrow"] = "",
}

-- delete for good, I have no clue why
-- defining Select h and Select l
-- as empty is not sufficient!
vim.keymap.del('n', '<S-Left>')
vim.keymap.del('n', '<S-Right>')
