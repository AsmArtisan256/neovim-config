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
