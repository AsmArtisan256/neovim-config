require("neovim-project").setup({
	projects = {
		"~/Documents/Projects/Projects-Personal/*",
	},
	picker = {
		type = "fzf-lua",
	},
	last_session_on_startup = false,
    dashboard_mode = false,
})

-- require("auto-session").setup({
-- 	cwd_change_handling = true,
-- 	enabled = false,
-- 	log_level = "error",
-- 	post_cwd_changed_cmds = {
-- 		function()
-- 			require("lualine").refresh()
-- 		end,
-- 	},
-- 	suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
-- })

-- -- persistence
-- local persistence = require("persistence")
-- persistence.setup({
-- 	dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
-- })

-- vim.keymap.set("n", "ql", function()
-- 	persistence.load()
-- end, {})

-- vim.keymap.set("n", "qs", function()
-- 	persistence.select()
-- end, {})

-- -- NOTE: this is some dumb hack to get persistence sessions in FZF
-- local fzf = require("fzf-lua")
-- local session_dir = vim.fn.stdpath("state") .. "/sessions"

-- local function get_filename(path)
-- 	return path:match("^.+[/\\](.+)$") or path
-- end

-- local function load_session_with_fzf()
-- 	local sessions = vim.fn.glob(session_dir .. "/*.vim", false, true)

-- 	if vim.tbl_isempty(sessions) then
-- 		vim.notify("No sessions found in " .. session_dir, vim.log.levels.WARN)
-- 		return
-- 	end

-- 	local formatted_sessions = {}
-- 	for _, path in ipairs(sessions) do
-- 		local project_path = get_filename(path)
-- 		local project_path_parsed = project_path:gsub("%%", "/")
-- 		project_path_parsed = project_path_parsed:gsub("%.vim$", "")
-- 		table.insert(
-- 			formatted_sessions,
-- 			{ name = project_path_parsed, path = path, project_path = project_path_parsed }
-- 		)
-- 	end

-- 	fzf.fzf_exec(
-- 		vim.tbl_map(function(s)
-- 			return s.name
-- 		end, formatted_sessions),
-- 		{
-- 			prompt = "Sessions> ",
-- 			previewer = "builtin",
-- 			actions = {
-- 				["default"] = function(selected)
-- 					local chosen = vim.tbl_filter(function(s)
-- 						return s.name == selected[1]
-- 					end, formatted_sessions)[1]
-- 					if chosen then
-- 						vim.fn.chdir(chosen.project_path)
-- 						persistence.load()
-- 					end
-- 				end,
-- 			},
-- 		}
-- 	)
-- end

-- -- optional keybind
-- vim.keymap.set("n", "<leader>fs", load_session_with_fzf, { desc = "FZF: Load session" })
