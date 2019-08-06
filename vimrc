" Show line numbers
set number

" Expand tabs to spaces, 2 spaces wide
set tabstop=2 shiftwidth=2 expandtab

" Highlight all search results
set hlsearch

" Perform incremental search
set incsearch

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Buffer traversal commands
nnoremap <silent> [b :bprevious!<CR>
nnoremap <silent> ]b :bnext!<CR>
nnoremap <silent> [B :bfirst!<CR>
nnoremap <silent> ]B :blast!<CR>

" Turn on syntax highlighting
syntax on

" fzf integration
set rtp+=~/.fzf
nnoremap <C-p> :Files<CR>

" Set up fzf to use ripgrep and omit filename matches
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <C-g> :Rg!<CR>

" Show invisible characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" Color whitespace and comments using dark gray
hi SpecialKey ctermfg=DarkGray
hi Comment ctermfg=DarkGray

" Use atom-dark color scheme
colorscheme atom-dark-256

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

" Improve airline mode switching
set ttimeoutlen=10

" Integrate ale with airline
let g:airline#extensions#ale#enabled = 1

" Load all the helptags, should always be at the
" end of the file
packloadall
silent! helptags ALL
