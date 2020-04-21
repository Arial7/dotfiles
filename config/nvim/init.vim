" {{{ --- Base config ---

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
set cmdheight=1
set ignorecase
set smartcase
set incsearch
" Hide the -- INSERT -- etc. line
set noshowmode
set noruler
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set list

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright

" }}}

"{{{ --- Plugins ---

" Since vimtex is incompatible with LaTeX-Box, disable latex from polyglot
let g:polyglot_disabled = ['latex']

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'Konfekt/vim-guesslang', { 'for': 'markdown' }
Plug 'Shougo/neomru.vim' " For FZFPreview plugin
Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'danro/rename.vim'                     " To rename files on the fly
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'                    " For markdown table alignment
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'janko/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-emoji'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'yuki-ycino/fzf-preview.vim'

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'jodosha/vim-godebug', { 'for': 'go' }
Plug 'lervag/vimtex'

" Visuals
Plug 'morhetz/gruvbox'
" Plug 'Yggdroot/indentLine'

if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" }}}

syntax on

"{{{ --- Plugin config ---

" Ultisnips
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<c-e>"

" Go
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1

let g:guesslang_langs = [ 'en_US', 'de_DE', 'en', 'de' ]

" Ack
let g:ackprg = 'rg --vimgrep'

" FZF
let $FZF_DEFAULT_OPTS="--reverse"
let g:fzf_tags_command = 'ctags --exclude=vendor -R'
let g:fzf_preview_floating_window_winblend = 0
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'Todo', 'border': 'rounded' } }

" Indent Line
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" Vim Test
let test#strategy = "dispatch"

" Vimtex

" Don't open the quickfix window automatically
let g:vimtex_quickfix_mode = 0
" let g:vimtex_compiler_latexmk = {
"         \ 'backend' : 'nvim',
"         \ 'background' : 1,
"         \ 'build_dir' : '',
"         \ 'callback' : 1,
"         \ 'continuous' : 1,
"         \ 'executable' : 'latexmk',
"         \ 'hooks' : [],
"         \ 'options' : [
"         \   '-verbose',
" 				\   '-pdflatex=lualatex',
" 				\   '-lualatex',
"         \   '-file-line-error',
"         \   '-synctex=1',
"         \   '-interaction=nonstopmode',
"         \ ],
" 				\ }
"
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
				\ }

" Coc.nvim
let g:coc_global_extensions = [
	\ 'coc-angular',
	\ 'coc-css',
	\ 'coc-emmet',
	\ 'coc-emoji',
	\ 'coc-eslint',
	\ 'coc-git',
	\ 'coc-github',
	\ 'coc-go',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-python',
	\ 'coc-snippets',
	\ 'coc-tsserver',
	\ 'coc-vimtex',
	\ 'coc-yaml',
	\]

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Goyo
let g:goyo_width = 120
let g:goyo_height = 90

" Better Ripgrep (RG) implementation, which updates rg instead of filtering lines with FZF
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"}}}

" {{{ --- Keymaps ---

nnoremap <F5> :VtrSendCommandToRunner! make<cr>
nnoremap <F6> :VtrSendCommandToRunner! make run<cr>

"  Leaders
let mapleader = ","
nnoremap <leader>] :Ack!<space>
nnoremap <leader>tt :Tab/\|<cr>
nnoremap <leader>t= :Tab/=<cr>
nnoremap <leader>t: :Tab/:<cr>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>
nnoremap <leader>r <Plug>(coc-rename)
" Code action for current line
nnoremap <leader>ac <Plug>(coc-codeaction)
" Autofix for current line
nnoremap <leader>aq <Plug>(coc-fix-current)
nnoremap <leader>rg :Rg<cr>
nnoremap <leader>p :RG<cr>
" Plugin Keymaps
nnoremap <silent> <C-p> :Files<cr>
nnoremap <F2> :Tags<cr>
nnoremap <F3> :BTags<cr>
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

" Compiling things
autocmd FileType go nmap <leader>c <Plug>(go-build)
autocmd FileType tex nmap <leader>c <Plug>(vimtex-compile)

" COC.nvim
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

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
set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox
set guicursor=n:hor100
highlight SignColumn ctermbg=0 ctermfg=8
highlight CursorLineNr ctermbg=0 ctermfg=5
highlight CocUnderline cterm=undercurl term=undercurl gui=undercurl

" Remove light border between splits
" hi VertSplit ctermbg=bg ctermfg=bg

" --- Custom commands ---

" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

autocmd BufEnter text,markdown,tex setlocal spell

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
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Format the current buffer with coc.nvim
command! -nargs=0 Format :call CocAction('format')

" }}}

"{{{ --- Statusline

" Colors
highlight StatusLineNC ctermbg=8 ctermfg=15 cterm=NONE
highlight StatusLine ctermbg=7 ctermfg=0 cterm=NONE
highlight User1 ctermbg=2 ctermfg=0

" Make the left and right block blue in insert mode
au InsertEnter * hi User1 ctermbg=4 ctermfg=0
au InsertLeave * hi User1 ctermbg=2 ctermfg=0

let g:statusline_seperator='  '

let g:currentmode={
      \ 'n'  : ' NORMAL ',
      \ 'no' : ' NORMAL_',
      \ 'v'  : ' VISUAL ',
      \ 'V'  : ' VLINE ',
      \ '' : ' VBLOCK ',
      \ 's'  : ' SELECT ',
      \ 'S'  : ' S·LINE ',
      \ '' : ' S·BLOK ',
      \ 'i'  : ' INSERT ',
      \ 'R'  : ' REPLAC ',
      \ 'Rv' : ' VRPLC ',
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
		return '  ⎇  '.branch.' '
	endif
	return ''
endfunction


function! GetObsessionStatus()
	let status = ""
	if exists("*ObsessionStatus")
		let status = ObsessionStatus('O.O', '-.-')
	endif
	if status != ''
		return '  '.status.'  '
	endif
	return '  -.- '
endfunction

set statusline=
set statusline+=%1*%8{g:currentmode[mode()]}%*
set statusline+=%{GitBranch()}
set statusline+=\ %-.55f%m
set statusline+=%=
set statusline+=%y
set statusline+=%{g:statusline_seperator}
set statusline+=%{GetObsessionStatus()}
set statusline+=%1*\ %P\ ·\ %4l:%-3c\%*

" }}}
