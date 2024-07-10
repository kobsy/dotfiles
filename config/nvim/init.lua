require('plugins')

-- Show line numbers
vim.opt.number = true

-- Highlight the line the cursor is on
vim.opt.cursorline = true

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

-- Display command line's tab complete options as a menu
vim.opt.wildmenu = true

-- Buffer traversal commands
vim.keymap.set('n', '[b', ':bprevious!<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext!<CR>', { silent = true })
vim.keymap.set('n', '[B', ':bfirst!<CR>', { silent = true })
vim.keymap.set('n', ']B', ':blast!<CR>', { silent = true })

-- Quickfix traversal commands
vim.keymap.set('n', '[q', ':cprevious<CR>', { silent = true })
vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true })

-- Fly between buffers
vim.keymap.set('n', '<leader>r', ':ls t<CR>:b<space>')

-- Close the current buffer and move to the next buffer
vim.keymap.set('n', '<leader>w', ':bd<CR>:bnext!<CR>', { silent = true })

-- fzf integration
vim.opt.runtimepath:append('~/.fzf')
vim.keymap.set('n', '<C-p>', ':Files<CR>')
vim.keymap.set('n', '<leader>f', ':Files<CR>')

-- Set up project-wide search using fzf and ripgrep, omitting filename matches
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
]])
vim.keymap.set('n', '<C-g>', ':Rg!<CR>')

-- Grepper config
vim.keymap.set('n', '<leader>g', ':Grepper -tool rg -grepprg rg -H --no-heading --vimgrep --smart-case<CR>')
vim.keymap.set('n', '<leader>G', ':Grepper<CR>')

-- Testing config
vim.g['test#strategy'] = 'dispatch'
vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')

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

-- Store swap and undo files in the home directory instead of cluttering up repos
vim.opt.directory:prepend({ "$HOME/.vim/swap/" })
vim.opt.undodir:prepend({ "$HOME/.vim/undo/" })

-- Go ahead and persist undo history
vim.opt.undofile = true

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


-- Neotree settings
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Map <leader>b to toggle show/hide the tree
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>')


-- LSP Setup
-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnum)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnum }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = { 'ember', 'eslint', 'sourcekit' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Ruby linter setup
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
  callback = function()
    vim.lsp.start {
      name = "rubocop",
      cmd = { "bundle", "exec", "rubocop", "--lsp" },
    }
  end,
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
