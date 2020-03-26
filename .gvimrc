" Appearance
set guifont=DejaVu\ Sans\ Mono\ 16
colorscheme slate


" Indenting
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"Relative line numbers
set rnu

let g:newtr_liststyle=3

" Bindings
map <C-n> :NERDTreeToggle<CR>
map <C-tab> :tabn<CR>
    

" Vanilla solution for auto closing brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
