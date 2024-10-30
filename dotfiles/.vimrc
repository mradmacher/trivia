set nocompatible

set autoindent
" set smartindent
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" set cindent cinkeys-=0#
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType rust setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd BufNewFile,BufRead *.gohtml setlocal syntax=html

set showmatch
set ruler
set number
set cursorline
hi cursorline cterm=NONE ctermbg=242
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
nnoremap <leader>c :let @*=expand('%')<CR>

set completefunc=syntaxcomplete#Complete

set laststatus=2
set statusline=
set statusline +=\ %n\ %*            "buffer number
set statusline +=%{&ff}%*            "file format
set statusline +=%y%*                "file type
set statusline +=\ %<%F%*            "full path
set statusline +=%m%*                "modified flag
set statusline +=%=%5l%*             "current line
set statusline +=/%L%*               "total lines
set statusline +=%4v\ %*             "virtual column number
set statusline +=0x%04B\ %*          "character under cursor
hi statusline ctermfg=12 ctermbg=15

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
