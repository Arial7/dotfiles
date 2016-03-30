"--- Base config ---
syntax on
set relativenumber number
set wrap

set tabstop=4
set shiftwidth=4
set expandtab

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files

" Remove | from split lines
set fillchars+=vert:\ 

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'suan/vim-instant-markdown'

" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-markdown'

" Visuals
Plug 'vim-airline/vim-airline'

call plug#end()


"--- Airline config ---
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

"--- Keymaps ---
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map <C-n> :NERDTreeToggle<CR>
nnoremap Q <nop>

"--- Neomake ---
autocmd! BufWritePost * Neomake

"--- Instant Markdown Preview---
let g:instant_markdown_autostart = 0

