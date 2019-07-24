" Show line numbers
set number

" Expand tabs to spaces, 2 spaces wide
set tabstop=2 shiftwidth=2 expandtab

" Highlight all search results
set hlsearch

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Buffer traversal commands
nnoremap <silent> [b :bprevious
nnoremap <silent> ]b :bnext
nnoremap <silent> [B :bfirst
nnoremap <silent> ]B :blast

" Turn on syntax highlighting
syntax on

" fzf integration
set rtp+=~/.fzf

" Show invisible characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set list

" Autoindenting
set autoindent
set smartindent

" Display tabline at top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" vim-gitgutter settings
set updatetime=100

" Powerline symbols in airline
let g:airline_powerline_fonts = 1
