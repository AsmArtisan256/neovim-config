require("auto-session").setup({
	cwd_change_handling = true,
	enabled = false,
	log_level = "error",
	post_cwd_changed_cmds = {
		function()
			require("lualine").refresh()
		end,
	},
	suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
})
