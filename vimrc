
" Plugins {{{

if empty(glob('~/.vim/autoload/plug.vim'))
  !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:plug_shallow = 0
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'

" Vimproc to asynchronously run commands (NeoBundle, Unite)
Plug 'Shougo/vimproc', {
    \ 'build' : {
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

Plug 'Shougo/unite.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neopairs.vim'

" Unite plugin that provides spell suggestions
Plug 'kopischke/unite-spell-suggest'

Plug 'Shougo/neomru.vim', {'autoload':{'unite_sources':
    \['file_mru', 'directory_mru']}}

" File explorer (needed where ranger is not available)
Plug 'Shougo/vimfiler', {'autoload' : { 'commands' : ['VimFiler']}}

" Junk files
Plug 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen',
    \ 'unite_sources':['junkfile','junkfile/new']}}

" Unite plugin that provides command line completition
Plug 'joedicastro/unite-cmdmatch'


" Syntax {{{

Plug 'elzr/vim-json', {'filetypes' : 'json'}
Plug 'chase/vim-ansible-yaml', {'autoload': {'filetypes': ['ansible']}}
Plug 'lepture/vim-jinja', {'autoload': {'filetypes': ['jinja']}}
Plug 'scrooloose/syntastic'

" }}}

" GUI {{{

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Zooms a window
Plug 'vim-scripts/zoomwintab.vim', {'autoload' :
            \{'commands' : 'ZoomWinTabToggle'}}
" easily window resizing
Plug 'jimsei/winresizer'

" }}}

" Tmux {{{

" Easily interacts with Tmux from Vim
Plug 'benmills/vimux'

" Tmux config file syntax
Plug 'vimez/vim-tmux', { 'autoload' : { 'filetypes' : 'conf'}}

" }}}

call plug#end()

" }}}

" Plugin Config {{{

" Airline {{{

set noshowmode

let g:airline_theme='jellybeans'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

 let g:airline#extensions#tabline#enabled = 2
 let g:airline#extensions#tabline#fnamemod = ':t'
 let g:airline#extensions#tabline#buffer_min_count = 1

" }}}

" Deoplete {{{

let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('omni', 'functions', {
      \ 'python':  'pythoncomplete#Complete',
      \ 'javascript': ['tern#Complete', 'jspc#omni'],
      \ 'xml' : 'xmlcomplete#CompleteTags'
      \})

call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('omni_patterns', {
                \  'java': '[^. *\t]\.\w*',
                \  'html': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
                \  'xhtml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
                \  'xml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
                \})

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

" }}}

" VimFiler {{{

nnoremap <silent><Leader>X :VimFiler<CR>

let g:vimfiler_as_default_explorer = 1

let g:vimfiler_tree_leaf_icon = '├'
let g:vimfiler_tree_opened_icon = '┐'
let g:vimfiler_tree_closed_icon = '─'
let g:vimfiler_file_icon = '┄'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_readonly_file_icon = '✗'

let g:vimfiler_force_overwrite_statusline = 0

let g:vimfiler_time_format = '%d-%m-%Y %H:%M:%S'
let g:vimfiler_data_directory = $HOME.'/.vim/tmp/vimfiler'

" }}}

" vimux {{{

let g:VimuxUseNearestPane = 1

map <Leader>rr :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;python '.bufname("%"))<CR>
map <Leader>rt :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;time " python '.bufname("%"))<CR>

map <Leader>rc :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>
map <Leader>rs :VimuxInterruptRunner<CR>
map <Leader>ri :VimuxInspectRunner<CR>
map <Leader>rq :VimuxCloseRunner<CR>

" }}}
" neomru {{{

let g:neomru#file_mru_path = $HOME.'/.vim/tmp/neomru/file'
let g:neomru#directory_mru_path = $HOME.'/.vim/tmp/neomru/directory'

" }}}

" }}}

" <Leader> & <LocalLeader> mapping {{{

let mapleader=','
let maplocalleader= ' '

" }}}

" Set's {{{
set report=0
set nojoinspaces

set formatoptions=
set showcmd
set noshowmode
set nocursorline
set encoding=utf-8

set smartindent
set noswapfile

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set scrolloff=0
set sidescroll=1
set scrolljump=1
set sidescrolloff=1
set history=2000

set nowrap
set linebreak

set ignorecase
set smartcase
set diffopt+=vertical
set diffopt+=iwhite
set hidden
set numberwidth=1
set splitbelow splitright
set showmatch
set autowrite
set synmaxcol=500
set completeopt=menu,preview
set complete=.,b
set wildmode=list:full,full
set shortmess=ao

if !isdirectory($HOME . '/.vim/undo')
  call mkdir($HOME . '/.vim/undo')
endif
if isdirectory($HOME . '/.vim/undo')
  set undodir=~/.vim/undo
  set undofile
endif

set wildignore+=.hg,.git,.svn
set wildignore+=*.beam
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
let &showbreak='⤷ '
set fillchars=""
if has('linebreak')
   set breakindent
   set breakindentopt=shift:2
endif

set exrc
set secure
set wrapscan
set lazyredraw

set foldopen-=block
set foldlevelstart=99
set foldminlines=0


" change cursor in INSERT
"let &t_SI = exists('$TMUX') ? "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\" : "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = exists('$TMUX') ? "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" : "\<Esc>]50;CursorShape=0\x7"
"let &t_SR = exists('$TMUX') ? "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\" : "\<Esc>]50;CursorShape=2\x7"

let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise
" }}}

" Mappings & Commands {{{

" New windows {{{

nnoremap <Leader>v <C-w>v
nnoremap <Leader>h <C-w>s

" }}}

" Fast window moves {{{

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}

" Fast window & buffer close and kill {{{

nnoremap <Leader>k <C-w>c
nnoremap <silent><Leader>K :bd<CR>

" }}}

" Show hidden chars {{{

nmap <Leader>eh :set list!<CR>
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" }}}

" Folding {{{

set foldmethod=marker

" Toggle folding

nnoremap \ za
vnoremap \ za

" }}}

" Cut/Paste {{{

" to/from the clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p

" }}}

" Spelling {{{

" turn on the spell checking and set the Germany language
nmap <Leader>sd :setlocal spell spelllang=de<CR>
" turn on the spell checking and set the English language
nmap <Leader>se :setlocal spell spelllang=en<CR>
" turn off the spell checking
nmap <Leader>so :setlocal nospell <CR>
" jump to the next bad spell word
nmap <Leader>sn ]s
" suggest words
"nmap <Leader>sp z=
nmap <Leader>sp :Unite spell_suggest<CR>
" jump to the next bad spell word and suggests a correct one
" nmap <Leader>sc ]sz=
nmap <Leader>sc ]s :Unite spell_suggest<CR>
" add word to the dictionary
nmap <Leader>sa zg
" }}}

" Save as root {{{
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
" }}}

" Quick saving {{{
nmap <silent> <Leader>w :update<CR>
" }}}

" Delete trailing whitespaces {{{
nmap <silent><Leader>et :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" }}}

" Use Ranger as a file explorer {{{

fun! RangerChooser()
  exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
  if filereadable('/tmp/chosenfile')
    exec 'edit ' . system('cat /tmp/chosenfile')
    call system('rm /tmp/chosenfile')
  endif
  redraw!
endfun
map <Leader>x :call RangerChooser()<CR>
" }}}

" Toggle the search results highlighting {{{

map <silent><Leader>eq :set invhlsearch<CR>

" }}}

" Move between Vim and Tmux windows {{{

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      " The sleep and & gives time to get back to vim so tmux's focus tracking
      " can kick in and send us our ^[[O
      execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
      redraw!
    endif
  endfunction
  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" }}}

" Quick exiting without save {{{

nnoremap <Leader>qq :qa!<CR>

" }}}

" indentLine {{{

map <silent> <Leader>L :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239

" }}}

" Deoplete {{{

nnoremap <silent><Leader>ea :call deoplete#toggle()<CR>

" }}}

" Unite {{{

" files
nnoremap <silent><Leader>o :Unite -silent -start-insert file<CR>
nnoremap <silent><Leader>O :Unite -silent -start-insert file_rec/async<CR>
nnoremap <silent><Leader>m :Unite -silent file_mru<CR>
" buffers
nnoremap <silent><Leader>b :Unite -silent buffer<CR>
" tabs
nnoremap <silent><Leader>B :Unite -silent tab<CR>
" buffer search
nnoremap <silent><Leader>f :Unite -silent -no-split -start-insert -auto-preview
      \ line<CR>
nnoremap <silent><Leader>i :Unite -silent history/yank<CR>
" grep
nnoremap <silent><Leader>a :Unite -silent -no-quit grep<CR>
" junk files
nnoremap <silent><Leader>d :Unite -silent junkfile/new junkfile<CR>

" }}}

" zoomwintab {{{

map <Leader>z :ZoomWinTabToggle<CR>

" }}}

" }}}

" Auto Commands {{{
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * if !&diff | setlocal cursorline | endif
  au WinLeave * setlocal nocursorline
augroup END


" return to same line on reopen, unless diff-ing
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && !&diff |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

augroup q_to_quit
   au!
   au BufReadPost,BufNewFile *
            \ if !&modifiable |
            \   nnoremap <buffer> q :q<cr>|
            \ endif
  au BufReadPost fugitive://* nnoremap <buffer> q :q<cr>
  au FileType ref-* nnoremap <buffer> q :q<cr>
augroup END

augroup vim_tweaks
  au!
  au VimResized * :wincmd =
  au CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" source vimrc on save
augroup vimrc
  au!
  au BufWritePost *vimrc{,.local} if filereadable(expand('%'))|execute 'source ' . expand('%')|endif
augroup END

augroup diff_update
  au!
  au BufWritePost * if &diff == 1 | diffupdate | endif
augroup END

" highlight ExtraWhitespace only after entering insert mode
if hlID('ExtraWhitespace') == 0
  hi link ExtraWhitespace StatusLineNC
endif

augroup extra_whitespace
   au!
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

augroup auto_open_quickfix
    autocmd!
    autocmd QuickFixCmdPost grep,make,cgetfile nested below cwindow
    autocmd QuickFixCmdPost lgrep,lmake nested below lwindow
augroup END

" }}}

" Per-language config {{{
augroup filetype_options
  au!

  " shell-style comments in json
  au FileType json set commentstring=#%s
  au FileType json syn match jsonComment /#.*/
  au FileType json hi link jsonComment Comment

  au FileType mail set noexpandtab
  au BufReadPost *vimrc* setlocal foldmethod=marker
  au BufWinEnter *.md set ft=markdown
  au FileType markdown syn clear markdownItalic | syn clear markdownError
  au BufWinEnter *.conf set ft=conf
augroup END
" }}}

" vim:foldmethod=marker
