-- background
vim.opt.background = "dark"

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	-- flavour = vim.g.neovide and "latte" or "mocha",
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = true, -- show the '~' characters after the end of buffers
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = { "italic" },
		functions = {},
		keywords = { "italic" },
		strings = { "bold" },
		variables = {},
		numbers = { "bold" },
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		all = {},
		mocha = {
			text = "#ffffff",
			overlay1 = "#f38ba8",
			surface2 = "#acb0be",

			base = "#000000",
			mantle = "#000000",
			crust = "#000000",

			-- text = "#ffffff",
			-- peach = "#ffffff",
			-- base = "#000000",
			-- mantle = "#585858",
			-- crust = "#000000",

			-- rosewater = "#ffffff",
			-- flamingo = "#a0a0a0",
			-- pink = "#ffffff",
			-- mauve = "#ffffff",
			-- red = "#ffffff",
			-- -- keywords
			-- maroon = "#ffffff",
			-- -- types
			-- yellow = "#ffffff",
			-- -- strings
			-- green = "#ffffff",
			-- -- also strings???
			-- teal = "#ffffff",
			-- -- symbols
			-- sky = "#ffffff",
			-- sapphire = "#ffffff",
			-- -- function names
			-- blue = "#ffffff",
			-- -- member names
			-- lavender = "#ffffff",
			-- number = "#900000",

			-- subtext1 = "#ffffff",
			-- subtext0 = "#ffffff",
			-- overlay2 = "#ffffff",
			-- overlay1 = "#ffffff",
			-- overlay0 = "#ffffff",
			-- surface2 = "#ffffff",

			-- surface1 = "#585858",
			-- surface0 = "#383838",
		},
	},
	custom_highlights = function(colors)
		return {
			rustTodo = { link = "Comment" },
			Todo = { link = "Comment" },
			["@comment.todo"] = { link = "Comment" },
		}
	end,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		treesitter_context = false,
		telescope = false,
		notify = false,
		mini = false,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.cmd.colorscheme("catppuccin")

-- highlight matching parenthesis with a more visible color
vim.cmd([[highlight MatchParen cterm=bold cterm=underline ctermfg=red guibg=blue guifg=limegreen]])

vim.cmd([[highlight WinSeparator ctermbg=grey guibg=#11111b ctermfg=grey guifg=grey]])

vim.cmd([[highlight VertSplit guifg=#f9e2af]])
