-- local Cmp = require("cmp")

-- local kind_icons = {
-- 	Class = " ",
-- 	Color = " ",
-- 	Constant = " ",
-- 	Constructor = " ",
-- 	Enum = "了 ",
-- 	EnumMember = " ",
-- 	Field = " ",
-- 	File = " ",
-- 	Folder = " ",
-- 	Function = " ",
-- 	Interface = "ﰮ ",
-- 	Keyword = " ",
-- 	Method = "ƒ ",
-- 	Module = " ",
-- 	Property = " ",
-- 	Snippet = "﬌ ",
-- 	Struct = " ",
-- 	Text = " ",
-- 	Unit = " ",
-- 	Value = " ",
-- 	Variable = " ",
-- }

-- local has_words_before = function(char)
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
-- 		return false
-- 	end
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	if not char then
-- 		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- 	else
-- 		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col) == char
-- 	end
-- end

-- local has_any_words_before = function()
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
-- 		return false
-- 	end
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local press = function(key)
-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
-- end

-- Cmp.setup({
-- 	-- definition of conditions of when it should be enabled/disable
-- 	enabled = function()
-- 		-- disable completion in comment
-- 		local context = require("cmp.config.context")
-- 		-- keep command mode completion enable when cursor is in a comment
-- 		if vim.api.nvim_get_mode().mode == "c" then
-- 			return true
-- 		else
-- 			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
-- 		end
-- 	end,
-- 	-- snippets
-- 	snippet = {
-- 		expand = function(args)
-- 			vim.fn["UltiSnips#Anon"](args.body)
-- 		end,
-- 	},
-- 	cmdline = Cmp.mapping.preset.insert({}),
-- 	mapping = Cmp.mapping.preset.insert({
-- 		["<C-d>"] = Cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = Cmp.mapping.scroll_docs(4),
-- 		-- ['<Tab>'] = Cmp.mapping(Cmp.mapping.select_next_item(), { 'i', 's' }),
-- 		["<S-Tab>"] = Cmp.mapping(Cmp.mapping.select_prev_item(), { "i", "s" }),
-- 		["<C-Space>"] = Cmp.mapping(Cmp.mapping.complete(), { "i", "c" }),
-- 		["<CR>"] = Cmp.mapping.confirm({ select = false }),
-- 		-- ["<Tab>"] = Cmp.mapping(function(fallback)
-- 		-- 	if vim.fn.pumvisible() == 1 then
-- 		-- 		if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
-- 		-- 			return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
-- 		-- 		end
-- 		-- 		vim.fn.feedkeys(t("<C-n>"), "n")
-- 		-- 	elseif check_back_space() then
-- 		-- 		vim.fn.feedkeys(t("<tab>"), "n")
-- 		-- 	else
-- 		-- 		fallback()
-- 		-- 	end
-- 		-- end, { "i", "s" }),
-- 		["<Tab>"] = Cmp.mapping(function(fallback)
-- 			if Cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
-- 				press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
-- 			elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
-- 				press("<ESC>:call UltiSnips#JumpForwards()<CR>")
-- 			elseif Cmp.visible() then
-- 				Cmp.select_next_item()
-- 			-- elseif vim.fn["vsnip#available"](1) == 1 then
-- 			--   feedkey("<Plug>(vsnip-expand-or-jump)", "")
-- 			elseif has_any_words_before() then
-- 				press("<Tab>")
-- 			else
-- 				press("<Tab>")
-- 				-- this adds another TAB???? this doesn't make sense
-- 				-- fallback()
-- 			end
-- 		end, { "i", "s" }),
-- 		["<C-e>"] = Cmp.mapping(function(fallback)
-- 			if
-- 				vim.fn.complete_info()["selected"] == -1
-- 				and vim.fn["UltiSnips#CanExpandSnippet"]() ~= 1
-- 				and has_words_before()
-- 				and Cmp.visible()
-- 			then
-- 				if not has_words_before(".") then
-- 					Cmp.confirm({ select = true })
-- 				else
-- 					fallback()
-- 				end
-- 			else
-- 				fallback()
-- 			end
-- 		end, {
-- 			"i",
-- 			"s",
-- 		}),
-- 	}),
-- 	view = {
-- 		entries = {
-- 			name = "custom",
-- 			selection_order = "top_down",
-- 		},
-- 	},
-- 	completion = {
-- 		completeopt = "menu,noselect",
-- 		keyword_length = 1,
-- 	},
-- 	window = {
-- 		documentation = {
-- 			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
-- 			winhighlight = "FloatBorder:NormalFloat",
-- 		},
-- 		completion = {
-- 			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
-- 			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
-- 		},
-- 	},
-- 	experimental = {
-- 		native_menu = false,
-- 		ghost_text = false,
-- 	},
-- 	sources = Cmp.config.sources({
-- 		{ name = "nvim_lsp" },
-- 		{ name = "ultisnips" },
-- 		{ name = "path" },
-- 		{ name = "vimtex" },
-- 		{
-- 			name = "latex_symbols",
-- 			filetype = { "tex", "latex" },
-- 			option = { cache = true }, -- avoids reloading each time
-- 		},
-- 	}),
-- 	formatting = {
-- 		fields = { "abbr", "menu", "kind" },
-- 		format = function(entry, item)
-- 			-- Define menu shorthand for different completion sources.
-- 			local menu_icon = {
-- 				nvim_lsp = "NLSP",
-- 				nvim_lua = "NLUA",
-- 				luasnip = "LSNP",
-- 				buffer = "BUFF",
-- 				path = "PATH",
-- 			}
-- 			-- Set the menu "icon" to the shorthand for each completion source.
-- 			item.menu = menu_icon[entry.source.name]

-- 			-- Set the fixed width of the completion menu to 60 characters.
-- 			-- fixed_width = 20

-- 			-- Set 'fixed_width' to false if not provided.
-- 			fixed_width = fixed_width or false

-- 			-- Get the completion entry text shown in the completion window.
-- 			local content = item.abbr

-- 			-- Set the fixed completion window width.
-- 			if fixed_width then
-- 				vim.o.pumwidth = fixed_width
-- 			end

-- 			-- Get the width of the current window.
-- 			local win_width = vim.api.nvim_win_get_width(0)

-- 			-- Set the max content width based on either: 'fixed_width'
-- 			-- or a percentage of the window width, in this case 20%.
-- 			-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
-- 			local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

-- 			-- Truncate the completion entry text if it's longer than the
-- 			-- max content width. We subtract 3 from the max content width
-- 			-- to account for the "..." that will be appended to it.
-- 			if #content > max_content_width then
-- 				item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
-- 			else
-- 				item.abbr = content .. (" "):rep(max_content_width - #content)
-- 			end
-- 			return item
-- 		end,
-- 	},
-- 	-- formatting = {
-- 	-- 	fields = { "kind", "abbr", "menu" },
-- 	-- 	format = function(entry, vim_item)
-- 	-- 		-- Kind icons
-- 	-- 		vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
-- 	-- 		-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
-- 	-- 		vim_item.menu = ({
-- 	-- 			-- omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
-- 	-- 			vimtex = (vim_item.menu ~= nil and vim_item.menu or ""),
-- 	-- 			nvim_lsp = "[LSP]",
-- 	-- 			luasnip = "[Snippet]",
-- 	-- 			buffer = "[Buffer]",
-- 	-- 			spell = "[Spell]",
-- 	-- 			latex_symbols = "[Symbols]",
-- 	-- 			cmdline = "[CMD]",
-- 	-- 			path = "[Path]",
-- 	-- 		})[entry.source.name]
-- 	-- 		return vim_item
-- 	-- 	end,
-- 	-- },
-- 	-- performance = {
-- 	-- 	trigger_debounce_time = 500,
-- 	-- 	throttle = 550,
-- 	-- 	fetching_timeout = 80,
-- 	-- },
-- })

local Blink = require("blink.cmp")
Blink.setup({
	keymap = { preset = "enter" },

	appearance = {
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- will be removed in a future release
		use_nvim_cmp_as_default = true,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},

		menu = {
			enabled = true,
			min_width = 15,
			max_height = 10,
			border = "rounded",
			winblend = 0,
			winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			-- Keep the cursor X lines away from the top/bottom of the window
			scrolloff = 2,
			-- Note that the gutter will be disabled when border ~= 'none'
			scrollbar = true,
			-- Which directions to show the window,
			-- falling back to the next direction when there's not enough space
			direction_priority = { "s", "n" },

			-- Whether to automatically show the window when new completion items are available
			auto_show = false,
		},

		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
			window = {
				border = "rounded",
			},
		},
	},

	signature = {
		enabled = true,
	},

	-- fuzzy = {
	-- 	prebuilt_binaries = {
	-- 		force_version = "v0.7.6",
	-- 	},
	-- },

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		-- optionally disable cmdline completions
		-- cmdline = {},

		providers = {
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				opts = {
					friendly_snippets = true,
					search_paths = { vim.fn.stdpath("config") .. "/snippets" },
					global_snippets = { "all" },
					extended_filetypes = {},
					ignored_filetypes = {},
					get_filetype = function(context)
						return vim.bo.filetype
					end,
				},

				--- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
				-- enabled = function(ctx)
				--   return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
				-- end,
			},
		},
	},
})
