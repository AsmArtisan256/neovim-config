vim.g.compile_mode = {
    default_command = {
        c = "make -k ",
        cpp = "make -k ",
        zig = "zig build",
    },
    recompile_no_fail = true,
}

vim.keymap.set("n", "<leader>pc", ":below Compile<CR>")
-- vim.keymap.set("n", "<leader>r", ":below Recompile<CR>")
