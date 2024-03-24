vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cw", ":wincmd c")
vim.keymap.set('n', '<leader>e', ":lua vim.diagnostic.open_float()<CR>")
