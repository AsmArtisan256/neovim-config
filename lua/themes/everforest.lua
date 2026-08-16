vim.opt.background = "dark"

vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = true

-- require("everforest").setup({
-- 	background = "hard",
-- 	ui_contrast = "high",
-- 	italics = true,

-- 	colours_override = function(p)
-- 		p.bg_dim = "#0d1011"
-- 		p.bg0 = "#161a1c"
-- 		p.bg1 = "#202628"
-- 		p.bg2 = "#2a3235"
-- 		p.bg3 = "#364044"
-- 		p.bg4 = "#455155"
-- 		p.bg5 = "#586663"

-- 		p.fg = "#f2ead8"
-- 		p.grey0 = "#849087"
-- 		p.grey1 = "#9da99f"
-- 		p.grey2 = "#b8c3b8"

-- 		p.bg_visual = "#5a3f4c"
-- 		p.bg_red = "#583d43"
-- 		p.bg_green = "#3d5147"
-- 		p.bg_blue = "#365867"
-- 		p.bg_yellow = "#55543e"
-- 		p.bg_purple = "#55465b"
-- 	end,
-- })

require("everforest").setup({
	background = "hard",
	ui_contrast = "high",
	italics = true,

	colours_override = function(p)
		p.bg_dim = "#0c1011"
		p.bg0 = "#151a1b"
		p.bg1 = "#202728"
		p.bg2 = "#2b3435"
		p.bg3 = "#394445"
		p.bg4 = "#4a5655"
		p.bg5 = "#5d6b67"

		p.bg_visual = "#634452"
		p.bg_red = "#663f48"
		p.bg_green = "#3c5749"
		p.bg_blue = "#365e6d"
		p.bg_yellow = "#5d5a3d"
		p.bg_purple = "#5c4963"

		p.fg = "#f4ead5"
		p.grey0 = "#89968c"
		p.grey1 = "#a3afa5"
		p.grey2 = "#c0c9bf"

		p.red = "#f28a8f"
		p.orange = "#f2ad7c"
		p.yellow = "#e8ca7a"
		p.green = "#b7d88d"
		p.aqua = "#93d9a6"
		p.blue = "#8bcfc7"
		p.purple = "#e5a1c3"

		p.statusline1 = "#b7d88d"
		p.statusline2 = "#f4ead5"
		p.statusline3 = "#f28a8f"
	end,
})

vim.cmd.colorscheme("everforest")
