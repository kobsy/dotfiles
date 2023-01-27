" Initialize vim-plug
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'jparise/vim-graphql'

if has('nvim')
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
endif

call plug#end()

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

" turn on the mouse for moving buffers
set mouse+=a

" Turn on filetype-specific rules
filetype plugin on

" Buffer traversal commands
nnoremap <silent> [b :bprevious!<CR>
nnoremap <silent> ]b :bnext!<CR>
nnoremap <silent> [B :bfirst!<CR>
nnoremap <silent> ]B :blast!<CR>

" Fly between buffers
nnoremap <leader>t :ls t<CR>:b<space>

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

" Set up nvim-tree
if has('nvim')
lua << EOF
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  open_on_setup = true,
  update_focused_file = {
    enable = true
  }
})
EOF

nnoremap <leader>b :NvimTreeToggle<CR>
nnoremap <leader>w :bd<CR>:bnext<CR>

endif

" Show invisible characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" Map star and hash to search for selection in visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

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
" let g:airline#extensions#ale#enabled = 1

" Store swap files in the home directory instead of cluttering up repos
set directory^=$HOME/.vim/swap//

" Various configuration for coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files; probably good for git, too
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

" Load all the helptags, should always be at the
" end of the file
packloadall
silent! helptags ALL
