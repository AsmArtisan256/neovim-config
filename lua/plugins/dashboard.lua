require("dashboard").setup({
	theme = "doom",
	hide = {
		statusline = true,
		tabline = true,
		winbar = true,
	},
	config = {
		center = {
			{
				icon = "󰈞  ",
				desc = "Open Session",
				action = "require(\"persistence\").select()",
				key = "z",
			},
			{
				icon = "󰈞  ",
				desc = "Find File",
				action = "FzfLua files",
				key = "a",
			},
			{
				icon = "󰈢  ",
				desc = "Recently opened files",
				action = "FzfLua oldfiles",
				key = "b",
			},
			{
				icon = "  ",
				desc = "Open Neovim config",
				action = "tabnew $MYVIMRC | tcd %:p:h",
				key = "d",
			},
			{
				icon = "  ",
				desc = "New file",
				action = "enew",
				key = "e",
			},
			{
				icon = "󰗼  ",
				desc = "Quit Nvim",
				action = "qa",
				key = "f",
			},
		},
		header = {},
		week_header = { enable = true },
		footer = {},
		packages = { enable = false },
	},
})
