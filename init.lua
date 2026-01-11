-- Here are some configs where I took ideas from (or copy pasted from)
-- thanks to `wincent`
-- https://github.com/wincent/wincent/
-- thanks to `RaafatTurki`
-- https://github.com/RaafatTurki/venom/
-- thanks to `benbrastmckie`
-- https://github.com/benbrastmckie/.config

vim.pack.add({
	-- theme
	-- "https://github.com/sainnhe/gruvbox-material",
	"https://github.com/catppuccin/nvim",
	-- "https://github.com/sainnhe/everforest",
	-- "https://github.com/andreasvc/vim-256noir",

	-- utils
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lua/plenary.nvim",

	-- vim lualine
	"https://github.com/nvim-lualine/lualine.nvim",

	-- better comments
	"https://github.com/terrortylor/nvim-comment",

	-- git support
	"https://github.com/tpope/vim-fugitive",

	-- git diffview
	"https://github.com/sindrets/diffview.nvim",

	-- git nice stuff
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/rhysd/git-messenger.vim",
	"https://github.com/rhysd/committia.vim",

	-- undo tree
	"https://github.com/mbbill/undotree",

	-- speed motion
	"https://github.com/phaazon/hop.nvim",

	-- multiple cursors
	-- "https://github.com/mg979/vim-visual-multi",
	"https://github.com/jake-stewart/multicursor.nvim",

	-- fzf
	"https://github.com/ibhagwan/fzf-lua",

	-- treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/playground",

	-- treesitter tags auto-pair
	"https://github.com/windwp/nvim-ts-autotag",

	-- autopairing
	"https://github.com/altermo/ultimate-autopair.nvim",

	-- latex
	-- "https://github.com/lervag/vimtex",
	-- "https://github.com/matze/vim-tex-fold",

	-- neovim lspconfig
	"https://github.com/neovim/nvim-lspconfig",

	-- lsp signature
	"https://github.com/ray-x/lsp_signature.nvim",

	-- nvim-cmp
	-- "https://github.com/hrsh7th/cmp-nvim-lsp",
	-- "https://github.com/hrsh7th/cmp-path",
	-- "https://github.com/hrsh7th/nvim-cmp",

	-- blink cmp
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.8.0",
	},

	-- formatter
	"https://github.com/sbdchd/neoformat",

	-- snippets
	"https://github.com/rafamadriz/friendly-snippets",

	-- which-key
	"https://github.com/folke/which-key.nvim",

	-- session manager
	-- "https://github.com/rmagatti/auto-session",
	-- "https://github.com/folke/persistence.nvim",
	"https://github.com/Shatur/neovim-session-manager",
	"https://github.com/coffebar/neovim-project",

	-- window pick
	"https://github.com/yorickpeterse/nvim-window",

	-- show indentation
	"https://github.com/echasnovski/mini.indentscope",

	-- distraction free editing
	"https://github.com/folke/zen-mode.nvim",

	-- EditorConfig
	"https://github.com/gpanders/editorconfig.nvim",

	-- vim surround
	"https://github.com/kylechui/nvim-surround",

	-- guess indentation
	"https://github.com/NMAC427/guess-indent.nvim",

	-- todo comments
	"https://github.com/folke/todo-comments.nvim",

	-- nvim lua dev
	"https://github.com/rafcamlet/nvim-luapad",
})

-- gotta go fast
vim.loader.enable()

-- initialize rest
require("initializer")

if vim.g.neovide then
	-- vim.o.guifont = "Iosevka_NFM_SemiBold:h16"
	-- vim.o.guifont = "Iosevka_Comfy:h16"
	vim.o.guifont = "Iosevka NFM SemiBold:h16"
	vim.o.linespace = 0
	vim.g.neovide_scale_factor = 1.2

	vim.g.neovide_padding_top = 2
	vim.g.neovide_padding_bottom = 2
	vim.g.neovide_padding_right = 2
	vim.g.neovide_padding_left = 2

	vim.g.neovide_floating_blur = true
	vim.g.neovide_floating_opacity = 0.1
	vim.g.neovide_floating_blur_amount_x = 4.0
	vim.g.neovide_floating_blur_amount_y = 4.0

	vim.g.neovide_opacity = 1.0
	vim.g.neovide_scroll_animation_length = 0.1

	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_underline_automatic_scaling = false

	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5

	vim.g.neovide_no_idle = false
	vim.g.neovide_fullscreen = false

	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 0.7

	vim.g.neovide_text_gamma = 0.8
	vim.g.neovide_text_contrast = 0.1

	vim.g.neovide_cursor_vfx_mode = "ripple"

	vim.g.neovide_floating_corner_radius = 0.25

	-- transparency
	vim.opt.pumblend = 30
	vim.opt.winblend = 30
end
