-- Here are some configs where I took ideas from (or copy pasted from)
-- thanks to `wincent`
-- https://github.com/wincent/wincent/
-- thanks to `RaafatTurki`
-- https://github.com/RaafatTurki/venom/
-- thanks to `benbrastmckie`
-- https://github.com/benbrastmckie/.config

-- Plugged object
local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.config/nvim/plugged")

-- theme
Plug("sainnhe/gruvbox-material")
Plug("catppuccin/nvim")
Plug("sainnhe/everforest")
Plug("andreasvc/vim-256noir")

-- utils
Plug("nvim-lua/plenary.nvim")
-- Plug("nvim-telescope/telescope.nvim")

-- vim lualine
Plug("nvim-lualine/lualine.nvim")

-- better comments
Plug("terrortylor/nvim-comment")

-- git support
Plug("tpope/vim-fugitive")

-- git diffview
Plug("sindrets/diffview.nvim")

-- git nice stuff
Plug("lewis6991/gitsigns.nvim")
Plug("rhysd/git-messenger.vim")
Plug("rhysd/committia.vim")

-- undo tree
Plug("mbbill/undotree")

-- speed motion
Plug("phaazon/hop.nvim")

-- multiple cursors
Plug("mg979/vim-visual-multi")

-- fzf
Plug("ibhagwan/fzf-lua")

-- nvim tree
Plug("kyazdani42/nvim-tree.lua")

-- treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/playground")

-- treesitter tags auto-pair
Plug("windwp/nvim-ts-autotag")

-- autopairing
Plug("altermo/ultimate-autopair.nvim")

-- latex
Plug("lervag/vimtex")
Plug("matze/vim-tex-fold")

-- neovim lspconfig
Plug("neovim/nvim-lspconfig")

-- lsp signature
Plug("ray-x/lsp_signature.nvim")

-- nvim-cmp
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/nvim-cmp")

-- blink cmp
Plug("saghen/blink.cmp", { branch = "v1.3.0" })

-- dart lsp
Plug("akinsho/flutter-tools.nvim")

-- rust tools
Plug("simrat39/rust-tools.nvim")

-- formatter
Plug("sbdchd/neoformat")

-- UltiSnips
-- Plug("SirVer/ultisnips")
-- Plug("quangnguyen30192/cmp-nvim-ultisnips")

-- snippets
Plug("rafamadriz/friendly-snippets")

-- which-key
Plug("folke/which-key.nvim")

-- session manager
Plug("rmagatti/auto-session")

-- window pick
Plug("yorickpeterse/nvim-window")

-- show indentation
Plug("echasnovski/mini.indentscope")

-- distraction free editing
Plug("junegunn/goyo.vim")

-- Rust
Plug("rust-lang/rust.vim")

-- EditorConfig
Plug("gpanders/editorconfig.nvim")

-- orgmode
-- Plug("nvim-orgmode/orgmode")

-- vim surround
Plug("kylechui/nvim-surround")

-- guess indentation
Plug("NMAC427/guess-indent.nvim")

-- todo comments
Plug("folke/todo-comments.nvim")

-- fold
-- Plug("anuvyklack/pretty-fold.nvim")

-- nvim lua dev
Plug("rafcamlet/nvim-luapad")

vim.call("plug#end")

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
