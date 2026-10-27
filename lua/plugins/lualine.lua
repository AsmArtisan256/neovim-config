-- LuaLine object
local LuaLine = require("lualine")

-- foreground colors
local colors = {
	black = "#1d2021",
	white = "#fbf1c7",
	red = "#fb4934",
	green = "#b8bb26",
	blue = "#83a598",
	yellow = "#fabd2f",
	aqua = "#8ec07c",
	purple = "#d3869b",
	gray = "#a89984",
	darkgray = "#3c3836",
	lightgray = "#504945",
	inactivegray = "#7c6f64",
}

local function lsp_name()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return "No Active Lsp"
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return table.concat(names, ", ")
end

-- theme changes
-- local theme = require("lualine.themes.auto")
-- theme.normal.c.bg = "#1a1a1a"
-- theme.inactive.c.bg = "#1a1a1a"

LuaLine.setup({
	options = {
		theme = "everforest",
		always_divide_middle = true,
		icons_enabled = true,
		disabled_filetypes = { "NvimTree" },
		globalstatus = true,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode" },
		},
		lualine_b = {
			"branch",
			"diff",
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "  ", warn = "  ", info = "  " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.green },
					hint = { fg = colors.blue },
				},
				colored = true,
			},
		},
		lualine_c = {
			{
				"filename",
			},
		},
		lualine_x = {
			{ lsp_name, icon = "  LSP:" },
			{ vim.lsp.status },
		},
		lualine_y = { "progress" },
		lualine_z = { "location", "selectioncount" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename" } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
})
