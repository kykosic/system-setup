" Required config
set directory=~/.vim/backup
set backupdir=~/.vim/backup
filetype off


" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
" Highlight visual yanks
Plug 'machakann/vim-highlightedyank'
" Fuzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Nert tree
Plug 'scrooloose/nerdtree'
" Line commenter tool
Plug 'scrooloose/nerdcommenter'
" Git status
Plug 'tpope/vim-fugitive'
" Open current line on github
Plug 'ruanyl/vim-gh-line'
" Color theme
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Asynchronous syntax checkking
Plug 'neomake/neomake'
" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Visual indent guide
Plug 'Yggdroot/indentLine'
" Multi-language syntax support
Plug 'sheerun/vim-polyglot'
" Rust lanaguage support
Plug 'rust-lang/rust.vim'

call plug#end()


" Misc vim settings
syntax on
set shell=/bin/zsh
set laststatus=2
set noshowmode
set backspace=indent,eol,start
" hide files when leaving them
set hidden
" show line numbers
set number
" minimum line number column width
set numberwidth=1
" number of screen lines to use for command line
set cmdheight=2
" line length limit
set textwidth=120
" default line auto cutting and formatting
set formatoptions=jtcrq
" don't cut lines in middle of word
set linebreak
" show matching parenthesis
set showmatch
" time to show matching perenthesis
set matchtime=2
" color for dark background
set background=dark
" invisible characters for :set list
set listchars=tab:▸\ ,eol:¬
" select first item of popup menu automatically without insert
set completeopt+=noinsert
" enable mouse usage and scrolling
set mouse=nicr


" Markdown settings
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1


" Tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
filetype on  " File-specific formatting
autocmd FileType py setlocal shiftwidth=4 tabstop=4  " Python uses 4 spaces instead of 2
autocmd FileType make set noexpandtab shiftwidth=4  " Makefiles require tab indents

" Search
" incremental search
set incsearch
" case insensitive search
set ignorecase
" Case insensitive if no uppercase letter in pattern, case sensitive otherwise.
set smartcase


" Ruler
set colorcolumn=80

" do not continue comments on newline in INSERT mode
set formatoptions-=r

" Rust settings
let g:rustfmt_autosave = 1
autocmd Filetype rust set colorcolumn=100


" Color scheme
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set termguicolors
let g:material_theme_style = 'darker'
colorscheme material
let g:lightline = { 'colorscheme': 'material_vim' }
let g:airline_theme = 'material'


" Airline config
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'


" Nerdtree git plugin symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "ᵐ",
    \ "Staged"    : "ˢ",
    \ "Untracked" : "ᵘ",
    \ "Renamed"   : "ʳ",
    \ "Unmerged"  : "ᶴ",
    \ "Deleted"   : "ˣ",
    \ "Dirty"     : "˜",
    \ "Clean"     : "ᵅ",
    \ "Unknown"   : "?"
    \ }


" Highlighting for jsonc filetype
autocmd FileType json syntax match Comment +\/\/.\+$+


" Nerd commenter
filetype plugin on


" Clear search highlighting
nnoremap <C-z> :nohlsearch<CR>


" Better Unix support
set viewoptions=folds,options,cursor,unix,slash
set encoding=utf-8


" Close shortcut
noremap <C-q> :confirm qall<CR>


" Trim Whitespace on save
function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
autocmd BufWritePre * :call TrimWhitespace()  " Trim whitespace on every save


" Window Switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Nerdtree settings
map <C-F> :NERDTreeToggle<CR>
map <C-S> :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1


" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>

" Disable arrow keys and page up / down
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
noremap <PageUp> <nop>
inoremap <PageUp> <nop>
vnoremap <PageUp> <nop>
noremap <PageDown> <nop>
inoremap <PageDown> <nop>
vnoremap <PageDown> <nop>


" COC config

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Show signature help
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" close preview (shown for hover / signature help)
nnoremap <leader> <Esc> :pclose<CR>

nnoremap <silent> <M-B> :call CocRequest('scalametals', 'workspace/executeCommand', { 'command': 'build-import' })<CR>

" COC Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

