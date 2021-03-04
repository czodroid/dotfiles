"             ,,,
"            (o o)
"###=====oOO--(_)--OOO===============================================##"
"
" Filename: .vimrc
" Author: Olivier Sirol <czo@free.fr>
" License: GPL-2.0
" File Created: mai 1995
" Last Modified: jeudi 04 mars 2021, 01:02
" Edit Time: 177:48:13
" Description: 
"              my vim config file
"              self contained, no .gvimrc, nothing in .vim
"
" $Id: .vimrc,v 1.190 2021/03/04 00:03:30 czo Exp $

if version >= 580

" == Options ===========================================================

" for non working term colors
"set t_Co=8
"set t_Co=16
"set t_Co=256

" vim mode
set nocompatible

" you can do a source ~/.vimrc, whitout "gruvbox64"
let g:colors_name = "default"

if has("termguicolors")
  " work in tmux, but not in screen
  "set notermguicolors
  set termguicolors
endif

let mapleader=","

"set nonumber
set number
set cursorline
set nocursorcolumn
set showcmd
set noshowmode
set showmatch
set ruler
set shortmess=aOt
set laststatus=2
set cmdheight=1
set scrolloff=0

"set helpheight=999000

set modeline
set modelines=30

set history=2000
set viminfo='100,\"1000,ra:,rb:,rz:,%

" don't write on my embedded toy
if $PLATFORM == "Linux_bb"
 set backupdir=/tmp,.
 set directory=/tmp,.
 if !has('nvim')
    set viminfo+=n/tmp/viminfo
 endif
endif

set nobackup
set writebackup
"set autowrite

" multi buffer edit
set hidden

" inserting text
set undolevels=99000
"set insertmode
" 0 <BS> U = ☻
"set digraph
set nostartofline
set backspace=indent,eol,start
"set whichwrap=[,]
set whichwrap=<,>,[,]

set expandtab
set smarttab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround

" Indentation gérée par les plugins plutôt que par autoindent
set noautoindent
filetype plugin on
filetype indent on

"set smartindent
set cindent
"set textwidth=72
set textwidth=0
"set nowrap
"set wrapmargin=1
"set formatoptions=qr
"set equalprg=indent

" search/replace
set ignorecase
set smartcase
"set nohlsearch
set hlsearch
set incsearch

set wildmenu
set wildmode=longest,full
set wildoptions=tagfile

if !has('nvim')
    set ttymouse=xterm2
endif

if version >= 710
    set mouse=a
endif

set ttimeout
set ttimeoutlen=100
set ttyfast

if &term =~ '^xterm'
    " 0  -> blinking block.
    " 1  -> blinking block (default).
    " 2  -> steady block.
    " 3  -> blinking underline.
    " 4  -> steady underline.
    " 5  -> blinking bar (xterm).
    " 6  -> steady bar (xterm).
    " color \e]12;#fe8019\x7
    let &t_EI .= "\e[ q"
    let &t_SI .= "\e[5 q"
    if version > 704
        let &t_SR .= "\e[3 q"
    endif
endif

if has('nvim')
    set guicursor+=a:blinkon1-Cursor
endif

" tmux will send xterm-style keys when xterm-keys is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" vt100
if &term =~ '^vt100'
    execute "set <S-Up>=\e[1;2A"
    execute "set <S-Down>=\e[1;2B"
    execute "set <S-Right>=\e[1;2C"
    execute "set <S-Left>=\e[1;2D"
endif

if version >= 800
    set listchars=tab:>-,trail:~,space:.
    "set list
endif

" tags search path
set tags=./tags,tags,/users/soft5/newlabo/cvstree/alliance/sources/tags
"set errorformat=%f:%l:\ %m,In\ file\ included\ from\ %f:%l:,\^I\^Ifrom\ %f:%l%m

" dictionary completion: (Ctrl-X Ctrl-k)
set dictionary=/usr/dict/words,/users/soft5/newlabo/cvstree/alliance/sources/tags


" == Statusline ========================================================

" :h mode() to see all modes
let g:currentmode={
       \ 'n'      : 'NORMAL',
       \ 'i'      : 'INSERT',
       \ 'R'      : 'REPLAC',
       \ 'Rv'     : 'REPLAC',
       \ 'v'      : 'VISUAL',
       \ 'V'      : 'VISUAL',
       \ "\<C-v>" : 'VISUAL',
       \ 'c'      : 'COMMAN',
       \ 's'      : 'SELECT',
       \ 'S'      : 'SELECT',
       \ "\<C-s>" : 'SELECT',
       \ 't'      : 'TERMIN',
       \   }

function! LineMode() abort
  return get(g:currentmode, mode(), 'N')
endfunction

function! ChangeStatusLineMode()
  if (LineMode() =~ '^I')
    exec 'hi User1 guifg=#35302b guibg=#b8bb26 ctermfg=Black ctermbg=Green   gui=inverse cterm=inverse term=inverse'
  elseif (LineMode() =~ '^R')
    exec 'hi User1 guifg=#35302b guibg=#fb4934 ctermfg=Black ctermbg=Red     gui=inverse cterm=inverse term=inverse'
  elseif (LineMode() =~ '^V')
    exec 'hi User1 guifg=#35302b guibg=#d3869b ctermfg=Black ctermbg=Magenta gui=inverse cterm=inverse term=inverse'
  elseif (LineMode() =~ '^S')
    exec 'hi User1 guifg=#35302b guibg=#d3869b ctermfg=Black ctermbg=Magenta gui=inverse cterm=inverse term=inverse'
  elseif (LineMode() =~ '^T')
    exec 'hi User1 guifg=#35302b guibg=#fe8019 ctermfg=Black ctermbg=Yellow  gui=inverse cterm=inverse term=inverse'
  elseif (LineMode() =~ '^C')
    exec 'hi User1 guifg=#35302b guibg=#fe8019 ctermfg=Black ctermbg=Yellow  gui=inverse cterm=inverse term=inverse'
  else " NORMAL
    exec 'hi User1 guifg=#35302b guibg=#83a598 ctermfg=Black ctermbg=Blue    gui=inverse cterm=inverse term=inverse'
  endif
  return LineMode()
endfunction

augroup ChangeStatusLineMode
  autocmd!
  autocmd WinEnter,BufWinEnter,FileType,SessionLoadPost * call ChangeStatusLineMode()
  autocmd CursorMoved,BufUnload * call ChangeStatusLineMode()
augroup END

set statusline=
set statusline+=%1*\ %{ChangeStatusLineMode()}\      " current mode
set statusline+=%0*%<%f\                             " Filename
set statusline+=%6*%m                                " Modified?
set statusline+=%3*%r                                " RO?
set statusline+=%=                                   " right
set statusline+=%2*%l/%c\                            " ln col
set statusline+=%3*%b:0x%2B\                         " char hex
set statusline+=%4*%{''.(&fenc!=''?&fenc:&enc).''}   " Encoding
set statusline+=%{(&bomb?\',BOM\':\'\')}             " Encoding2
set statusline+=%4*\/%{&ff}                          " FileFormat unix/dos
set statusline+=%6*\ %y                              " FileType
"set statusline+=%7*\ %L                              " Number of line
set statusline+=%8*\ %P(%L)                           " Top/bot.% / NumOfLine
set statusline+=\                                    " Blank last char

" vielle statusline
"[1] .vimrc [vim] utf-8 unix en                  75:  79 0x4F 35/1222   1%
"let &statusline="[%n] %<%f %y %{''.(&fenc!=''?&fenc:&enc).''}%{(&bomb?\',BOM\':\'\')} %{&ff} %{&spelllang} %= %c: %3b 0x%2B    %l/%L %m%r%w %P "


" == GUI Mode ==========================================================

if has("gui_running")
"set noguipty
set winaltkeys=no
set guioptions-=T
set mousehide

"gui fonts on win, osx, linux
  if has("gui_gtk2") || has("gui_gtk3")
    " Linux GUI
    set guifont=Monospace\ 13
    "set guifont=Source\ Code\ Pro\ for\ Powerline\ 14
  elseif has("x11")
    " Linux X11
    set guifont=10x20
  elseif has("gui_win32")
    " Win32/64 GVim
    set guifont=Consolas:h13
    "set guifont=Andale_Mono:h13
  elseif has("gui_macvim")
    " MacVim
    set guifont=SourceCodeProForPowerline-Light:h18,Monaco:h18
  else
    echoe "Unknown GUI system!!!"
  endif

endif
" == Autocommands ======================================================

if has("autocmd")

" remove all autocommands
autocmd!

" on the last edit line
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" cursorline when in insert mode
"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul

" reset cursor when vim exits
autocmd VimLeave * silent !echo -n "\033]112\007"

"set verbose=9 "for testing
"pour mon laptop 1024x768
"autocmd GUIEnter * set lines=36
"autocmd GUIEnter * set columns=87
"autocmd GUIEnter * winpos 20 40

"FIXME:
function! MyHTMLAbbrevs()
 iab <buffer> ''l &lsquo;
 iab <buffer> ''r &rsquo;
 iab py_   Olivier Sirol <czo@free.fr>
 iab <a <a href=""></a><left><left><left><left><left>
 iab <i <img src="" /><left><left><left>
 iab l" &ldquo;&rdquo;<left><left><left><left><left><left>
 iab r" &rdquo;
 iab l' &lsquo;
 iab r' &rsquo;
 iab "" &quot;&quot;<left><left><left><left><left>
 iab <? <?php?><left><left>
endfunction

augroup MyAbbrevs
"autocmd!
"autocmd BufNewFile,BufRead *.htm,*.html,*.mkd call MyHTMLAbbrevs()
augroup END

autocmd FileType perl setlocal equalprg=perltidy\ -ce\ -l=0\ -st
autocmd BufNewFile,BufRead *.ino set filetype=cpp

endif


" == MAPpings ==========================================================

" COMMANDS                    MODES ~
" :map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
" :nmap  :nnoremap :nunmap    Normal
" :vmap  :vnoremap :vunmap    Visual and Select
" :smap  :snoremap :sunmap    Select
" :xmap  :xnoremap :xunmap    Visual
" :omap  :onoremap :ounmap    Operator-pending
" :map!  :noremap! :unmap!    Insert and Command-line
" :imap  :inoremap :iunmap    Insert
" :lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
" :cmap  :cnoremap :cunmap    Command-line

" mswin...
" present in vim.gtk but not in vim or vim-nox
" +clipboard +xterm_clipboard +virtualedit
" set clipboard=unnamedplus
" he paste nopaste
"
" nvim clipboard
"  - pbcopy, pbpaste (macOS)
"  - wl-copy, wl-paste (if $WAYLAND_DISPLAY is set)
"  - xclip (if $DISPLAY is set)
"  - xsel (if $DISPLAY is set)
"  - win32yank (Windows)
"  - tmux (if $TMUX is set)
"
" # Linux Wayland
" :'<,'>w !wl-copy
" # Linux Xorg
" :'<,'>w !xclip -selection clipboard
"
" https://github.com/kana/vim-fakeclip

if has('clipboard')
    if filereadable(expand("$VIMRUNTIME/mswin.vim"))
        so $VIMRUNTIME/mswin.vim
        " but dont use Ctrl-A
        noremap <C-A> <C-A>
        inoremap <C-A> <C-A>
    endif
else
    echom "Please install vim-athena/vim-gtk (debian)"
    echom "vim-X11 (and run vimx) (centos) or nvim to"
    echom "be able to access the system clipboard..."
    echoe "Vim compiled with no clipboard!!!"
    noremap <C-Q> <C-V>
endif


" search hilited text
vmap / y/<C-R>"<CR>
vmap ? y?<C-R>"<CR>

vnoremap > >gv
vnoremap < <gv

"goto tags
map  <C-PageUp> <C-]>
imap <C-PageUp> <C-O><C-]>
map  <C-PageDown> <C-T>
imap <C-PageDown> <C-O><C-T>

nmap <F1> :help <C-R>=expand('<cword>')<CR><CR>
imap <F1> <C-O>:help <C-R>=expand('<cword>')<CR><CR>

nmap <F2> ]c
imap <F2> <C-O>]c
map  <F3> [c
imap <F3> <C-O>[c

map  <F4> :N<CR>
imap <F4> <C-O>:N<CR>
map  <F5> :n<CR>
imap <F5> <C-O>:n<CR>

map  <F6> :make<CR>
imap <F6> <C-O>:make<CR>

map  <F7> :cp<CR>
imap <F7> <C-O>:cp<CR>
map  <F8> :cn<CR>
imap <F8> <C-O>:cn<CR>

"map  <F9> :!rm %<CR><CR>:q!<CR>
map  <F9> :syn include syntax/css/vim-coloresque.vim<CR>

map  <F10> :q<CR>
imap <F10> <C-O>:q<CR>

map  <leader>x :so ~/.vimrc<CR>
imap <leader>x <C-O>:so ~/.vimrc<CR>

map  <leader>w :so %<CR>
imap <leader>w <C-O>:so %<CR>

nmap <leader>hh :set hls!<CR>
imap <leader>hh <C-O>:set hls!<CR>

nmap <leader>uu :!perl -pe 's/(\w+)/\u$1/g'<CR>
imap <leader>uu <C-O>:!perl -pe 's/(\w+)/\u$1/g'<CR>

map <leader>h2 yiw:let @/="<C-R>""<CR>:set hls<cr>map ,hh yiw:let @/="<C-R>""<CR>:set hls<cr>
map <leader>h1 yiw:let @/="\\<<C-R>"\\>"<CR>:set hls<CR>

" decode/encode rot13 text
vmap <leader>13 :!tr A-Za-z N-ZA-Mn-za-m

" remove "control-m"s - for those mails sent from DOS:
cmap <leader>rcm %s/<C-M>//g

" == ABbreviations =====================================================

" all starting with "_"

" insert the current filename:
iab _n <C-R>=expand("%:t:r")<cr>
iab _fn <C-R>=expand("%:t")<cr>
iab _ffn <C-R>=expand("%:p")<cr>
iab _home <C-R>=$HOME<cr>
iab _vim  <C-R>=$VIMRUNTIME<cr>
iab _date <C-R>=strftime("%d %b %Y")<cr>
iab _mc # <C-R>=strftime("%Y/%m/%d")<cr> : Modified by Olivier Sirol <czo@free.fr>

iab _abc abcdefghijklmnopqrstuvwxyz
iab _ABC ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab _123 1234567890
iab _rul ....\|....1....\|....2....\|....3....\|....4....\|....5....\|....6....\|....7....\|....8....\|....9

iab _www   http://www-asim.lip6.fr/~czo/
iab _ftp   ftp://ftp-asim.lip6.fr/

iab _czo   Olivier Sirol <czo@free.fr>
iab _czoa  Olivier Sirol <czo@asim.lip6.fr>
iab _czoi  Olivier Sirol <czo@ipgp.fr>
iab _als   Alliance Support<CR>Université Pierre et Marie Curie<CR>Laboratoire d'Informatique de Paris 6<CR>Achitecture des Systemes Integres et Micro-Electronique<CR><CR>Coul. 55-65, 3e etg, Bur. 309<CR>4, Place Jussieu<CR>75252 Paris Cedex 05<CR>France<CR><CR>Tel: +33 1 44 27 53 24<CR>Fax: +33 1 44 27 72 80<CR><CR>http://www-asim.lip6.fr/alliance/<CR>mailto:alliance-support@asim.lip6.fr<CR>


" == Color theme =======================================================

"let mysyntaxfile="$HOME/etc/vim/syntax.vim"

if filereadable(expand("$VIMRUNTIME/syntax/synload.vim"))
        syntax on
endif

if (has("syntax"))
  set background=dark
  hi clear
  if exists("syntax_on")
    syntax reset
  endif

  let g:colors_name = "gruvbox64"

" gruvbox64.vim
" Description: Retro groove color scheme for Vim
"           czo colors, inspired by gruvbox style, without bold
"           works with xterm-256color and "set termguicolors" in vim
"           works with xterm 8c/16c but wrong colors if not using 
"           a gruvbox palette and also vt100

" NR-16   NR-8    COLOR NAME ~
" 0        0      Black
" 1        4      DarkBlue
" 2        2      DarkGreen
" 3        6      DarkCyan
" 4        1      DarkRed
" 5        5      DarkMagenta
" 6        3      DarkYellow
" 7        7      Gray
" 8        0*     DarkGray
" 9        4*     Blue
" 10       2*     Green
" 11       6*     Cyan
" 12       1*     Red
" 13       5*     Magenta
" 14       3*     Yellow
" 15       7*     White

hi  Normal        guifg=#ebdbb2  guibg=#282828  ctermfg=White     ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  CursorLine    guifg=NONE     guibg=#3c3836  ctermfg=NONE      ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  NonText       guifg=#504945  guibg=NONE     ctermfg=DarkGray  ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  SpecialKey    guifg=#504945  guibg=NONE     ctermfg=DarkGray  ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  TabLineFill   guifg=#7c6f64  guibg=#35302b  ctermfg=DarkGray  ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  TabLineSel    guifg=#ebdbb2  guibg=#35302b  ctermfg=White     ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  MatchParen    guifg=NONE     guibg=#665c54  ctermfg=NONE      ctermbg=DarkGray  gui=NONE            cterm=NONE            term=NONE
hi  ColorColumn   guifg=NONE     guibg=#3c3836  ctermfg=NONE      ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  Conceal       guifg=#83a598  guibg=NONE     ctermfg=Blue      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Visual        guifg=#665c54  guibg=#ebdbb2  ctermfg=DarkGray  ctermbg=White     gui=inverse         cterm=inverse         term=inverse
hi  Search        guifg=#fabd2f  guibg=#3c3836  ctermfg=Yellow    ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  IncSearch     guifg=#fe8019  guibg=#3c3836  ctermfg=Yellow    ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  Underlined    guifg=#83a598  guibg=NONE     ctermfg=Blue      ctermbg=NONE      gui=underline       cterm=underline       term=underline
hi  User1         guifg=#35302b  guibg=#83a598  ctermfg=Black     ctermbg=Blue      gui=inverse         cterm=inverse         term=inverse
hi  User2         guifg=#35302b  guibg=#fabd2f  ctermfg=Black     ctermbg=Yellow    gui=inverse         cterm=inverse         term=inverse
hi  User3         guifg=#35302b  guibg=#83a598  ctermfg=Black     ctermbg=Blue      gui=inverse         cterm=inverse         term=inverse
hi  User4         guifg=#35302b  guibg=#b8bb26  ctermfg=Black     ctermbg=Green     gui=inverse         cterm=inverse         term=inverse
hi  User5         guifg=#35302b  guibg=#928374  ctermfg=Black     ctermbg=Gray      gui=inverse         cterm=inverse         term=inverse
hi  User6         guifg=#35302b  guibg=#fe8019  ctermfg=Black     ctermbg=Yellow    gui=inverse         cterm=inverse         term=inverse
hi  User7         guifg=#35302b  guibg=#928374  ctermfg=Black     ctermbg=Gray      gui=inverse         cterm=inverse         term=inverse
hi  User8         guifg=#35302b  guibg=#8ec07c  ctermfg=Black     ctermbg=Cyan      gui=inverse         cterm=inverse         term=inverse
hi  User9         guifg=#35302b  guibg=#fe8019  ctermfg=Black     ctermbg=Yellow    gui=inverse         cterm=inverse         term=inverse
hi  StatusLine    guifg=#35302b  guibg=#ebdbb2  ctermfg=Black     ctermbg=White     gui=inverse         cterm=inverse         term=inverse
hi  StatusLineNC  guifg=#35302b  guibg=#ebdbb2  ctermfg=Black     ctermbg=White     gui=inverse,italic  cterm=inverse,italic  term=inverse,italic
hi  StatusLineTerm   guifg=#35302b  guibg=#ebdbb2  ctermfg=Black     ctermbg=White     gui=inverse         cterm=inverse         term=inverse
hi  StatusLineTermNC guifg=#35302b  guibg=#ebdbb2  ctermfg=Black     ctermbg=White     gui=inverse,italic  cterm=inverse,italic  term=inverse,italic
hi  VertSplit     guifg=#35302b  guibg=#35302b  ctermfg=Black     ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  WildMenu      guifg=#fabd2f  guibg=#282828  ctermfg=Yellow    ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  Directory     guifg=#b8bb26  guibg=NONE     ctermfg=Green     ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Title         guifg=#a89984  guibg=NONE     ctermfg=Gray      ctermbg=NONE      gui=italic          cterm=italic          term=italic
hi  ErrorMsg      guifg=#282828  guibg=#fb4934  ctermfg=Black     ctermbg=Red       gui=NONE            cterm=NONE            term=NONE
hi  MoreMsg       guifg=#fabd2f  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  ModeMsg       guifg=#fabd2f  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Question      guifg=#fe8019  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  WarningMsg    guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  LineNr        guifg=#504945  guibg=NONE     ctermfg=DarkGray  ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  CursorLineNr  guifg=#7c6f64  guibg=#3c3836  ctermfg=DarkGray  ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  SignColumn    guifg=NONE     guibg=#3c3836  ctermfg=NONE      ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  Folded        guifg=#928374  guibg=#3c3836  ctermfg=Gray      ctermbg=Black     gui=italic          cterm=italic          term=italic
hi  FoldColumn    guifg=#928374  guibg=#3c3836  ctermfg=Gray      ctermbg=Black     gui=NONE            cterm=NONE            term=NONE
hi  Cursor        guifg=#282828  guibg=#fe8019  ctermfg=Black     ctermbg=Yellow    gui=NONE            cterm=NONE            term=NONE
hi  Special       guifg=#fe8019  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Comment       guifg=#928374  guibg=NONE     ctermfg=Gray      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Todo          guifg=#83a598  guibg=NONE     ctermfg=Blue      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Error         guifg=#fb4934  guibg=bg       ctermfg=Red       ctermbg=bg        gui=inverse         cterm=inverse         term=inverse
hi  Statement     guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Conditional   guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Repeat        guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Label         guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Exception     guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Keyword       guifg=#fb4934  guibg=NONE     ctermfg=Red       ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Identifier    guifg=#83a598  guibg=NONE     ctermfg=Blue      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Function      guifg=#b8bb26  guibg=NONE     ctermfg=Green     ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  PreProc       guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Include       guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Define        guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Macro         guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  PreCondit     guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Constant      guifg=#d3869b  guibg=NONE     ctermfg=Magenta   ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Character     guifg=#d3869b  guibg=NONE     ctermfg=Magenta   ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  String        guifg=#b8bb26  guibg=NONE     ctermfg=Green     ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Boolean       guifg=#d3869b  guibg=NONE     ctermfg=Magenta   ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Number        guifg=#d3869b  guibg=NONE     ctermfg=Magenta   ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Float         guifg=#d3869b  guibg=NONE     ctermfg=Magenta   ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Type          guifg=#fabd2f  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  StorageClass  guifg=#fe8019  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Structure     guifg=#8ec07c  guibg=NONE     ctermfg=Cyan      ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Typedef       guifg=#fabd2f  guibg=NONE     ctermfg=Yellow    ctermbg=NONE      gui=NONE            cterm=NONE            term=NONE
hi  Pmenu         guifg=#ebdbb2  guibg=#504945  ctermfg=White     ctermbg=DarkGray  gui=NONE            cterm=NONE            term=NONE
hi  PmenuSel      guifg=#282828  guibg=#83a598  ctermfg=Black     ctermbg=Blue      gui=NONE            cterm=NONE            term=NONE
hi  PmenuSbar     guifg=NONE     guibg=#504945  ctermfg=NONE      ctermbg=DarkGray  gui=NONE            cterm=NONE            term=NONE
hi  PmenuThumb    guifg=NONE     guibg=#7c6f64  ctermfg=NONE      ctermbg=DarkGray  gui=NONE            cterm=NONE            term=NONE
hi  DiffDelete    guifg=#83a598  guibg=#282828  ctermfg=Blue      ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  DiffAdd       guifg=#b8bb26  guibg=#282828  ctermfg=Green     ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  DiffChange    guifg=#8ec07c  guibg=#282828  ctermfg=Cyan      ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  DiffText      guifg=#fabd2f  guibg=#282828  ctermfg=Yellow    ctermbg=Black     gui=inverse         cterm=inverse         term=inverse
hi  SpellCap      guifg=NONE     guibg=NONE     ctermfg=NONE      ctermbg=NONE      gui=underline       cterm=underline       term=underline
hi  SpellBad      guifg=NONE     guibg=NONE     ctermfg=NONE      ctermbg=NONE      gui=underline       cterm=underline       term=underline
hi  SpellLocal    guifg=NONE     guibg=NONE     ctermfg=NONE      ctermbg=NONE      gui=underline       cterm=underline       term=underline
hi  SpellRare     guifg=NONE     guibg=NONE     ctermfg=NONE      ctermbg=NONE      gui=underline       cterm=underline       term=underline

hi! link vimCommentTitle Title
hi! link CursorColumn CursorLine
hi! link TabLine TabLineFill
hi! link VisualNOS Visual
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
hi! link Operator Normal

endif

" ======================================================================
" == Source external files =============================================

""source all func in ~/etc/vim/run/
""source $HOME/etc/vim/func/template.vim
"execute substitute(glob("~/etc/vim/run/*.vim"), "^\\|\n", "&source ", "g")

" ======================================================================
" == template.vim ======================================================

" VIm Template
" Based on Header.vim by Johannes Zellner
" http://www.zellner.org/vim/functions/Header.vim)
"
"debug
"set verbose=9
"autocmd!

let TemplateMaxHeaderLines=30
let TemplateAuthor="Olivier Sirol <czo@free.fr>"
let TemplateLicense="GPL-2.0"

command! -nargs=? Template call Template (<q-args>)
command! TemplateMacro call TemplateMacro ()
command! TemplateTimeStamp call TemplateTimeStamp ()

autocmd BufNewFile * call Template ("")
autocmd BufReadPre,FileReadPre   * call TemplateGetTime ()
autocmd BufWritePre,FileWritePre * call TemplateTimeStamp ()

function! FindStrInHeader(pat)
    if line("$") < g:TemplateMaxHeaderLines
     let g:TemplateMaxHeaderLines = line("$")
    endif
    normal G
    let currentline = line(".")
    exec '1,'.g:TemplateMaxHeaderLines.'s/'.a:pat.'/&/ge'
    if line(".") != currentline && line(".") <= g:TemplateMaxHeaderLines
            normal ''
            exec 'ijump! /'.a:pat.'/'
            return 1
    endif
    return 0
endfunction


function! TemplateMacro ()
 if &modified == 1
    let save_report = &report
    let &report = 999000
    normal mwHmv

    " substitute expand
    let pattern = '\(.*\)VIMEX{=expand("\([^)]*\)")}\(.*\)'
    while FindStrInHeader(pattern)
        let editline = getline (".")
        let editline = substitute(editline, pattern, '\2', "")
        exec 's/'.pattern.'/\1'.escape(expand(editline), '\').'\3/e'
    endw

    " substitute strftime
    let pattern = '\(.*\)VIMEX{=strftime("\([^)]*\)")}\(.*\)'
    while FindStrInHeader(pattern)
        let editline = getline (".")
        let editline = substitute(editline, pattern, '\2', "")
        exec 's/'.pattern.'/\1'.escape(strftime(editline), '\').'\3/e'
    endw

    normal 1G'vzt`w
    let &report = save_report
 endif
endfunction


function! TemplateDate()
  " create a RFC822-conformant date
  " return strftime("%a, %d %b %Y %H:%M:%S %z")
  return strftime("%A %d %B %Y, %H:%M")
endfunction

function! TemplateGetTime ()
    let b:Template_opentime=localtime()
endfunction

function! TemplateTimeStamp ()

 if &modified == 1
    let save_report = &report
    let &report = 999999
    normal mwHmv

    " Changes in my header here:
    if 1
    " modif Started: in File Created:
    let pattern = '\(^.\=.\=.\=\s*\)Started:\(.*\)'
    if FindStrInHeader(pattern)
        exec 's/'.pattern.'/\1File Created:\2/e'
    endif
    " modif Last Change: in Last Modified:
    let pattern = '\(^.\=.\=.\=\s*Last \)Change:\(.*\)'
    if FindStrInHeader(pattern)
        exec 's/'.pattern.'/\1Modified:\2/e'
    endif
    " modif Copyright (C) in Author:
    let pattern = '\(^.\=.\=.\=\s*\)Copyright (C).*Olivier.Sirol.*'
    if FindStrInHeader(pattern)
        exec 's/'.pattern.'/\1Author:/e'
    endif
    " substitute Author
    let pattern = '\(^.\=.\=.\=\s*Author:\).*'
    if FindStrInHeader(pattern)
       exec 's/'.pattern.'/\1 '.g:TemplateAuthor.'/e'
    endif
    " substitute License
    let pattern = '\(^.\=.\=.\=\s*License:\).*'
    if FindStrInHeader(pattern)
       exec 's/'.pattern.'/\1 '.g:TemplateLicense.'/e'
    endif
    endif

    " Normal changes in my header here:
    " substitute the file name
    let pattern = '\(^.\=.\=.\=\s*Filename:\).*'
    if FindStrInHeader(pattern)
        exec 's/'.pattern.'/\1 '.escape(expand("%:t"), '\').'/e'
    endif

    " time stamp
    let pattern = '\(^.\=.\=.\=\s*Last Modified:\).*'
    if FindStrInHeader(pattern)
        exec 's/'.pattern.'/\1 '.TemplateDate().'/e'
    endif

    " edit time
    let pattern = '\(^.\=.\=.\=\s*Edit Time:\)\s*\([0-9]*:[0-9]*:[0-9]*\).*'
    if FindStrInHeader(pattern)
        let editline = getline (".")
        let editline = substitute(editline, pattern, '\2', "")
        let hour = substitute(editline, '\([0-9]*\):\([0-9]*\):\([0-9]*\).*', '\1', "")
        let min  = substitute(editline, '\([0-9]*\):\([0-9]*\):\([0-9]*\).*', '\2', "")
        let sec  = substitute(editline, '\([0-9]*\):\([0-9]*\):\([0-9]*\).*', '\3', "")

        " strip leading zero (!=octal)
        let min  = substitute(min, '^0', "", "")
        let sec  = substitute(sec, '^0', "", "")

        let totaltime = (localtime() - b:Template_opentime) + ( hour * 60 * 60) + (min * 60) + sec
        let edithour = totaltime / 60 / 60
        let editmin  = (totaltime / 60) % 60
        let editsec  = totaltime % 60

        if (strlen(editmin)<2)
            let editmin="0".editmin
        endif
        if (strlen(editsec)<2)
            let editsec="0".editsec
        endif

        exec 's/'.pattern.'/\1 '.edithour.':'.editmin.':'.editsec.'/e'
        let  b:Template_opentime=localtime()
    endif

    normal 1G'vzt`w
    let &report = save_report
 endif

endfunction

function! Template (...)

    if a:1 == ""
        let xft = &ft
    else
        let xft = a:1
    endif

if xft != ""

" /* 2011/01/27 : czo */
" I have only a .vimrc, no more multiple config/template files
"
"    let mytemplatefile = expand("$HOME/etc/vim/templates/template\." . xft)
"    if filereadable(mytemplatefile)
"        normal 1G
"        execute ":r " . mytemplatefile
"        1d
"    endif

try
  throw xft

" cat template.html | perl -pe 's/^/\\\\<nl>/; s/"/\\\\"/g; s/\\$/\\\\/g;'

" ## Template .c #####################################################
catch /^c$/
    0put =
\\"/*
\\<nl> * Filename: foo
\\<nl> * Copyright (C) VIMEX{=strftime(\\"%Y\\")} Olivier Sirol <czo@free.fr>
\\<nl> * License: GPL (http://www.gnu.org/copyleft/gpl.html)
\\<nl> * Started: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl> * Last Change: now
\\<nl> * Edit Time: 0:00:01
\\<nl> * Description:
\\<nl> *
\\<nl> */
\\<nl>
\\<nl>#ident \\"$VIMEX{=strftime(\\"Id:$\\")}\\"
\\<nl>
\\<nl>/*
\\<nl> * ####===========================================================####
\\<nl> * #### Include Files
\\<nl> */
\\<nl>
\\<nl>#include <stdio.h>
\\<nl>#include <stdlib.h>
\\<nl>#include <unistd.h>
\\<nl>
\\<nl>/* for getopt (usualy included in unistd.h)
\\<nl> * extern char *optarg;
\\<nl> * extern int optind, opterr, optopt;
\\<nl> */
\\<nl>
\\<nl>/*
\\<nl> * ####===========================================================####
\\<nl> * #### Main
\\<nl> */
\\<nl>
\\<nl>int
\\<nl>main (int argc, char *argv[], char *envp[])
\\<nl>{
\\<nl>  printf (\\"Hello World\\n\\");
\\<nl>  return (0);
\\<nl>}
\\"

" ## Template .h #####################################################
catch /^h$/
    0put =
\\"/*
\\<nl> * Filename: foo
\\<nl> * Copyright (C) VIMEX{=strftime(\\"%Y\\")} Olivier Sirol <czo@free.fr>
\\<nl> * License: GPL (http://www.gnu.org/copyleft/gpl.html)
\\<nl> * Started: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl> * Last Change: now
\\<nl> * Edit Time: 0:00:01
\\<nl> * Description:
\\<nl> *
\\<nl> */
\\<nl>
\\<nl>#ifndef MY_HEADER_H
\\<nl>#define MY_HEADER_H
\\<nl>
\\<nl>#ident \\"$VIMEX{=strftime(\\"Id:$\\")}\\"
\\<nl>
\\<nl>/*
\\<nl> * ####===========================================================####
\\<nl> * #### Prototypes
\\<nl> */
\\<nl>
\\<nl>
\\<nl>#endif
\\"

" ## Template .html ##################################################
catch /^html$/
    0put =
\\"<!DOCTYPE html>
\\<nl>
\\<nl><!--
\\<nl>Filename: pass.html
\\<nl>Author: Olivier Sirol <czo@free.fr>
\\<nl>License: GPL-2.0
\\<nl>File Created: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl>Last Modified: now
\\<nl>Edit Time: 0:00:08
\\<nl>$VIMEX{=strftime(\\"Id:$\\")}
\\<nl>-->
\\<nl>
\\<nl><html lang=\\"en\\">
\\<nl>
\\<nl><head>
\\<nl>
\\<nl>    <title>login</title>
\\<nl>
\\<nl>    <meta charset=\\"utf-8\\">
\\<nl>    <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\">
\\<nl>    <meta name=\\"theme-color\\" content=\\"#ddd\\">
\\<nl>
\\<nl>    <meta name=\\"Author\\" content=\\"Olivier Sirol <czo@free.fr>\\" />
\\<nl>    <meta name=\\"Generator\\" content=\\"Vim\\">
\\<nl>    <meta name=\\"Description\\" content=\\"__DESCRIPTION__\\">
\\<nl>    <meta name=\\"Keywords\\" content=\\"__KEYWORDS__\\">
\\<nl>
\\<nl>    <link rel=\\"shortcut icon\\" href=\\"/128.png\\">
\\<nl>    <link rel=\\"apple-touch-icon\\" href=\\"/128.png\\">
\\<nl>    <link rel=\\"icon\\" href=\\"/128.png\\">
\\<nl>
\\<nl>    <link rel=\\"stylesheet\\" href=\\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\\" integrity=\\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\\" crossorigin=\\"anonymous\\">
\\<nl>    <script src=\\"https://code.jquery.com/jquery-3.4.1.slim.min.js\\" integrity=\\"sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n\\" crossorigin=\\"anonymous\\"></script>
\\<nl>    <script src=\\"https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js\\" integrity=\\"sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo\\" crossorigin=\\"anonymous\\"></script>
\\<nl>    <script src=\\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\\" integrity=\\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\\" crossorigin=\\"anonymous\\"></script>
\\<nl>
\\<nl></head>
\\<nl>
\\<nl><body>
\\<nl>    <h1>Login: </h1>
\\<nl>    <div id=\\"maincontent\\" class=\\"container\\">
\\<nl>        <div class=\\"row\\">
\\<nl>            <div class=\\"col-lg-8 col-lg-offset-2\\">
\\<nl>                <div>
\\<nl>                    <label for=\\"username\\">Username: </label>
\\<nl>                    <input type=\\"text\\" id=\\"username\\" name=\\"username\\">
\\<nl>                </div>
\\<nl>                <div>
\\<nl>                    <label for=\\"pass\\">Password: </label>
\\<nl>                    <input autocomplete=\\"off\\" type=\\"password\\" id=\\"pass\\" name=\\"password\\" minlength=\\"8\\" required>
\\<nl>                </div>
\\<nl>                <input type=\\"submit\\" value=\\"Sign in\\">
\\<nl>            </div>
\\<nl>        </div>
\\<nl>    </div>
\\<nl></body>
\\<nl>
\\<nl></html>
\\"

" ## Template .make ##################################################
catch /^make$/
    0put =
\\"# Filename: foo
\\<nl># Author: Olivier Sirol <czo@free.fr>
\\<nl># License: GNU General Public License v2.0
\\<nl># File Created: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl># Last Modified: foo
\\<nl># Edit Time: 0:00:00
\\<nl># Description:
\\<nl>#      Makefile:
\\<nl>#      $@ Le nom de la cible
\\<nl>#      $< Le nom de la première dépendance
\\<nl>#      $^ La liste des dépendances
\\<nl>#      $? La liste des dépendances plus récentes que la cible
\\<nl>#      $* Le nom du fichier sans suffixe
\\<nl>#
\\<nl># $VIMEX{=strftime(\\"Id:$\\")}
\\<nl>#
\\<nl>
\\<nl>CC = gcc 
\\<nl>CFLAGS = -Wall -Wextra -Wpedantic
\\<nl>#CFLAGS += -I ..
\\<nl>#LIBS += -lX11 -lXext -lhistory  -lreadline
\\<nl>
\\<nl>SRC= $(wildcard *.c)
\\<nl>
\\<nl>DEPS = $(wildcard *.c) $(wildcard *.h)
\\<nl>
\\<nl>OBJ  = $(SRC:.c=.o)
\\<nl>
\\<nl>EXEC = go
\\<nl>
\\<nl>all: $(EXEC)
\\<nl>	@echo \\"<- all done!\\"
\\<nl>
\\<nl>viewdeps: $(DEPS)
\\<nl>	@echo $(DEPS)
\\<nl>
\\<nl>$(EXEC): $(OBJ)
\\<nl>	$(CC) -o $@ $^ $(LIBS)
\\<nl>
\\<nl>%.o: %.c $(DEPS)
\\<nl>	$(CC) -c -o $@ $< $(CFLAGS)
\\<nl>
\\<nl>clean:
\\<nl>	rm -f *.o
\\<nl>	@echo \\"<- clean done!\\"
\\<nl>
\\<nl>realclean: clean
\\<nl>	rm -f $(EXEC)
\\<nl>	@echo \\"<- realclean done!\\"
\\<nl>
\\<nl>fclean: realclean
\\<nl>
\\<nl>re: realclean all
\\<nl>
\\<nl>.PHONY: all clean realclean fclean re
\\<nl>
\\"

" ## Template .perl###################################################
catch /^perl$/
    0put =
\\"#! /usr/bin/perl -w
\\<nl>#
\\<nl># Filename: foo
\\<nl># Copyright (C) VIMEX{=strftime(\\"%Y\\")} Olivier Sirol <czo@free.fr>
\\<nl># License: GPL (http://www.gnu.org/copyleft/gpl.html)
\\<nl># Created: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl># Last Change: now
\\<nl># Edit Time: 0:00:01
\\<nl># Description:
\\<nl>#
\\<nl># $VIMEX{=strftime(\\"Id:$\\")}
\\<nl>#
\\<nl>
\\<nl>undef $/;           # read in whole file, not just one line or paragraph
\\<nl>while ( <> ) {
\\<nl>
\\<nl>    if (/<\s*title\s*>\s*(.*?)\s*<\s*\/\s*title\s*>/smi) {
\\<nl>        $res = $1;
\\<nl>        $res =~ s/\\n/ /smig;
\\<nl>        $res =~ s/  */ /smig;
\\<nl>        print \\"$res\\n\\";
\\<nl>    }
\\<nl>}
\\"

" ## Template .sh ####################################################
catch /^sh$/
    0put =
\\"#!/bin/sh
\\<nl>#
\\<nl># Filename: foo
\\<nl># Copyright (C) VIMEX{=strftime(\\"%Y\\")} Olivier Sirol <czo@free.fr>
\\<nl># License: GPL (http://www.gnu.org/copyleft/gpl.html)
\\<nl># Started: VIMEX{=strftime(\\"%b %Y\\")}
\\<nl># Last Change: now
\\<nl># Edit Time: 0:00:01
\\<nl># Description:
\\<nl>#
\\<nl># $VIMEX{=strftime(\\"Id:$\\")}
\\<nl>#
\\<nl>
\\<nl>echo %%%%%%% Hello
\\"


catch /.*/

endtry

endif
    call TemplateMacro ()
    call TemplateGetTime ()
    call TemplateTimeStamp ()
    set modified
endfunction

" end template.vim =====================================================

" ======================================================================
" == commentary.vim ====================================================

" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim
" autocmd FileType apache setlocal commentstring=#\ %s
" 2019/06/18: Modified by Olivier Sirol <czo@free.fr>
" https://github.com/tpope/vim-commentary/blob/master/plugin/commentary.vim

autocmd FileType xdefaults setlocal commentstring=!\ %s
autocmd FileType json setlocal commentstring=//\ %s

if version >= 700

let g:loaded_commentary = 1

function! Commentary_surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! Commentary_strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if l[-1:] ==# ' ' && stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0
    let l = l[:-2]
  endif
  if r[0] ==# ' ' && a:line[-strlen(r):] != r && a:line[1-strlen(r):] == r[1:]
    let r = r[1:]
  endif
  return [l, r]
endfunction

function! Commentary_go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l, r] = Commentary_surroundings()
  let uncomment = 2
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = Commentary_strip_white_space(l,r,line)
    if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M'.r[0:-2].'\zs\d\*\ze'.r[-1:-1].'\|'.l[0].'\zs\d\*\ze'.l[1:-1],
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),'^\s*').'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call setline(lnum,line)
  endfor
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
  return ''
endfunction

function! Commentary_textobject(inner) abort
  let [l, r] = Commentary_surroundings()
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = Commentary_strip_white_space(l,r,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

command! -range -bar Commentary call Commentary_go(<line1>,<line2>)
xnoremap <silent> <C-J>   :Commentary<CR>
nnoremap <silent> <C-J>   :Commentary<CR>

" c'est nouveau, pour l'instant, je ne comprend rien à ça....

" command! -range -bar Commentary call s:go(<line1>,<line2>)
" xnoremap <expr>   <Plug>Commentary     <SID>go()
" nnoremap <expr>   <Plug>Commentary     <SID>go()
" nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
" onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
" nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
" nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

" if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
"   xmap gc  <Plug>Commentary
"   nmap gc  <Plug>Commentary
"   omap gc  <Plug>Commentary
"   nmap gcc <Plug>CommentaryLine
"   if maparg('c','n') ==# '' && !exists('v:operator')
"     nmap cgc <Plug>ChangeCommentary
"   endif
"   nmap gcu <Plug>Commentary<Plug>Commentary
" endif


endif

" end commentary.vim ===================================================

" ======================================================================
" == Plugins ===========================================================

if (0)

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/pack/vendor/start')
Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/colorizer'
call plug#end()

endif

" end Plugins ==========================================================

endif

" The end! =============================================================

