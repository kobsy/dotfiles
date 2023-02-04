require('plugins')

-- Show line numbers
vim.opt.number = true

-- Expand tabs to spaces, 2 spaces wide
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Highlight all search results
vim.opt.hlsearch = true

-- Perform incremental search
vim.opt.incsearch = true

-- allow backspacing over everything in insert mode
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- turn on the mouse for moving buffers
vim.opt.mouse = 'a'

-- Buffer traversal commands
vim.keymap.set('n', '[b', ':bprevious!<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext!<CR>', { silent = true })
vim.keymap.set('n', '[B', ':bfirst!<CR>', { silent = true })
vim.keymap.set('n', ']B', ':blast!<CR>', { silent = true })

-- Fly between buffers
vim.keymap.set('n', '<leader>t', ':ls t<CR>:b<space>')

-- Close the current buffer and move to the next buffer
vim.keymap.set('n', '<leader>w', ':bd<CR>:bnext!<CR>', { silent = true })

-- fzf integration
vim.opt.runtimepath:append('~/.fzf')
vim.keymap.set('n', '<C-p>', ':Files<CR>')
vim.keymap.set('n', '<leader>p', ':Files<CR>')

-- Set up project-wide search using fzf and ripgrep, omitting filename matches
vim.api.nvim_create_user_command('Rg', [[
  call fzf#vim#grep(
    'rg --column --line-number --hidden --no-heading --color=always '.shellescape(<q-args>), 1,
    <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
    : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
    <bang>0)
  ]], { bang = true, nargs = '*' })
vim.keymap.set('n', '<C-g>', ':Rg!<CR>')

-- Show invisible characters
vim.opt.listchars = { eol = '¬', tab = '>·', trail = '~', extends = '>', precedes = '<', space = '·' }
vim.opt.list = true

-- Color whitespace and comments using dark gray
vim.api.nvim_set_hl(0, 'SpecialKey', { ctermfg = 'DarkGray' })
vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 'DarkGray' })

-- Use dracula color scheme
vim.cmd([[colorscheme dracula]])

-- Autoindenting
vim.opt.autoindent = true
vim.opt.smartindent = true

-- vim-gitgutter settings
vim.opt.updatetime = 100

-- Store swap files in the home directory instead of cluttering up repos
vim.opt.directory:prepend({ "$HOME/.vim/swap/" })

-- Some lsp servers have issues with backup files; probably good for git, too
vim.opt.backup = false
vim.opt.writebackup = false

-- if hidden is not set, TextEdit might fail.
vim.opt.hidden = true

-- Always show signcolumns
vim.opt.signcolumn = 'yes'

-- Airline settings
-- Display tabline at top
vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])
vim.cmd([[let g:airline#extensions#tabline#formatter = 'unique_tail_improved']])
-- Powerline symbols in airline
vim.cmd([[let g:airline_powerline_fonts = 1]])

-- Improve airline mode switching
vim.opt.ttimeoutlen = 10

-- Nvim-tree Settings
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  }
})

-- Map <leader>b to toggle show/hide the tree
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>')

