
set t_Co=256
let hs_highlight_boolean=1
let hs_highlight_types=1
let hs_highlight_more_types=1

syntax on

call pathogen#infect()
set expandtab
set tabstop=4
set shiftwidth=4
set nocompatible


au BufNewFile,BufRead *.html\|*.htm set foldmethod=indent

"autocmd BufWinLeave *.* mkview!
"autocmd BufWinEnter *.* silent loadview call Pl#Load()
"autocmd BufWinEnter *.* loadview

autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2
autocmd Filetype html setlocal tabstop=2 shiftwidth=2
autocmd Filetype eruby setlocal tabstop=2 shiftwidth=2

set textwidth=0

set nu
set bg=dark
"colorscheme slate
if $SOLARIZED == "true"
    colorscheme solarized
elseif $TERM == "linux"
    colorscheme desert
else
    colorscheme mymolokai
endif

set guifont=termsyn
"set guifont=DejaVuSansMono-Powerline
let Powerline_symbols = 'fancy'
let g:clang_user_options='|| exit 0'
let g:clang_use_library=1
set completeopt=menu
set laststatus=2
set foldmethod=syntax
set foldlevelstart=20
set encoding=utf-8
set fileencoding=utf-8

cnoreabbrev install !sudo make install

cnoreabbrev :W :w
cnoreabbrev Wq wq

function! OnEnter()
    silent loadview
"    call Pl#Load()
endfunction

"if has("autocmd")
"  augroup myvimrchooks
"    au!
"    autocmd bufwritepost .vimrc nested source ~/.vimrc
"  augroup END
"endif

"augroup Powerline
"  au!
"  au BufRead * call Pl#Load()
"augroup END
