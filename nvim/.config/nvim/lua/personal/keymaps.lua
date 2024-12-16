vim.g.mapleader = " "

vim.keymap.set("n", "<leader>b", vim.cmd.Ex)

vim.keymap.set("i", "jk", "<Esc>", opts)

-- Pane Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Move Left
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Move Down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Move Up
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Move Right

-- Window Management
vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit, opts)
vim.keymap.set("n", "<leader>sh", vim.cmd.split, opts)

