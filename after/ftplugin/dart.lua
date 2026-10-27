vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.api.nvim_buf_set_keymap(0, '', '<F5>', ':w<CR>:FlutterRun<CR>', { noremap = true, silent = false })

