
" Plugins {{{

if empty(glob('~/.vim/autoload/plug.vim'))
  !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:plug_shallow = 0
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'elzr/vim-json'
Plug 'benmills/vimux'


let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
set laststatus=2

" let g:VimuxUseNearest = 0

call plug#end()

let mapleader = ","

runtime macros/matchit.vim

" }}}

" Plugin Config {{{

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
  au FileType qf nnoremap <buffer> q :q<cr>
  au FileType qf set nowinfixheight

  au FileType qf setlocal stl=%t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=\ %l\ of\ %L
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


