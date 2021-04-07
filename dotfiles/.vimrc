set nocompatible

set autoindent
" set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" set cindent cinkeys-=0#

set showmatch
set ruler
set number
set incsearch
" set virtualedit=all
set enc=utf8
syntax on

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

set completefunc=syntaxcomplete#Complete

set statusline+=%F
set laststatus=2

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
