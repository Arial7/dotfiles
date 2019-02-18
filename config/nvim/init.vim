" {{{ --- Base config ---

syntax on
set wrap                        " Visually wrap long lines
set textwidth=100               " Wrap lines after 100 chars
set tabstop=2                   " Tabs 2 spaces wide, tabs are spaces
set shiftwidth=2
set scrolloff=4                 " Move page when cursor has 4 lines of space
set autoread
set foldmethod=marker
set wildignore+=.git/,node_modules/,.glide,vendor/
set fillchars+=vert:\           " Remove | from split lines
set nospell                     " Disable spell checking
set timeoutlen=1000 ttimeoutlen=10
set completeopt=menuone,noselect,longest
set number
set relativenumber
set mouse=a
set shortmess+=c " suppress completion messages
set updatetime=1000 " For CursorHold and CursorHoldI
set signcolumn=yes
set cmdheight=2

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright

" Use ag insead of grep
if executable('ag')
  set grepprg="ag --vimgrep"
endif

" }}}

"{{{ --- Plugins ---
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'Chiel92/vim-autoformat'
Plug 'Konfekt/vim-guesslang', { 'for': 'markdown' }
Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'                     " To rename files on the fly
Plug 'godlygeek/tabular'                    " For markdown table alignment
Plug 'janko/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-emoji'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Languages
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'herringtondarkholme/yats.vim'
Plug 'jodosha/vim-godebug', { 'for': 'go' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'mustache' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': 'vue'}
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }

" Visuals
" Plug 'vim-airline/vim-airline-themes'
" Plug 'ayu-theme/ayu-vim-airline'
" Plug 'vim-airline/vim-airline'
" Plug 'arcticicestudio/nord-vim'
" Plug 'ayu-theme/ayu-vim'
Plug 'jeffkreeftmeijer/vim-dim'
" Plug 'Yggdroot/indentLine'

if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" }}}

"{{{ --- Plugin config ---

" Ultisnips
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Go
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1

let g:guesslang_langs = [ 'en_US', 'de_DE', 'en', 'de' ]

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column --ignore vendor --ignore .git'

" FZF
let g:fzf_tags_command = 'ctags --exclude=vendor -R'

" Indent Line
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" Vim Test
let test#strategy = "dispatch"

" }}}

" {{{ --- Keymaps ---
"  Leaders
let mapleader = ","
nnoremap <leader>] :Ack!<space>
nnoremap <leader>tt :Tab/\|<cr>
nnoremap <leader>t= :Tab/=<cr>
nnoremap <leader>t: :Tab/:<cr>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>

" Plugin Keymaps
nnoremap <c-p> :FZF<cr>
nnoremap <F2> :Tags<cr>
nnoremap <F3> :BTags<cr>
nnoremap <leader>k :Ag<space><c-r><c-w><cr>
nnoremap <leader>t :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>

" Neovim keybindings
if has('nvim')

tnoremap <Esc> <C-\><C-n>
aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <esc><esc> <c-c>
aug END

endif

" Golang Keymaps
autocmd FileType go nmap <F5> <Plug>(go-build)

" COC.nvim
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Disable this
nnoremap Q <nop>
" To clear the highlighting from searches
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" }}}

" {{{ --- Misc config ---
colorscheme dim
set guicursor=n:hor100
highlight SignColumn ctermbg=8 ctermfg=0
highlight LineNr ctermbg=8 ctermfg=0
highlight CursorLineNr ctermbg=8 ctermfg=5
highlight CocErrorSign ctermbg=8 ctermfg=1
highlight CocInfoSign ctermbg=8 ctermfg=2
highlight CocWarningSign ctermbg=8 ctermfg=3

" Remove light border between splits
" hi VertSplit ctermbg=bg ctermfg=bg

" --- Custom commands ---

" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

autocmd BufEnter text,markdown,tex setlocal spell

" Hide the -- INSERT -- etc. line
set noshowmode
set noruler

" Remove trailing whitespace
function! StripTrailingWhitespaces()
    if &ft == "markdown"
        return
    endif
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Create parent dirs on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

autocmd BufWritePre * :call StripTrailingWhitespaces()


" }}}

"{{{ --- Statusline

" Colors
highlight StatusLine ctermbg=8 ctermfg=0 cterm=NONE
highlight! StatusLineNC ctermbg=7 ctermfg=0
au InsertEnter * hi User1 ctermbg=4 ctermfg=0
au InsertLeave * hi User1 ctermbg=2 ctermfg=0
highlight User1 ctermbg=2 ctermfg=0

let g:statusline_seperator='  '

let g:currentmode={
      \ 'n'  : ' NORMAL ',
      \ 'no' : ' NORMAL_',
      \ 'v'  : ' VISUAL ',
      \ 'V'  : ' V·LINE ',
      \ '' : ' V·BLOK ',
      \ 's'  : ' SELECT ',
      \ 'S'  : ' S·LINE ',
      \ '' : ' S·BLOK ',
      \ 'i'  : ' INSERT ',
      \ 'R'  : ' REPLAC ',
      \ 'Rv' : ' V·RPLC ',
      \ 'c'  : ' CMD   ',
      \ 'cv' : ' VIM EX ',
      \ 'ce' : ' EX    ',
      \ 'r'  : ' PROMPT ',
      \ 'rm' : ' MORE  ',
      \ 'r?' : ' CNFRM ',
      \ '!'  : ' SHELL ',
      \ 't'  : ' TERM '
      \}

function! GitBranch()
	let branch = ""
	if exists("*fugitive#head")
		let branch = fugitive#head()
	endif
	if branch != ''
		return '  ⎇ '.branch.' '
	endif
	return ''
endfunction


function! GetObsessionStatus()
	let status = ""
	if exists("*ObsessionStatus")
		let status = ObsessionStatus('0.0', '-.-')
	endif
	if status != ''
		return '  '.status.' '
	endif
	return '  -.- '
endfunction

set statusline=
set statusline+=%1*%8{g:currentmode[mode()]}%*
set statusline+=%{GitBranch()}
set statusline+=·
set statusline+=\ %-.55f%m
set statusline+=%=
set statusline+=%y
set statusline+=%{g:statusline_seperator}
set statusline+=%{GetObsessionStatus()}
set statusline+=%1*\ %P\ ·\ %4l:%-3c\%*

" }}}
