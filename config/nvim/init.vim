call plug#begin()

Plug 'cloudhead/neovim-fuzzy'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

nnoremap <C-p> :FuzzyOpen<CR>
nnoremap <C-n> :NERDTreeTabsToggle<CR>
nnoremap <C-`> <C-\><C-n>
"nnoremap <C-F> :FuzzyGrep<Space>

set number
set showmatch

set expandtab
set tabstop=2
set shiftwidth=2

set splitbelow
set splitright

set background = "dark"
colorscheme one
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
set termguicolors

highlight Comment cterm=italic
