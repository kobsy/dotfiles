-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Show absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Expand tabs to spaces, 2 spaces wide
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Display command line's tab complete options as a menu
vim.opt.wildmenu = true

-- Show invisible characters
vim.opt.listchars = { eol = "¬", tab = ">·", trail = "~", extends = ">", precedes = "<", space = "·" }
vim.opt.list = true

-- Wrap by whole words when the file type is markdown
vim.cmd([[
  augroup WrapLineInMD
    autocmd!
    autocmd FileType markdown setlocal linebreak
  augroup END
]])
