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
