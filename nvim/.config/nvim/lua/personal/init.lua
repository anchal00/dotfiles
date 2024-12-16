require("personal.keymaps")
require("personal.pckr")
require("personal.opts")

local save_group = vim.api.nvim_create_augroup('SaveGroup', {})
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd("BufWritePre", {
    group = save_group,
    pattern = "*",
    -- Remove trailing spaces
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
