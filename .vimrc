" Sickill's VIM configuration

""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""

" Turn off compatibility with Vi
set nocompatible

" load all the bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable plugins
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
" Files & backups
""""""""""""""""""""""""""""""""""""""""

" Backup and history
set nobackup
set nowritebackup
set noswapfile
set history=1000

" Saving and reloading
set confirm
set autoread

""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""

" Indentation/tab settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap
" set autoindent

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set tabstop=4 textwidth=79

" Sane backspace behaviour
set backspace=indent,eol,start

" Folding settings
set foldmethod=indent   "indent based on syntax
set foldnestmax=3       "deepest fold is 3 levels
set foldlevel=3
set nofoldenable        "dont fold by default

set matchpairs+=<:>
set iskeyword+=?

set pastetoggle=<F11>

""""""""""""""""""""""""""""""""""""""""
" Completion
""""""""""""""""""""""""""""""""""""""""

" Word completion
set completeopt=
set complete=.,w,b,u,t

" Wildcard completion
set wildmode=list:longest,list:full   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore+=*.o,*.obj,*~,*.png,*.gif,*.jpg,*.jpeg,*.zip,*.jar,*.gem,coverage/**,log/**,.git "stuff to ignore when tab completing"

""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""

set incsearch
set hlsearch
set gdefault

""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""

" Show line numbering and current line
set number
set cursorline

" Display tabs and trailing spaces
set list
set listchars=tab:»\ ,trail:·,nbsp:·

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Hide buffers when not displayed
set hidden

" Show nice title in xterm
set title

" Some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" Tab label format
set gtl=%t

" Splitting behavior
set splitbelow splitright

" Status line
set laststatus=2
set statusline=%t%(\ [%M%R%H]%)%(\ [%Y]%)\ %{HasPaste()}%=%-14.(%l,%c%V%)\ %p%%

function! HasPaste()
  if &paste
    return '[PASTE ON]'
  else
    return ''
  endif
endfunction

set showcmd
set shortmess+=I        " disable the welcome screen

""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and colors schemes
""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting
syntax on

if (&term == "linux")
  let g:CSApprox_loaded = 1
else
  " Colors for console
  if !has("gui_running")
    set t_Co=256
  endif

  " Scheme
  colors Sunburst
endif

" for modified flag
" hi User1 gui=reverse

" highlight characters in column >120
highlight rightMargin guibg=#440000
match rightMargin /.\%>120v/

""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""

" NERDTree
let g:NERDTreeMapOpenSplit = "s"
let g:NERDTreeMapOpenVSplit = "v"
let g:NERDTreeQuitOnOpen=1

" snipMate
let g:snippets_dir = "~/.vim/snippets"
source ~/.vim/snippets/support_functions.vim

" Gist
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" substitute
let g:substitute_PromptMap = "<Leader>;'"
let g:substitute_NoPromptMap = '<Leader>;;'
let g:substitute_GlobalMap = "<Leader>';"

" turn off AlignMaps
let g:loaded_AlignMapsPlugin = "v41"

" NERDCommenter
let NERDCreateDefaultMappings = 0

""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""

" Additional filetype detection
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru,Rules} set ft=ruby
au BufRead,BufNewFile {*.json} set ft=json

" Additional commands ala rails.vim
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb
command! Rgemfile :e Gemfile

""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""

" jump to last cursor position when opening a file
" dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" function! SuperCleverTab()
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] =~ '^\\s$'
"     return "\\<Tab>"
"   else
"     return "\\<C-P>"
"   endif
" endfunction

" function! CompleteTagOrInsertSlash()
"   if &syntax != "eruby"
"     return "\\/"
"   endif
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '^<$'
"     return "\\/"
"   else
"     return "\\/\\<C-P>" " need sth better than keyword compl here
"   endif
" endfunction

" autoclose tags
" imap <silent> / <C-R>=CompleteTagOrInsertSlash()<CR>

""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

" Leader key
let mapleader=","

" make Y behave like C,D
noremap Y y$

" Preserve selection when indenting
vmap > >gv
vmap < <gv

" move up/down by screen lines, not file lines
nnoremap j gj
nnoremap k gk

" allow moving with h/j/k/l in insert mode
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>

" Move line(s) of text down/up using Alt+j/k
nnoremap <silent> <A-j> :m+<CR>==
nnoremap <silent> <A-k> :m-2<CR>==
inoremap <silent> <A-j> <Esc>:m+<CR>==gi
inoremap <silent> <A-k> <Esc>:m-2<CR>==gi
vnoremap <silent> <A-j> :m'>+<CR>gv=gv
vnoremap <silent> <A-k> :m-2<CR>gv=gv

" Indenting with Alt + [,],h,l
nmap <A-[> <<
nmap <A-]> >>
vmap <A-[> <gv
vmap <A-]> >gv
nmap <A-h> <<
nmap <A-l> >>

" Switching split windows
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Resizing split windows
nmap <silent> <C-Up> <C-w>-
nmap <silent> <C-Down> <C-w>+
nmap <silent> <C-Left> 2<C-w><
nmap <silent> <C-Right> 2<C-w>>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap <silent> P p :call setreg('"', getreg('0')) <CR>

" Sudo write
cmap w!! w !sudo tee % >/dev/null

" commenting
nmap <Leader>c <plug>NERDCommenterToggle
vmap <Leader>c <plug>NERDCommenterToggle

" ,, to zoomwin
map <Leader><Leader> :ZoomWin<CR>

" ,a for Ack
map <Leader>a :Ack<Space>

" NERD tree
nmap <silent> <Leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>fn :NERDTreeFind<CR>

" Command-T
" map <silent> <C-t> <ESC>:CommandT<CR>

" ,bo for BufOnly
nmap <Leader>bo :BufOnly<CR>

" Fast editing of the .vimrc
nmap <silent> <leader>ve :tabedit $MYVIMRC<CR>

" strip trailing whitespace
nnoremap <silent> <leader>sw :call Preserve("%s/\\s\\+$//e")<CR>

" auto indent whole file
nnoremap <silent> <leader>= :call Preserve("normal gg=G")<CR>

" preview markdown
nmap <leader>pm :!rdiscount % \|browser<CR>

" run ruby script
nmap <leader>rr :!ruby %<CR>

" Opens an (tab)edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Hide search highlighting
nnoremap <silent> <CR> :noh<CR><CR>

" shortcuts for rails.vim commands
map <Leader>rm :Rmodel<Space>
map <Leader>rc :Rcontroller<Space>
map <Leader>rv :Rview<Space>
map <Leader>rh :Rhelper<Space>
map <Leader>ro :Robserver observers/
map <Leader>rj :Rjavascript<Space>
map <Leader>rs :Rstylesheet<Space>
map <Leader>rr :Rroutes<CR>
map <Leader>rg :Rgemfile<CR>

" Load local config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
