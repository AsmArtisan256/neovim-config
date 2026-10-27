-- makeprg
vim.opt_local.makeprg = "make"

vim.bo.commentstring = "// %s"

-- keymaps
vim.api.nvim_buf_set_keymap(0, '', '<F5>', ':w<CR>:!./compile.sh<CR>', { noremap = true, silent = false })
vim.api.nvim_buf_set_keymap(0, '', '<F6>', ':w<CR>:!make all<CR>', { noremap = true, silent = false })
