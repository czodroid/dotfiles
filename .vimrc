"             ,,,
"            (o o)
" =======oOO==(_)==OOo==================================================
"
" Filename: .vimrc
" Author: Olivier Sirol <czo@free.fr>
" License: GPL-2.0 (http://www.gnu.org/copyleft)
" File Created: 11 mai 1995
" Last Modified: Tuesday 17 September 2024, 21:17
" $Id: .vimrc,v 1.495 2024/09/17 19:19:42 czo Exp $
" Edit Time: 253:04:09
" Description:
"
"       vim config file
"       self contained, no .gvimrc, nothing in .vim/
"
" Copyright: (C) 1995-2024 Olivier Sirol <czo@free.fr>

if version >= 505

" == Options ===========================================================

" works in gnome-shell, kde, xfce, xterm, iTerm, mintty
" but not on apple terminal which has no 24-bit colors
if version >= 801 && has("termguicolors")
    set termguicolors
else
    if has('nvim') && has("termguicolors")
        set termguicolors
    endif
    set t_Co=16
endif

" for non working terminal colors, just set this:
"set notermguicolors | set t_Co=16

" vim mode
set nocompatible

let mapleader=","

if version >= 600
    set encoding=utf-8
endif

"set nonumber
set number
"set cursorline
if version > 604
    set nocursorcolumn
endif
set showcmd
set showmode
set showmatch
set ruler
set shortmess=aOt
set laststatus=2
set cmdheight=1
set scrolloff=0

"set helpheight=999000

set modeline
set modelines=30

set history=5000
set viminfo='100,\"1000,ra:,rb:,rz:,%

" don't write on my embedded toy, perfect for owrt
if $PLATFORM == "Linux_mips"
    if isdirectory("/tmp")
        set backupdir=/tmp,.
        set directory=/tmp,.
        set viminfo+=n/tmp/.viminfo
    endif
endif

set nobackup
set writebackup
"set autowrite

" multi buffer edit
set hidden

" inserting text
"set insertmode

" insert mode : Ctrl-K + Ctrl D (Ctrl-K + Ctrl-K for quit)
" 0 <BS> U = ☻
"set digraph

set undolevels=99000
set nostartofline
set backspace=indent,eol,start
set whichwrap=<,>,[,]
" :retab
set tabstop=4
" set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
"set shiftround

set guioptions=egmrL

if version >= 600
    set display=lastline,uhex
    set noautoindent
    filetype plugin on
    filetype indent on
endif

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
if version > 604
    set wildoptions=tagfile
    set tabpagemax=200
endif

if !has('nvim')
    if version >= 704
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

if version >= 701
    set mouse=a
endif

set ttimeout
set ttimeoutlen=100
set ttyfast

" cursor block/underline/bar
if has('nvim')
    set guicursor+=a:blinkon1
else
    if &term =~ '^xterm' && version > 704
        " color: \e]12;#b8bb26\x7
        " NORMAL mode
        let &t_EI .= "\e[ q"
        " INSERT mode
        let &t_SI .= "\e[5 q"
        " INSERT mode
        let &t_SR .= "\e[3 q"
    endif
endif

" vt100
if &term =~ '^vt100' || version < 700
    exec "set <S-Up>=\e[1;2A"
    exec "set <S-Down>=\e[1;2B"
    exec "set <S-Right>=\e[1;2C"
    exec "set <S-Left>=\e[1;2D"
endif

if exists('+listchars')
    if version >= 802
        set listchars=tab:-->,trail:¶,space:·
    elseif version >= 800
        set listchars=tab:>-,trail:¶,space:·
    else
        set listchars=tab:>-,trail:%
    endif
endif

if exists('+list')
    "set list
endif

if exists('+commentstring')
    setlocal commentstring=#\ %s
endif

" set errorformat=%f:%l:\ %m,In\ file\ included\ from\ %f:%l:,\^I\^Ifrom\ %f:%l%m

" tags search path
set tags=./tags,tags

" dictionary completion: (Ctrl-X Ctrl-k)
" debian12: aptitude install hunspell-en-us hunspell-fr-revised
set dictionary=/usr/share/hunspell/en_US.dic,/usr/share/hunspell/fr.dic

" completion: (Ctrl-P / Ctrl-N)
if exists('+complete')
    set complete=.,w,b,t
    " set complete=.,w,b,u,t,i
endif

" == Statusline ========================================================

if version >= 600
    " .vimrc                   220/9 117:0x75 utf-8/unix [vim]  9%(2003)
    set statusline=
    "set statusline+=%1*\ [%n]\                           " buffer number
    set statusline+=%1*\                                 " NO buffer number
    set statusline+=%5*%<%f\                             " Filename
    set statusline+=%6*%m                                " Modified?
    set statusline+=%3*%r                                " RO?
    set statusline+=%=                                   " right
    set statusline+=%2*%l/%c\                            " ln col
    set statusline+=%3*%b:0x%2B\                         " char hex
    set statusline+=%4*%{''.(&fenc!=''?&fenc:&enc).''}   " Encoding
    set statusline+=%{(&bomb?\',BOM\':\'\')}             " Encoding2
    set statusline+=%4*\/%{&ff}                          " FileFormat unix/dos
    set statusline+=%6*\ %y                              " FileType
    set statusline+=%8*\ %P(%L)                          " Top/bot.% / NumOfLine
    set statusline+=\                                    " Blank last char
else
    " .vimrc                                    218/50 66:0x42 11%(1888)
    let &statusline=" %<%f %m %r %= %l/%c %b:0x%2B %P(%L) "
endif



" == GUI Mode ==========================================================

if has("gui_running")
    "set noguipty
    set winaltkeys=no
    set guioptions-=T
    set mousehide

    " gui fonts on linux, win, osx (set guifont=<TAB>)
    if has("gui_gtk")
        " Linux GUI
        set guifont=Monospace\ 13
        "set guifont=Source\ Code\ Pro\ for\ Powerline\ 13
    elseif has("gui_win32")
        " Win32/64 GVim
        set guifont=Source_Code_Pro_for_Powerline:h13,Consolas:h13,Andale_Mono:h13
    elseif has("gui_macvim")
        " MacVim
        set guifont=SourceCodeProForPowerline-Regular:h17,Monaco:h17
    endif

endif

" == Autocommands ======================================================

if has("autocmd")

" remove all autocommands
autocmd!

" pos on the last edit line
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal g'\"" | endif

if version > 601
    " vim diff with wrap
    autocmd VimEnter * if &diff | exec 'windo set wrap' | endif
endif

if version > 604
    " cursorline when in insert mode
    autocmd InsertEnter * set cul
    autocmd InsertLeave * set nocul
endif

" reset cursor when vim exits
"autocmd VimLeave * silent !echo -n "\033]112\007"

" .cpp/.c++/.cxx/.cc are defined as cpp in vim9
autocmd BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufNewFile,BufRead *.h++ set filetype=cpp
autocmd BufNewFile,BufRead *.h   set filetype=c
autocmd Filetype json      let g:indentLine_setConceal = 0 | let g:vim_json_syntax_conceal = 0

autocmd FileType cpp       setlocal commentstring=//\ %s
autocmd FileType crontab   setlocal commentstring=#\ %s
autocmd FileType json      setlocal commentstring=//\ %s
autocmd FileType php       setlocal commentstring=//\ %s
autocmd FileType xdefaults setlocal commentstring=!\ %s

autocmd BufWritePre,FileWritePre * if &ft =~ 'c\|cpp\|crontab\|css\|h\|hpp\|html\|java\|javascript\|lua\|make\|markdown\|perl\|php\|python\|sh\|zsh\|tmux\|xdefaults\|vim\|readline' | :call CzoTTW () | endif


endif


" == ABbreviations =====================================================

" insert the current filename:
iab _n    <C-R>=expand("%:t:r")<cr>
iab _e    <C-R>=expand("%:e")<cr>
iab _fn   <C-R>=expand("%:t")<cr>
iab _ffn  <C-R>=expand("%:p")<cr>

iab _uh   <C-R>=$USER<cr>@<C-R>=$HOSTNAME<cr>
iab _uu   <C-R>=$USER<cr>
iab _hh   <C-R>=hostname()<cr>
iab _home <C-R>=$HOME<cr>
iab _vim  <C-R>=$VIMRUNTIME<cr>
iab _date <C-R>=strftime("%Y-%m-%d")<cr>
iab _ma   # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@asim.lip6.fr>
iab _mc   # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@free.fr>
iab _mi   # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@ipgp.fr>
iab _git  "<C-R>=expand("$")<cr>Id: <C-R>=expand("%:t")<cr> 1.42 <C-R>=strftime("%Y/%m/%d %T")<cr> czo Git $"

iab _abc   abcdefghijklmnopqrstuvwxyz
iab _ABC   ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab _123   12345678911234567892123456789
iab _rul   ....\|....1....\|....2....\|....3....\|....4....\|....5....\|....6....\|....7....\|....8....\|....9

iab _www   http://www-asim.lip6.fr/~czo/
iab _ftp   ftp://ftp-asim.lip6.fr/

iab _czo   Olivier Sirol <czo@free.fr>
iab _czoa  Olivier Sirol <czo@asim.lip6.fr>
iab _czoi  Olivier Sirol <czo@ipgp.fr>
iab _als   Alliance Support<CR>Université Pierre et Marie Curie<CR>Laboratoire d'Informatique de Paris 6<CR>Achitecture des Systemes Integres et Micro-Electronique<CR><CR>Coul. 55-65, 3e etg, Bur. 309<CR>4, Place Jussieu<CR>75252 Paris Cedex 05<CR>France<CR><CR>Tel: +33 1 44 27 53 24<CR>Fax: +33 1 44 27 72 80<CR><CR>http://www-asim.lip6.fr/alliance/<CR>mailto:alliance-support@asim.lip6.fr<CR>


" == Command ===========================================================

command!  CzoATabToSpaceAndTrailWhite call CzoATabToSpaceAndTrailWhite ()
function! CzoATabToSpaceAndTrailWhite ()
    let l = line(".")
    let c = col(".")
    echo "Convert Tab to Space"
    exec '%s/\t/    /gce'
    echo "Trim Trailing Whitespace"
    exec '%s/\s\+$//ce'
    call cursor(l, c)
endfunction

command!  CzoInvTemplate call CzoInvTemplate ()
function! CzoInvTemplate ()
    if g:DoCzoTemplate
        let g:DoCzoTemplate=0
    else
        let g:DoCzoTemplate=1
    endif
endfunction

command!  CzoDiffWithSaved call CzoDiffWithSaved ()
function! CzoDiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exec "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  exec "windo set wrap"
endfunction

command!  CzoDiffWithCvs call CzoDiffWithCvs ()
function! CzoDiffWithCvs()
  let filetype=&ft
  diffthis
  vnew | r !cvs up -pr BASE #
  1,6d
  diffthis
  exec "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  exec "windo set wrap"
endfunction

command!  CzoTabToSpaces call CzoTabToSpaces ()
function! CzoTabToSpaces ()
    let l = line(".")
    let c = col(".")
    exec '%s/\t/    /gce'
    call cursor(l, c)
endfunction

command!  CzoTrimTrailingWhitespace call CzoTrimTrailingWhitespace ()
function! CzoTrimTrailingWhitespace ()
    let l = line(".")
    let c = col(".")
    exec '%s/\s\+$//ce'
    call cursor(l, c)
endfunction

" for autocmd
function! CzoTTW ()
    let l = line(".")
    let c = col(".")
    exec '%s/\s\+$//e'
    call cursor(l, c)
endfunction

command!  CzoRemoveEmptyLinesAndComment call CzoRemoveEmptyLinesAndComment ()
function! CzoRemoveEmptyLinesAndComment ()
    let l = line(".")
    let c = col(".")
    exec 'g/\(^\s*#\)\|\(^\s*$\)/d'
    call cursor(l, c)
endfunction

command!  CzoInvFold call CzoInvFold ()
function! CzoInvFold ()
    set foldenable!
endfunction

command!  CzoInvList call CzoInvList ()
function! CzoInvList ()
    set list!
endfunction

command!  CzoInvNumber call CzoInvNumber ()
function! CzoInvNumber ()
    set number!
endfunction

command!  CzoInvPaste call CzoInvPaste ()
function! CzoInvPaste ()
    set paste!
endfunction

command!  CzoInvWrap call CzoInvWrap ()
function! CzoInvWrap ()
    set wrap!
endfunction

command!  CzoVisualClear call CzoVisualClear ()
function! CzoVisualClear ()
    hi Visual        guifg=NONE    guibg=#36403c gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
    hi Search        guifg=NONE    guibg=#503825 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
    hi IncSearch     guifg=NONE    guibg=#596B63 gui=NONE      ctermfg=Black      ctermbg=Blue     cterm=NONE      term=NONE
endfunction

command!  CzoVisualGrey call CzoVisualGrey ()
function! CzoVisualGrey ()
    hi Visual        guifg=#36403c guibg=#ebdbb2 gui=inverse   ctermfg=Gray       ctermbg=Black    cterm=inverse   term=inverse
    hi Search        guifg=#503825 guibg=#ebdbb2 gui=inverse   ctermfg=Yellow     ctermbg=Black    cterm=inverse   term=inverse
    hi IncSearch     guifg=#596B63 guibg=#ebdbb2 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
endfunction

command!  CzoMSwinEnable call CzoMSwinEnable ()
function! CzoMSwinEnable ()
    if filereadable(expand("$VIMRUNTIME/mswin.vim"))
        so $VIMRUNTIME/mswin.vim
        " but dont use Ctrl-A
        noremap     <C-A>   <C-A>
        inoremap    <C-A>   <C-A>
        noremap     <C-Y>   <C-Y>
        inoremap    <C-Y>   <C-Y>
        noremap     <C-F>   <C-F>
        inoremap    <C-F>   <C-F>
    else
        "echo "WARNING: no $VIMRUNTIME/mswin.vim..."
        behave mswin
        " Sort of for noX11
        vnoremap    <C-X>       "+x
        vnoremap    <S-Del>     "+x
        vnoremap    <C-C>       "+y
        vnoremap    <C-Insert>  "+y
        map         <C-V>       "+gP
        inoremap    <C-V>       <C-O>"+gP
        map         <S-Insert>  "+gP
        inoremap    <S-Insert>  <C-O>"+gP
        cmap        <C-V>       <C-R>+
        cmap        <S-Insert>  <C-R>+
    endif
endfunction

command!  CzoMSwinNoX11 call CzoMSwinNoX11 ()
function! CzoMSwinNoX11 ()
    if filereadable(expand("$VIMRUNTIME/mswin.vim"))
        so $VIMRUNTIME/mswin.vim
        " but dont use Ctrl-A
        noremap     <C-A>   <C-A>
        inoremap    <C-A>   <C-A>
        noremap     <C-Y>   <C-Y>
        inoremap    <C-Y>   <C-Y>
        noremap     <C-F>   <C-F>
        inoremap    <C-F>   <C-F>
    else
        "echo "WARNING: no $VIMRUNTIME/mswin.vim..."
        behave mswin
    endif

    " Sort of for noX11
    vnoremap    <C-X>       x
    vnoremap    <S-Del>     x
    vnoremap    <C-C>       y
    vnoremap    <C-Insert>  y
    map         <C-V>       gP
    inoremap    <C-V>       <C-O>gP
    map         <S-Insert>  gP
    inoremap    <S-Insert>  <C-O>gP
    cmap        <C-V>       <C-R>"
    cmap        <S-Insert>  <C-R>"
endfunction

command!  CzoMSwinDisable call CzoMSwinDisable ()
function! CzoMSwinDisable ()
    behave xterm
endfunction


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
" 2021/10/03 : macvim
" set clipboard=unnamed
" if has("unnamedplus") " X11 support
"     set clipboard+=unnamedplus
" endif
"
" https://github.com/kana/vim-fakeclip

if version >= 601
    if has('clipboard')
        call CzoMSwinEnable()
    else
        " please install vim-athena/vim-gtk (debian) or vim-X11 (redhat)
        "echo "WARNING: vim is compiled without system clipboard or works without X11!!!"
        call CzoMSwinNoX11()
    endif
else
    "echo "WARNING: too old version of vim, behave xterm..."
    call CzoMSwinDisable()
endif

" keyboard
noremap     <C-S>       :update<CR>
vnoremap    <C-S>       <C-C>:update<CR>
inoremap    <C-S>       <Esc>:update<CR>gi
noremap     <C-Z>       u
inoremap    <C-Z>       <C-O>u
vnoremap    <BS>        d
" always use Ctrl-Q instead of Ctrl-V
noremap     <C-Q>       <C-V>

" digraph
inoremap    <C-K><C-D>      <C-K>
" quit
map         <C-K><C-K>      :qa!<CR>
imap        <C-K><C-K>      <C-O>:qa!<CR>
cmap        <C-K><C-K>      <C-C><C-O>:qa!<CR>

" scroll by one line
map  <ScrollWheelUp>        <C-Y>
imap <ScrollWheelUp>        <C-O><C-Y>
map  <ScrollWheelDown>      <C-E>
imap <ScrollWheelDown>      <C-O><C-E>

" scroll by one page
map  <S-ScrollWheelUp>      <C-B>
imap <S-ScrollWheelUp>      <C-O><C-B>
map  <S-ScrollWheelDown>    <C-F>
imap <S-ScrollWheelDown>    <C-O><C-F>

" scroll by one 1/2 page
map  <C-ScrollWheelUp>      <C-U>
imap <C-ScrollWheelUp>      <C-O><C-U>
map  <C-ScrollWheelDown>    <C-D>
imap <C-ScrollWheelDown>    <C-O><C-D>

" shift
vnoremap >          >gv
vnoremap <          <gv

" line move
nnoremap <Up>       gk
inoremap <Up>       <C-O>gk
nnoremap <Down>     gj
inoremap <Down>     <C-O>gj

" goto tags
map  <C-S-PageUp>   <C-]>
imap <C-S-PageUp>   <C-O><C-]>
map  <C-S-PageDown> <C-T>
imap <C-S-PageDown> <C-O><C-T>

" goto diff
nmap <C-Down>       ]c
imap <C-Down>       <C-O>]c
map  <C-Up>         [c
imap <C-Up>         <C-O>[c

" search hilited text
vmap /              y/<C-R>"<CR>
vmap ?              y?<C-R>"<CR>

" function
nmap <F1>           :help <C-R>=expand('<cword>')<CR><CR>
imap <F1>           <C-O>:help <C-R>=expand('<cword>')<CR><CR>

nmap <F2>           ]c
imap <F2>           <C-O>]c
map  <F3>           [c
imap <F3>           <C-O>[c

map  <F4>           :N<CR>
imap <F4>           <C-O>:N<CR>
map  <F5>           :n<CR>
imap <F5>           <C-O>:n<CR>

map  <F6>           :cp<CR>
imap <F6>           <C-O>:cp<CR>
map  <F7>           :cn<CR>
imap <F7>           <C-O>:cn<CR>

map  <F8>           :so ~/.vimrc<CR>
imap <F8>           <C-O>:so ~/.vimrc<CR>

map  <F9>           :make<CR>
imap <F9>           <C-O>:make<CR>

map  <F10>          :qa!<CR>
imap <F10>          <C-O>:qa!<CR>

if version >= 600
    map  <leader>x :so ~/.vimrc<CR>
    imap <leader>x <C-O>:so ~/.vimrc<CR>

    map  <leader>w :so %<CR>
    imap <leader>w <C-O>:so %<CR>

    nmap <leader>hh :set hls!<CR>
    imap <leader>hh <C-O>:set hls!<CR>

    nmap <leader>uu :!perl -pe 's/(\w+)/\u$1/g'<CR>
    imap <leader>uu <C-O>:!perl -pe 's/(\w+)/\u$1/g'<CR>

    map  <leader>h2 yiw:let @/="<C-R>""<CR>:set hls<cr>map ,hh yiw:let @/="<C-R>""<CR>:set hls<cr>
    map  <leader>h1 yiw:let @/="\\<<C-R>"\\>"<CR>:set hls<CR>

    " decode/encode rot13 text
    vmap <leader>13 :!tr A-Za-z N-ZA-Mn-za-m

    " remove "control-m"s - for those mails sent from DOS:
    cmap <leader>rcm %s/<C-M>//g
endif
" end MAPpings



" == Color theme =======================================================

" source $VIMRUNTIME/syntax/hitest.vim

" you can do a source ~/.vimrc, whitout "gruvbox64"
let g:colors_name = "default"

if filereadable(expand("$VIMRUNTIME/syntax/synload.vim"))
        syntax on
endif

if (has("syntax"))
  set background=dark
  if version >= 600
      hi clear
      if exists("syntax_on")
          syntax reset
      endif
  endif

" gruvbox64.vim
let g:colors_name = "gruvbox64"

"           Retro color scheme for Vim.
"           The colors in my gruvbox64 theme for Vim are inspired
"           by the gruvbox style but without bold fonts.
"           This works with 'set termguicolors' in .vimrc (if your
"           terminal allows it) or in an xterm 8c / 16c / 256c
"           with nearly similar colors if you use a gruvbox64
"           terminal palette.
"
"           :source $VIMRUNTIME/syntax/hitest.vim
"
" gruvbox dark
" bg0-h     #1d2021
" bg0       #282828 -
" bg0-s     #32302f -
" bg1       #3c3836 -
" bg2       #504945 -
" bg3       #665c54 -
" bg4       #7c6f64 -
" gray      #928374 -
" fg0       #fbf1c7 -
" fg1       #ebdbb2 -
" fg2       #d5c4a1
" fg3       #bdae93
" fg4       #a89984 -

" NR-8 NAME             NR-16 NAME            Gruvbox    Gruvbox64
"  0   Black            0     Black           #282828     #282828 -
"  4   DarkBlue         1     DarkRed         #cc241d     #cc241d
"  2   DarkGreen        2     DarkGreen       #98971a     #98971a
"  6   DarkCyan         3     Brown           #d79921 --> #fe8019 -
"  1   DarkRed          4     DarkBlue        #458588     #458588
"  5   DarkMagenta      5     DarkMagenta     #b16286     #b16286
"  3   Brown            6     DarkCyan        #689d6a     #689d6a
"  7   Gray             7     Gray            #a89984 --> #c9b788
"  0*  DarkGray         8     DarkGray      - #928374 --> #4a4239
"  4*  Blue             9     Red             #fb4934     #fb4934 -
"  2*  Green            10    Green           #b8bb26     #b8bb26 -
"  6*  Cyan             11    Yellow          #fabd2f     #fabd2f -
"  1*  Red              12    Blue            #83a598     #83a598 -
"  5*  Magenta          13    Magenta         #d3869b     #d3869b -
"  3*  Yellow           14    Cyan            #8ec07c     #8ec07c -
"  7*  White            15    White         - #ebdbb2 --> #fbf1c7 -

" normal : #ebdbb2 vs #c9b788 vs #d5c4a1
hi Normal        guifg=#ebdbb2 guibg=#282828 gui=NONE      ctermfg=White      ctermbg=Black    cterm=NONE      term=NONE
hi Comment       guifg=#928374 guibg=NONE    gui=NONE      ctermfg=Gray       ctermbg=NONE     cterm=NONE      term=NONE
hi Constant      guifg=#d3869b guibg=NONE    gui=NONE      ctermfg=Magenta    ctermbg=NONE     cterm=NONE      term=NONE
hi String        guifg=#b8bb26 guibg=NONE    gui=NONE      ctermfg=Green      ctermbg=NONE     cterm=NONE      term=NONE
hi Character     guifg=#d3869b guibg=NONE    gui=NONE      ctermfg=Magenta    ctermbg=NONE     cterm=NONE      term=NONE
hi Number        guifg=#d3869b guibg=NONE    gui=NONE      ctermfg=Magenta    ctermbg=NONE     cterm=NONE      term=NONE
hi Boolean       guifg=#d3869b guibg=NONE    gui=NONE      ctermfg=Magenta    ctermbg=NONE     cterm=NONE      term=NONE
hi Float         guifg=#d3869b guibg=NONE    gui=NONE      ctermfg=Magenta    ctermbg=NONE     cterm=NONE      term=NONE
hi Identifier    guifg=#83a598 guibg=NONE    gui=NONE      ctermfg=Blue       ctermbg=NONE     cterm=NONE      term=NONE
hi Function      guifg=#b8bb26 guibg=NONE    gui=NONE      ctermfg=Green      ctermbg=NONE     cterm=NONE      term=NONE
hi Statement     guifg=#fe8019 guibg=NONE    gui=NONE      ctermfg=Brown      ctermbg=NONE     cterm=NONE      term=NONE
hi Conditional   guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi Repeat        guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi Label         guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi Operator      guifg=#fbf1c7 guibg=NONE    gui=NONE      ctermfg=White      ctermbg=NONE     cterm=NONE      term=NONE
hi Keyword       guifg=#fe8019 guibg=NONE    gui=NONE      ctermfg=Brown      ctermbg=NONE     cterm=NONE      term=NONE
hi Exception     guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi PreProc       guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi Include       guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi Define        guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi Macro         guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi PreCondit     guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi Type          guifg=#fabd2f guibg=NONE    gui=NONE      ctermfg=Yellow     ctermbg=NONE     cterm=NONE      term=NONE
hi StorageClass  guifg=#fe8019 guibg=NONE    gui=NONE      ctermfg=Brown      ctermbg=NONE     cterm=NONE      term=NONE
hi Structure     guifg=#8ec07c guibg=NONE    gui=NONE      ctermfg=Cyan       ctermbg=NONE     cterm=NONE      term=NONE
hi Typedef       guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi Special       guifg=#fabd2f guibg=NONE    gui=NONE      ctermfg=Yellow     ctermbg=NONE     cterm=NONE      term=NONE
hi Error         guifg=#fb4934 guibg=bg      gui=inverse   ctermfg=Red        ctermbg=bg       cterm=inverse   term=inverse
hi Todo          guifg=#83a598 guibg=NONE    gui=NONE      ctermfg=Blue       ctermbg=NONE     cterm=NONE      term=NONE

hi NonText       guifg=#3c3836 guibg=NONE    gui=NONE      ctermfg=DarkGray   ctermbg=NONE     cterm=NONE      term=NONE
hi SpecialKey    guifg=#3c3836 guibg=NONE    gui=NONE      ctermfg=DarkGray   ctermbg=NONE     cterm=NONE      term=NONE
hi Conceal       guifg=#3c3836 guibg=NONE    gui=NONE      ctermfg=Blue       ctermbg=NONE     cterm=NONE      term=NONE
hi TabLineFill   guifg=#7c6f64 guibg=#35302b gui=NONE      ctermfg=DarkGray   ctermbg=Black    cterm=NONE      term=NONE
hi TabLineSel    guifg=#ebdbb2 guibg=#35302b gui=NONE      ctermfg=White      ctermbg=Black    cterm=NONE      term=NONE
hi MatchParen    guifg=NONE    guibg=#665c54 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi ColorColumn   guifg=NONE    guibg=#3c3836 gui=NONE      ctermfg=NONE       ctermbg=Black    cterm=NONE      term=NONE
hi Underlined    guifg=#83a598 guibg=NONE    gui=underline ctermfg=Blue       ctermbg=NONE     cterm=underline term=underline
hi VertSplit     guifg=#35302b guibg=#35302b gui=NONE      ctermfg=Black      ctermbg=Black    cterm=NONE      term=NONE
hi WildMenu      guifg=#83a598 guibg=#282828 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
hi Directory     guifg=#b8bb26 guibg=NONE    gui=NONE      ctermfg=Green      ctermbg=NONE     cterm=NONE      term=NONE
hi Title         guifg=#a89984 guibg=NONE    gui=NONE      ctermfg=Gray       ctermbg=NONE     cterm=NONE      term=NONE
hi ErrorMsg      guifg=#282828 guibg=#fb4934 gui=NONE      ctermfg=Black      ctermbg=Red      cterm=NONE      term=NONE
hi MoreMsg       guifg=#fabd2f guibg=NONE    gui=NONE      ctermfg=Yellow     ctermbg=NONE     cterm=NONE      term=NONE
hi ModeMsg       guifg=#928374 guibg=NONE    gui=NONE      ctermfg=DarkGray   ctermbg=NONE     cterm=NONE      term=NONE
hi Question      guifg=#fe8019 guibg=NONE    gui=NONE      ctermfg=Brown      ctermbg=NONE     cterm=NONE      term=NONE
hi WarningMsg    guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE
hi LineNr        guifg=#504945 guibg=NONE    gui=NONE      ctermfg=DarkGray   ctermbg=NONE     cterm=NONE      term=NONE
hi CursorLineNr  guifg=#928374 guibg=#32302f gui=NONE      ctermfg=DarkGray   ctermbg=Black    cterm=NONE      term=NONE
hi CursorLine    guifg=NONE    guibg=#32302f gui=NONE      ctermfg=NONE       ctermbg=Black    cterm=NONE      term=NONE
hi SignColumn    guifg=NONE    guibg=#32302f gui=NONE      ctermfg=NONE       ctermbg=Black    cterm=NONE      term=NONE
hi Folded        guifg=#928374 guibg=#32302f gui=italic    ctermfg=Gray       ctermbg=Black    cterm=italic    term=italic
hi FoldColumn    guifg=#928374 guibg=#32302f gui=NONE      ctermfg=Gray       ctermbg=Black    cterm=NONE      term=NONE
hi Cursor        guifg=#282828 guibg=#b8bb26 gui=NONE      ctermfg=Black      ctermbg=Green    cterm=NONE      term=NONE
hi Pmenu         guifg=#ebdbb2 guibg=#504945 gui=NONE      ctermfg=White      ctermbg=DarkGray cterm=NONE      term=NONE
hi PmenuSel      guifg=#282828 guibg=#83a598 gui=NONE      ctermfg=Black      ctermbg=Blue     cterm=NONE      term=NONE
hi PmenuSbar     guifg=NONE    guibg=#504945 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi PmenuThumb    guifg=NONE    guibg=#7c6f64 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi SpellCap      guifg=NONE    guibg=NONE    gui=underline ctermfg=NONE       ctermbg=NONE     cterm=underline term=underline
hi SpellBad      guifg=NONE    guibg=NONE    gui=underline ctermfg=NONE       ctermbg=NONE     cterm=underline term=underline
hi SpellLocal    guifg=NONE    guibg=NONE    gui=underline ctermfg=NONE       ctermbg=NONE     cterm=underline term=underline
hi SpellRare     guifg=NONE    guibg=NONE    gui=underline ctermfg=NONE       ctermbg=NONE     cterm=underline term=underline

hi DiffAdd       guifg=NONE    guibg=#4F2E2A gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffChange    guifg=NONE    guibg=#4F2E2A gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffDelete    guifg=#753730 guibg=#4F2E2A gui=NONE      ctermfg=Black      ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffText      guifg=NONE    guibg=#753730 gui=NONE      ctermfg=NONE       ctermbg=DarkBlue cterm=NONE      term=NONE

hi Visual        guifg=NONE    guibg=#36403c gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi Search        guifg=NONE    guibg=#503825 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi IncSearch     guifg=NONE    guibg=#596B63 gui=NONE      ctermfg=Black      ctermbg=Blue     cterm=NONE      term=NONE

if &t_Co < 16
hi Visual        guifg=#36403c guibg=#ebdbb2 gui=inverse   ctermfg=Gray       ctermbg=Black    cterm=inverse   term=inverse
hi Search        guifg=#503825 guibg=#ebdbb2 gui=inverse   ctermfg=Yellow     ctermbg=Black    cterm=inverse   term=inverse
hi IncSearch     guifg=#596B63 guibg=#ebdbb2 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
endif

hi User1         guifg=#35302b guibg=#83a598 gui=inverse   ctermfg=DarkGray   ctermbg=Blue     cterm=inverse   term=inverse
hi User2         guifg=#35302b guibg=#fabd2f gui=inverse   ctermfg=DarkGray   ctermbg=Yellow   cterm=inverse   term=inverse
hi User3         guifg=#35302b guibg=#83a598 gui=inverse   ctermfg=DarkGray   ctermbg=Blue     cterm=inverse   term=inverse
hi User4         guifg=#35302b guibg=#b8bb26 gui=inverse   ctermfg=DarkGray   ctermbg=Green    cterm=inverse   term=inverse
hi User5         guifg=#35302b guibg=#fbf1c7 gui=inverse   ctermfg=DarkGray   ctermbg=White    cterm=inverse   term=inverse
hi User6         guifg=#35302b guibg=#fe8019 gui=inverse   ctermfg=DarkGray   ctermbg=Brown    cterm=inverse   term=inverse
hi User7         guifg=#35302b guibg=#928374 gui=inverse   ctermfg=DarkGray   ctermbg=Gray     cterm=inverse   term=inverse
hi User8         guifg=#35302b guibg=#8ec07c gui=inverse   ctermfg=DarkGray   ctermbg=Cyan     cterm=inverse   term=inverse
hi User9         guifg=#35302b guibg=#fe8019 gui=inverse   ctermfg=DarkGray   ctermbg=Brown    cterm=inverse   term=inverse

hi StatusLine       guifg=#35302b guibg=#fbf1c7 gui=inverse        ctermfg=DarkGray ctermbg=White cterm=inverse        term=inverse
hi StatusLineTerm   guifg=#35302b guibg=#fbf1c7 gui=inverse        ctermfg=DarkGray ctermbg=White cterm=inverse        term=inverse
hi StatusLineNC     guifg=#35302b guibg=#ebdbb2 gui=inverse,italic ctermfg=DarkGray ctermbg=White cterm=inverse,italic term=inverse,italic
hi StatusLineTermNC guifg=#35302b guibg=#ebdbb2 gui=inverse,italic ctermfg=DarkGray ctermbg=White cterm=inverse,italic term=inverse,italic

hi! link vimCommentTitle Title
hi! link CursorColumn CursorLine
hi! link TabLine TabLineFill
hi! link VisualNOS Visual
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor

if 0
  hi! link cssBraces Delimiter
  hi! link cssClassName Special
  hi! link cssClassNameDot Normal
  hi! link cssPseudoClassId Special
  hi! link cssTagName Statement
  hi! link helpHyperTextJump Constant
  hi! link htmlArg Constant
  hi! link htmlEndTag Statement
  hi! link htmlTag Statement
  hi! link jsonQuote Normal
  hi! link phpVarSelector Identifier
  hi! link pythonFunction Title
  hi! link rubyDefine Statement
  hi! link rubyFunction Title
  hi! link rubyInterpolationDelimiter String
  hi! link rubySharpBang Comment
  hi! link rubyStringDelimiter String
  hi! link sassClass Special
  hi! link shFunction Normal
  hi! link vimContinue Comment
  hi! link vimFuncSID vimFunction
  hi! link vimFuncVar Normal
  hi! link vimFunction Title
  hi! link vimGroup Statement
  hi! link vimHiGroup Statement
  hi! link vimHiTerm Identifier
  hi! link vimMapModKey Special
  hi! link vimOption Identifier
  hi! link vimVar Normal
  hi! link xmlAttrib Constant
  hi! link xmlAttribPunct Statement
  hi! link xmlEndTag Statement
  hi! link xmlNamespace Statement
  hi! link xmlTag Statement
  hi! link xmlTagName Statement
  hi! link yamlKeyValueDelimiter Delimiter
  hi! link CtrlPPrtCursor Cursor
  hi! link CtrlPMatch Title
  hi! link CtrlPMode2 StatusLine
  hi! link deniteMatched Normal
  hi! link deniteMatchedChar Title
  hi! link jsFlowMaybe Normal
  hi! link jsFlowObject Normal
  hi! link jsFlowType PreProc
  hi! link graphqlName Normal
  hi! link graphqlOperator Normal
  hi! link gitmessengerHash Comment
  hi! link gitmessengerHeader Statement
  hi! link gitmessengerHistory Constant
  hi! link jsArrowFunction Operator
  hi! link jsClassDefinition Normal
  hi! link jsClassFuncName Title
  hi! link jsExport Statement
  hi! link jsFuncName Title
  hi! link jsFutureKeys Statement
  hi! link jsFuncCall Normal
  hi! link jsGlobalObjects Statement
  hi! link jsModuleKeywords Statement
  hi! link jsModuleOperators Statement
  hi! link jsNull Constant
  hi! link jsObjectFuncName Title
  hi! link jsObjectKey Identifier
  hi! link jsSuper Statement
  hi! link jsTemplateBraces Special
  hi! link jsUndefined Constant
  hi! link markdownBold Special
  hi! link markdownCode String
  hi! link markdownCodeDelimiter String
  hi! link markdownHeadingDelimiter Comment
  hi! link markdownRule Comment
  hi! link ngxDirective Statement
  hi! link plug1 Normal
  hi! link plug2 Identifier
  hi! link plugDash Comment
  hi! link plugMessage Special
  hi! link SignifySignAdd GitGutterAdd
  hi! link SignifySignChange GitGutterChange
  hi! link SignifySignChangeDelete GitGutterChangeDelete
  hi! link SignifySignDelete GitGutterDelete
  hi! link SignifySignDeleteFirstLine SignifySignDelete
  hi! link StartifyBracket Comment
  hi! link StartifyFile Identifier
  hi! link StartifyFooter Constant
  hi! link StartifyHeader Constant
  hi! link StartifyNumber Special
  hi! link StartifyPath Comment
  hi! link StartifySection Statement
  hi! link StartifySlash Comment
  hi! link StartifySpecial Normal
  hi! link svssBraces Delimiter
  hi! link swiftIdentifier Normal
  hi! link typescriptAjaxMethods Normal
  hi! link typescriptBraces Normal
  hi! link typescriptEndColons Normal
  hi! link typescriptFuncKeyword Statement
  hi! link typescriptGlobalObjects Statement
  hi! link typescriptHtmlElemProperties Normal
  hi! link typescriptIdentifier Statement
  hi! link typescriptMessage Normal
  hi! link typescriptNull Constant
  hi! link typescriptParens Normal
endif


if version > 604
    if has('nvim')
        let g:terminal_color_0  = '#282828'
        let g:terminal_color_1  = '#cc241d'
        let g:terminal_color_2  = '#98971a'
        let g:terminal_color_3  = '#fe8019'
        let g:terminal_color_4  = '#458588'
        let g:terminal_color_5  = '#b16286'
        let g:terminal_color_6  = '#689d6a'
        let g:terminal_color_7  = '#c9b788'
        let g:terminal_color_8  = '#4a4239'
        let g:terminal_color_9  = '#fb4934'
        let g:terminal_color_10 = '#b8bb26'
        let g:terminal_color_11 = '#fabd2f'
        let g:terminal_color_12 = '#83a598'
        let g:terminal_color_13 = '#d3869b'
        let g:terminal_color_14 = '#8ec07c'
        let g:terminal_color_15 = '#fbf1c7'
    else
        let g:terminal_ansi_colors = [
                                \ '#282828',
                                \ '#cc241d',
                                \ '#98971a',
                                \ '#fe8019',
                                \ '#458588',
                                \ '#b16286',
                                \ '#689d6a',
                                \ '#c9b788',
                                \ '#4a4239',
                                \ '#fb4934',
                                \ '#b8bb26',
                                \ '#fabd2f',
                                \ '#83a598',
                                \ '#d3869b',
                                \ '#8ec07c',
                                \ '#fbf1c7'
                                \           ]
    endif
endif

endif
" end Color theme


" == template.vim ======================================================

" VIm Template
" Based on Header.vim by Johannes Zellner
" http://www.zellner.org/vim/functions/Header.vim)
"
"" old time:
""source all func in ~/etc/vim/run/
""source $HOME/etc/vim/func/template.vim
"exec substitute(glob("~/etc/vim/run/*.vim"), "^\\|\n", "&source ", "g")
"
"debug
"set verbose=9
"autocmd!

let g:TemplateMaxHeaderLines=50
let g:TemplateAuthor="Olivier Sirol <czo@free.fr>"
let g:TemplateLicense="GPL-2.0 (http:\\/\\/www.gnu.org\\/copyleft)"
let g:DoCzoTemplate=1

command! -nargs=? Template call Template (<q-args>)
command! TemplateMacro call TemplateMacro ()
command! TemplateTimeStamp call TemplateTimeStamp ()

autocmd BufNewFile * call TemplateNewFile ("")
autocmd BufReadPre,FileReadPre   * call TemplateGetTime ()
autocmd BufWritePre,FileWritePre * call TemplateTimeStamp ()

function! TemplateDate()
    let save_lang = v:lc_time
    silent! exec 'language time C'
    " my date: between French and English
    let LastModDate=strftime("%A %d %B %Y, %H:%M")
    " create a RFC822-conformant date
    "let LastModDate=strftime("%a, %d %b %Y %H:%M:%S %z")
    silent! exec 'language time ' . save_lang
    return LastModDate
endfunction

function! TemplateGitId()
    let save_lang = v:lc_time
    silent! exec 'language time C'
    let GitId=escape(strftime("%Y/%m/%d %T"), '/')
    let GitId= expand("%:t") . ',v 1.42 ' . GitId
    silent! exec 'language time ' . save_lang
    return GitId
endfunction

function! TemplateGitDate()
    let save_lang = v:lc_time
    silent! exec 'language time C'
    let GitDate=strftime("%Y-%m-%d %H:%M")
    silent! exec 'language time ' . save_lang
    return GitDate
endfunction

function! TemplateAppDate()
    let save_lang = v:lc_time
    silent! exec 'language time C'
    let AppDate=strftime('"%Y-%m-%d"')
    silent! exec 'language time ' . save_lang
    return AppDate
endfunction

function! TemplateCopyrightDate()
    return  '(C) ' . b:Template_Copyright_Year . ' ' . g:TemplateAuthor
endfunction

function! TemplateGetTime ()
    let b:Template_opentime=localtime()
endfunction

function! FindStrInHeader(pat)
    if line("$") < g:TemplateMaxHeaderLines
        let g:TemplateMaxHeaderLines = line("$")
    endif
    normal G
    let currentline = line(".")
    exec '1,'.g:TemplateMaxHeaderLines.'s/'.a:pat.'/&/ge'
    call histdel("search",-1)
    if line(".") != currentline && line(".") <= g:TemplateMaxHeaderLines
        normal ''
        exec 'ijump! /'.a:pat.'/'
        return 1
    endif
    return 0
endfunction

function! TemplateTimeStamp ()

    if g:DoCzoTemplate
        if &modified == 1
            let save_report = &report
            let &report = 999999
            normal mwHmv

            " This is the fourth time I did modified my headers,
            " and this is for old scripts I may have...
            " My headers are:
            "
            " Filename: a.sh
            " Author: Olivier Sirol <czo@free.fr>
            " License: GPL-2.0 (http://www.gnu.org/copyleft)
            " File Created: oct. 1992
            " Last Modified: dimanche 09 octobre 2022, 21:58
            " $Id: .vimrc,v 1.495 2024/09/17 19:19:42 czo Exp $
            " Edit Time: 11:03:26
            " Description:
            "
            " Copyright: (C) 1992 Olivier Sirol <czo@free.fr>

            if 1
                " changed Started: by File Created:
                let pattern = '\(^.\=.\=.\=\s* \)Started:\(.*\)'
                if FindStrInHeader(pattern)
                    exec 's/'.pattern.'/\1File Created:\2/e'
                    call histdel("search",-1)
                endif
                " changed Created: by File Created:
                let pattern = '\(^.\=.\=.\=\s* \)Created:\(.*\)'
                if FindStrInHeader(pattern)
                    exec 's/'.pattern.'/\1File Created:\2/e'
                    call histdel("search",-1)
                endif
                " changed Last Change: by Last Modified:
                let pattern = '\(^.\=.\=.\=\s* Last \)Change:\(.*\)'
                if FindStrInHeader(pattern)
                    exec 's/'.pattern.'/\1Modified:\2/e'
                    call histdel("search",-1)
                endif
                " Author: is new !
            endif

            "" Normal changes in my header here:

            " substitute CVS $ Id:$ because now, I use Git...
            let pattern = '\(.*$I'.'d: \).*\( czo Git $.*\)'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1'.TemplateGitId().'\2/e'
                call histdel("search",-1)
            endif

            " substitute CVS $ CzoDate:$ by $ CzoDate: 2024-03-14 14:36 $
            " let pattern = '\(.*$Czo'.'Date:\) *[0-9 -:]* *\$\(.*\)'
            let pattern = '\(.*( Czo'.'Date:\) *[0-9 -:]* *)\(.*\)'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.TemplateGitDate().' )\2/e'
                call histdel("search",-1)
            endif

            " substitute CVS $ CzoAppDate=; by $ CzoAppDate = '2024-03-14';
            let pattern = '\(.*$Czo'.'AppDate\) *= *[0-9"-]* *;\(.*\)'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 = '.TemplateAppDate().';\2/e'
                call histdel("search",-1)
            endif

            " substitute the file name
            let pattern = '\(^.\=.\=.\=\s* Filename:\).*'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.escape(expand("%:t"), '\').'/e'
                call histdel("search",-1)
            endif

            " substitute Author
            let pattern = '\(^.\=.\=.\=\s* Author:\).*'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.g:TemplateAuthor.'/e'
                call histdel("search",-1)
            endif

            " substitute License
            let pattern = '\(^.\=.\=.\=\s* License:\).*'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.g:TemplateLicense.'/e'
                call histdel("search",-1)
            endif

            " time stamp
            let pattern = '\(^.\=.\=.\=\s* Last Modified:\).*'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.TemplateDate().'/e'
                call histdel("search",-1)
            endif

            " edit time
            let pattern = '\(^.\=.\=.\=\s* Edit Time:\)\s*\([0-9]*:[0-9]*:[0-9]*\).*'
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
                call histdel("search",-1)
                let  b:Template_opentime=localtime()
            endif

            " copy file's created year for Copyright
            let pattern = '\(^.\=.\=.\=\s* File Created:\)\s*\(.*\)'
            if FindStrInHeader(pattern)
                let editline = getline (".")
                let editline = substitute(editline, pattern, '\2', "")
                let Fyear = substitute(editline, '.*\([0-9][0-9][0-9][0-9]\).*', '\1', "")
            else
                let Fyear = '1992'
            endif
            let Lyear = strftime("%Y")
            if ((Lyear == Fyear) || (Lyear < Fyear))
                let b:Template_Copyright_Year = Lyear
            else
                if ((Lyear - Fyear)==1)
                    let b:Template_Copyright_Year = Fyear . ', ' . Lyear
                else
                    let b:Template_Copyright_Year = Fyear . '-' . Lyear
                endif
            endif

            " substitute Copyright
            let pattern = '\(^.\=.\=.\=\s* Copyright:\).*'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1 '.TemplateCopyrightDate().'/e'
                call histdel("search",-1)
            endif

            " not needed ?
            "let @/ = histget("search",-1)
            normal 1G'vzt`w
            let &report = save_report
        endif
    endif

endfunction

function! TemplateMacro ()
    if &modified == 1
        let save_report = &report
        let &report = 999000
        normal mwHmv

        " substitute strftime
        let pattern = '\(.*\)VIMEX{=strftime("\([^)]*\)")}\(.*\)'
        while FindStrInHeader(pattern)
            let editline = getline (".")
            let editline = substitute(editline, pattern, '\2', "")
            let save_lang = v:lc_time
            silent! exec 'language time C'
            exec 's/'.pattern.'/\1'.escape(strftime(editline), '\').'\3/e'
            silent! exec 'language time ' . save_lang
        endw

        " substitute expand
        let pattern = '\(.*\)VIMEX{=\(.*\)}\(.*\)'
        while FindStrInHeader(pattern)
            let editline = getline (".")
            let editline = substitute(editline, pattern, '\2', "")
            exec 's/'.pattern.'/\1'.escape(expand(editline), '\').'\3/e'
        endw

        normal 1G'vzt`w
        let &report = save_report
    endif
endfunction

function! TemplateCzo (...)

    if a:1 == ""
        let xft = &ft
        let xfte = expand("%:e")
        if (xft == "c") && (xfte == "h")
            let xft = "h"
        endif
        if (xft == "cpp") && ((xfte == "hpp") || (xfte == "h++") || (xfte == "hh"))
            let xft = "hpp"
        endif
    else
        let xft = a:1
    endif

    " /* 2011/01/27 : czo */
    " I have only a .vimrc, no more multiple config/template files
    "
    " old code:
    "    let mytemplatefile = expand("$HOME/etc/vim/templates/template\." . xft)
    "    if filereadable(mytemplatefile)
    "        normal 1G
    "        exec ":r " . mytemplatefile
    "        1d
    "    endif
    "
    " to update run this:
    " :r !cd ~/etc/vim-templates ; ./template
    " after delting this:
    " ------------- SearchThisThenDelete -------------

    if xft != ""
        try
            throw xft

            "## template.c #########################################
            catch /^c$/
               0put = \"
                      \/*
                 \\<nl> * Filename: template.c
                 \\<nl> * Author: Olivier Sirol <czo@free.fr>
                 \\<nl> * License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl> * File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl> * Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl> * Edit Time: 0:00:13
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
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
                 \\<nl>/*
                 \\<nl> * ####===========================================================####
                 \\<nl> * #### Main
                 \\<nl> */
                 \\<nl>
                 \\<nl>int main (int argc, char *argv[], char *envp[])
                 \\<nl>{
                 \\<nl>    printf (\\"Size of   char: %d bytes\\n\\", sizeof(char));
                 \\<nl>    printf (\\"Size of    int: %d bytes\\n\\", sizeof(int));
                 \\<nl>    printf (\\"Size of  float: %d bytes\\n\\", sizeof(float));
                 \\<nl>    printf (\\"Size of double: %d bytes\\n\\", sizeof(double));
                 \\<nl>
                 \\<nl>    return (0);
                 \\<nl>}
                 \\"

            "## template.cpp #########################################
            catch /^cpp$/
               0put = \"
                      \// Filename: template.cpp
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl>// Edit Time: 0:00:13
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>
                 \\<nl>#ident \\"$VIMEX{=strftime(\\"Id:$\\")}\\"
                 \\<nl>
                 \\<nl>// ####===========================================================####
                 \\<nl>// #### Include Files
                 \\<nl>
                 \\<nl>#include <iostream>
                 \\<nl>
                 \\<nl>using namespace std;
                 \\<nl>
                 \\<nl>// ####===========================================================####
                 \\<nl>// #### Main
                 \\<nl>
                 \\<nl>int main (int argc, char *argv[], char *envp[])
                 \\<nl>{
                 \\<nl>    cout << \\"Size of   char: \\" << sizeof(char)   << \\" bytes\\" << endl;
                 \\<nl>    cout << \\"Size of    int: \\" << sizeof(int)    << \\" bytes\\" << endl;
                 \\<nl>    cout << \\"Size of  float: \\" << sizeof(float)  << \\" bytes\\" << endl;
                 \\<nl>    cout << \\"Size of double: \\" << sizeof(double) << \\" bytes\\" << endl;
                 \\<nl>
                 \\<nl>    return (0);
                 \\<nl>}
                 \\"

            "## template.crontab #########################################
            catch /^crontab$/
               0put = \"
                      \# Filename: template.crontab
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl># Last Modified: Sunday 31 March 2024, 12:18
                 \\<nl># vim: set filetype=crontab:
                 \\<nl># Description: crontab .crontab.VIMEX{=$USER}@VIMEX{=$HOSTNAME}
                 \\<nl>
                 \\<nl># SHELL=/bin/sh
                 \\<nl>PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
                 \\<nl>
                 \\<nl># .----------------------minute (0-59)
                 \\<nl># \|  .-------------------hour (0-23)
                 \\<nl># \|  \|  .----------------day of the month (1-31)
                 \\<nl># \|  \|  \|  .-------------month of the year (1-12)
                 \\<nl># \|  \|  \|  \|  .----------day of the week (0-6 with 0=Sun)
                 \\<nl># \|  \|  \|  \|  \|
                 \\<nl># *  *  *  *  *          command
                 \\<nl>
                 \\<nl>## crontab reminder
                 \\<nl>1    1    15   *    *    SUJ=\\"Crontab reminder for `id -un`@`hostname`\\" ; ( echo $SUJ ; date ; uname -a ; crontab -l ) \| mail -s \\"$SUJ\\" root > /dev/null
                 \\<nl>
                 \\<nl>## start moteino
                 \\<nl>*/5  *    *    *    *    $HOME/etc/shell/moteinolog.pl > /dev/null 2>&1
                 \\<nl>@reboot                  $HOME/etc/shell/moteinolog.pl > /dev/null 2>&1
                 \\<nl>
                 \\<nl>## needed for wol
                 \\<nl>@reboot                  ethtool -s enp3s0 wol g
                 \\<nl>
                 \\<nl>
                 \\"

            "## template.css #########################################
            catch /^css$/
               0put = \"
                      \/*
                 \\<nl> * Filename: template.css
                 \\<nl> * Author: Olivier Sirol <czo@free.fr>
                 \\<nl> * License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl> * File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl> * Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl> * $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl> * Edit Time: 0:00:13
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl> */
                 \\<nl>
                 \\<nl>html {
                 \\<nl>  background-color: #282828;
                 \\<nl>  color: #ebdbb2;
                 \\<nl>}
                 \\<nl>
                 \\<nl>body {
                 \\<nl>  margin: 0px 0px;
                 \\<nl>  text-align: center;
                 \\<nl>  font-family: \\"Bitter\\", monospace;
                 \\<nl>  font-size: 52px;
                 \\<nl>  line-height: 1.3;
                 \\<nl>  text-shadow: 0 0 0.2rem rgba(0, 0, 0, 0.9);
                 \\<nl>}
                 \\<nl>
                 \\<nl>.code {
                 \\<nl>  font-weight: bold;
                 \\<nl>}
                 \\<nl>
                 \\<nl>.reason {
                 \\<nl>  font-size: 46px;
                 \\<nl>}
                 \\<nl>
                 \\<nl>a,
                 \\<nl>a:visited,
                 \\<nl>a:active,
                 \\<nl>a:hover {
                 \\<nl>  margin: 20px;
                 \\<nl>  font-size: 22px;
                 \\<nl>  color: #af4b3f;
                 \\<nl>  text-decoration: none;
                 \\<nl>  outline: 0;
                 \\<nl>}
                 \\<nl>
                 \\<nl>a:hover {
                 \\<nl>  color: #d14836;
                 \\<nl>  text-decoration: underline;
                 \\<nl>}
                 \\<nl>
                 \\<nl>.outer {
                 \\<nl>  display: table;
                 \\<nl>  position: absolute;
                 \\<nl>  height: 100%;
                 \\<nl>  width: 100%;
                 \\<nl>}
                 \\<nl>
                 \\<nl>.middle {
                 \\<nl>  display: table-cell;
                 \\<nl>  vertical-align: middle;
                 \\<nl>}
                 \\<nl>
                 \\<nl>.inner {
                 \\<nl>  margin-left: auto;
                 \\<nl>  margin-right: auto;
                 \\<nl>  text-align: center;
                 \\<nl>}
                 \\<nl>
                 \\<nl>video {
                 \\<nl>  width: 100vw;
                 \\<nl>  height: 100vh;
                 \\<nl>  object-fit: cover;
                 \\<nl>  position: fixed;
                 \\<nl>  top: 0;
                 \\<nl>  left: 0;
                 \\<nl>  z-index: -1;
                 \\<nl>}
                 \\<nl>
                 \\<nl>@media (prefers-color-scheme: dark) {
                 \\<nl>  html {
                 \\<nl>    background-color: #282828;
                 \\<nl>    color: #ebdbb2;
                 \\<nl>  }
                 \\<nl>  body {
                 \\<nl>    text-shadow: 0 0 0.2rem rgba(0, 0, 0, 0.9);
                 \\<nl>  }
                 \\<nl>}
                 \\<nl>
                 \\<nl>@media (prefers-color-scheme: light) {
                 \\<nl>  html {
                 \\<nl>    background-color: #fefeff;
                 \\<nl>    color: #3c3836;
                 \\<nl>  }
                 \\<nl>  body {
                 \\<nl>    text-shadow: 0 0 0.2rem rgba(255, 255, 255, 0.9);
                 \\<nl>  }
                 \\<nl>}
                 \\"

            "## template.h #########################################
            catch /^h$/
               0put = \"
                      \/*
                 \\<nl> * Filename: template.h
                 \\<nl> * Author: Olivier Sirol <czo@free.fr>
                 \\<nl> * License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl> * File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl> * Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl> * Edit Time: 0:00:13
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
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
                 \\<nl>#endif
                 \\"

            "## template.hpp #########################################
            catch /^hpp$/
               0put = \"
                      \// Filename: template.hpp
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl>// Edit Time: 0:00:13
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>
                 \\<nl>#ifndef MY_HEADER_H
                 \\<nl>#define MY_HEADER_H
                 \\<nl>
                 \\<nl>#ident \\"$VIMEX{=strftime(\\"Id:$\\")}\\"
                 \\<nl>
                 \\<nl>// ####===========================================================####
                 \\<nl>// #### Prototypes
                 \\<nl>
                 \\<nl>#endif
                 \\"

            "## template.html #########################################
            catch /^html$/
               0put = \"
                      \<!DOCTYPE html>
                 \\<nl>
                 \\<nl><!--
                 \\<nl>// Filename: template.html
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 June 2024, 21:43
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>// Edit Time: 0:00:30
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2024 Olivier Sirol <czo@free.fr>
                 \\<nl>-->
                 \\<nl>
                 \\<nl><html lang=\\"en\\">
                 \\<nl>
                 \\<nl><head>
                 \\<nl>
                 \\<nl>    <title>My bookmarks</title>
                 \\<nl>
                 \\<nl>    <meta charset=\\"utf-8\\">
                 \\<nl>    <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\">
                 \\<nl>    <meta name=\\"theme-color\\" content=\\"#007bff\\">
                 \\<nl>
                 \\<nl>    <meta name=\\"Author\\" content=\\"Olivier Sirol <czo@ipgp.fr>\\" />
                 \\<nl>    <meta name=\\"Generator\\" content=\\"Vim\\">
                 \\<nl>    <meta name=\\"Description\\" content=\\"__DESCRIPTION__\\">
                 \\<nl>    <meta name=\\"Keywords\\" content=\\"__KEYWORDS__\\">
                 \\<nl>
                 \\<nl>    <link rel=\\"shortcut icon\\" href=\\"favicon.png\\">
                 \\<nl>    <link rel=\\"apple-touch-icon\\" href=\\"favicon.png\\">
                 \\<nl>    <link rel=\\"icon\\" href=\\"favicon.png\\">
                 \\<nl>
                 \\<nl>    <link rel=\\"stylesheet\\" href=\\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\\" integrity=\\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\\" crossorigin=\\"anonymous\\">
                 \\<nl>    <script src=\\"https://code.jquery.com/jquery-3.4.1.slim.min.js\\" integrity=\\"sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n\\" crossorigin=\\"anonymous\\"></script>
                 \\<nl>    <script src=\\"https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js\\" integrity=\\"sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo\\" crossorigin=\\"anonymous\\"></script>
                 \\<nl>    <script src=\\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\\" integrity=\\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\\" crossorigin=\\"anonymous\\"></script>
                 \\<nl>
                 \\<nl></head>
                 \\<nl>
                 \\<nl><body>
                 \\<nl>    <div id=\\"maincontent\\" class=\\"container\\">
                 \\<nl>        <h1>&nbsp;</h1>
                 \\<nl>        <div class=\\"list-group\\">
                 \\<nl>            <a href=\\"\\" class=\\"list-group-item list-group-item-action active\\" aria-current=\\"true\\">My bookmarks</a>
                 \\<nl>            <a href=\\"https://www.google.com/\\" class=\\"list-group-item list-group-item-action\\">Google search</a>
                 \\<nl>            <a href=\\"https://duckduckgo.com/\\" class=\\"list-group-item list-group-item-action\\">DuckDuckGo search</a>
                 \\<nl>        </div>
                 \\<nl>    </div>
                 \\<nl></body>
                 \\<nl>
                 \\<nl></html>
                 \\"

            "## template.java #########################################
            catch /^java$/
               0put = \"
                      \package org.czo.badumtsss;
                 \\<nl>
                 \\<nl>// Filename: template.java
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>// Edit Time: 0:00:13
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>import android.app.Activity;
                 \\<nl>import android.media.AudioManager;
                 \\<nl>import android.media.MediaPlayer;
                 \\<nl>import android.os.Bundle;
                 \\<nl>import android.view.WindowManager;
                 \\<nl>
                 \\<nl>public class MainActivity extends Activity {
                 \\<nl>
                 \\<nl>    @Override
                 \\<nl>    protected void onCreate(Bundle savedInstanceState) {
                 \\<nl>        super.onCreate(savedInstanceState);
                 \\<nl>        // Do not listen for touch events
                 \\<nl>        getWindow().addFlags(WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE);
                 \\<nl>
                 \\<nl>        // Stream at max volume
                 \\<nl>        // final AudioManager audioManager = (AudioManager) getApplicationContext().getSystemService(Context.AUDIO_SERVICE);
                 \\<nl>        // final int oldvol = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
                 \\<nl>        // audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC), AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
                 \\<nl>
                 \\<nl>        final MediaPlayer mediaPlayer = MediaPlayer.create(getApplicationContext(), R.raw.badum);
                 \\<nl>        mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
                 \\<nl>
                 \\<nl>        mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                 \\<nl>            @Override
                 \\<nl>            public void onCompletion(MediaPlayer mp) {
                 \\<nl>                mp.release();
                 \\<nl>                // audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, oldvol, 0);
                 \\<nl>            }
                 \\<nl>        });
                 \\<nl>
                 \\<nl>        mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                 \\<nl>            @Override
                 \\<nl>            public void onPrepared(MediaPlayer mp) {
                 \\<nl>                mp.start();
                 \\<nl>            }
                 \\<nl>        });
                 \\<nl>
                 \\<nl>        finish();
                 \\<nl>    }
                 \\<nl>}
                 \\"

            "## template.javascript #########################################
            catch /^javascript$/
               0put = \"
                      \/*
                 \\<nl> * Filename: template.javascript
                 \\<nl> * Author: Olivier Sirol <czo@free.fr>
                 \\<nl> * License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl> * File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl> * Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl> * $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl> * Edit Time: 0:00:13
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl> */
                 \\<nl>
                 \\<nl>$(document).ready(function () {
                 \\<nl>    var olddisptime = '';
                 \\<nl>    var oldimgName = 0;
                 \\<nl>
                 \\<nl>    function debugc(str) {
                 \\<nl>        if (0)
                 \\<nl>            console.log(str);
                 \\<nl>    }
                 \\<nl>
                 \\<nl>    function updateClock() {
                 \\<nl>        var dow_fr = new Array(\\"dimanche\\", \\"lundi\\", \\"mardi\\", \\"mercredi\\", \\"jeudi\\", \\"vendredi\\", \\"samedi\\");
                 \\<nl>        var month_fr = new Array(\\"janvier\\", \\"février\\", \\"mars\\", \\"avril\\", \\"mai\\", \\"juin\\", \\"juillet\\", \\"août\\", \\"septembre\\", \\"octobre\\", \\"novembre\\", \\"décembre\\");
                 \\<nl>
                 \\<nl>        var now = new Date();
                 \\<nl>        var imgday = Math.floor(now.getTime() / 1000 / 60 / 60 / 24);
                 \\<nl>
                 \\<nl>        imgName = (imgday % 98) + 1;
                 \\<nl>
                 \\<nl>        debugc(now.getTime());
                 \\<nl>        debugc(imgday);
                 \\<nl>        debugc(imgName);
                 \\<nl>
                 \\<nl>        if ((imgName != oldimgName)) {
                 \\<nl>            $(\\".intro\\").css(\\"background-image\\", \\"url(sbg/wal/\\" + imgName + \\".jpg)\\");
                 \\<nl>            oldimgName = imgName;
                 \\<nl>        }
                 \\<nl>
                 \\<nl>        hours = now.getHours();
                 \\<nl>        mins = now.getMinutes();
                 \\<nl>        secs = now.getSeconds();
                 \\<nl>        day = dow_fr[now.getDay()] + \\" \\" + now.getDate() + \\" \\" + month_fr[now.getMonth()];
                 \\<nl>
                 \\<nl>        if (hours < 10) hours = \\"0\\" + hours;
                 \\<nl>        if (mins < 10) mins = \\"0\\" + mins;
                 \\<nl>        if (secs < 10) secs = \\"0\\" + secs;
                 \\<nl>        disptime = hours + \\":\\" + mins;
                 \\<nl>        debugc(disptime);
                 \\<nl>
                 \\<nl>        if (disptime != olddisptime) {
                 \\<nl>            $('#czotime').text(disptime);
                 \\<nl>            $('#czodate').text(day);
                 \\<nl>            olddisptime = disptime;
                 \\<nl>        }
                 \\<nl>
                 \\<nl>        // call this function again in 1000ms
                 \\<nl>        setTimeout(updateClock, 1000);
                 \\<nl>    }
                 \\<nl>    updateClock();
                 \\<nl>
                 \\<nl>});
                 \\"

            "## template.lua #########################################
            catch /^lua$/
               0put = \"
                      \#! /usr/bin/env lua
                 \\<nl>
                 \\<nl>-- Filename: template.lua
                 \\<nl>-- Author: Olivier Sirol <czo@free.fr>
                 \\<nl>-- License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>-- File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>-- Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl>-- $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>-- Edit Time: 0:00:12
                 \\<nl>-- Description:
                 \\<nl>--
                 \\<nl>-- Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>function cat(file, bufsize)
                 \\<nl>    if not bufsize then bufsize = 8192 end
                 \\<nl>    local f = io.open(file)
                 \\<nl>    if not f then return false end
                 \\<nl>    local buffer
                 \\<nl>    for buffer in f:lines(bufsize) do
                 \\<nl>        io.write(buffer)
                 \\<nl>    end
                 \\<nl>    io.close(f)
                 \\<nl>    return true
                 \\<nl>end
                 \\<nl>
                 \\<nl>if #arg == 0 then
                 \\<nl>    arg[1] = \\"/dev/stdin\\"
                 \\<nl>end
                 \\<nl>
                 \\<nl>for i, File in ipairs(arg) do
                 \\<nl>    cat(File)
                 \\<nl>end
                 \\"

            "## template.make #########################################
            catch /^make$/
               0put = \"
                      \# Filename: template.make
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl># Last Modified: Friday 16 June 2023, 19:22
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl># Edit Time: 0:00:25
                 \\<nl># Description:
                 \\<nl>#               Makefile for this project
                 \\<nl>#
                 \\<nl>#      $@ Target name
                 \\<nl>#      $< Name of the first dependency
                 \\<nl>#      $^ List of dependencies
                 \\<nl>#      $? List of dependencies newer than the target
                 \\<nl>#      $* Target name without suffix
                 \\<nl>#
                 \\<nl># Copyright: (C) 2023 Olivier Sirol <czo@free.fr>
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
                 \\<nl>\<tab>@echo \\"<- all done!\\"
                 \\<nl>
                 \\<nl>viewdeps: $(DEPS)
                 \\<nl>\<tab>@echo $(DEPS)
                 \\<nl>
                 \\<nl>$(EXEC): $(OBJ)
                 \\<nl>\<tab>$(CC) -o $@ $^ $(LIBS)
                 \\<nl>
                 \\<nl>%.o: %.c $(DEPS)
                 \\<nl>\<tab>$(CC) -c -o $@ $< $(CFLAGS)
                 \\<nl>
                 \\<nl>clean:
                 \\<nl>\<tab>rm -f *.o
                 \\<nl>\<tab>@echo \\"<- clean done!\\"
                 \\<nl>
                 \\<nl>realclean: clean
                 \\<nl>\<tab>rm -f $(EXEC)
                 \\<nl>\<tab>@echo \\"<- realclean done!\\"
                 \\<nl>
                 \\<nl>fclean: realclean
                 \\<nl>
                 \\<nl>re: realclean all
                 \\<nl>
                 \\<nl>.PHONY: all clean realclean fclean re
                 \\"

            "## template.markdown #########################################
            catch /^markdown$/
               0put = \"
                      \<!--
                 \\<nl>// Filename: template.markdown
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 June 2024, 21:46
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>// Edit Time: 0:00:36
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2024 Olivier Sirol <czo@free.fr>
                 \\<nl>-->
                 \\<nl>
                 \\<nl># Markdown Cheatsheet
                 \\<nl>
                 \\<nl>## Basic Formatting
                 \\<nl>
                 \\<nl>* **Bold**: `**Bold**`
                 \\<nl>* _Emphasized_: `_Emphasized_`
                 \\<nl>* Strikethrough : `~~Strikethrough~~`
                 \\<nl>* Horizontal rules: `---`
                 \\<nl>
                 \\<nl>## Code
                 \\<nl>
                 \\<nl>### Inline
                 \\<nl>
                 \\<nl>    Inline `code`
                 \\<nl>Inline `code`
                 \\<nl>
                 \\<nl>### Indented code
                 \\<nl>
                 \\<nl>```
                 \\<nl>    // Some comments
                 \\<nl>    line 1 of code
                 \\<nl>    line 2 of code
                 \\<nl>    line 3 of code
                 \\<nl>```
                 \\<nl>
                 \\<nl>    // Some comments
                 \\<nl>    line 1 of code
                 \\<nl>    line 2 of code
                 \\<nl>    line 3 of code
                 \\<nl>
                 \\<nl>
                 \\<nl>### Block code \\"fences\\" between three ```
                 \\<nl>
                 \\<nl>    ```
                 \\<nl>    Sample text here...
                 \\<nl>    ```
                 \\<nl>
                 \\<nl>```
                 \\<nl>Sample text here...
                 \\<nl>```
                 \\<nl>
                 \\<nl>### Syntax highlighting between three ``` + lang
                 \\<nl>
                 \\<nl>    ``` js
                 \\<nl>    var foo = function (bar) {
                 \\<nl>      return bar++;
                 \\<nl>    };
                 \\<nl>
                 \\<nl>    console.log(foo(5));
                 \\<nl>    ```
                 \\<nl>
                 \\<nl>``` js
                 \\<nl>var foo = function (bar) {
                 \\<nl>  return bar++;
                 \\<nl>};
                 \\<nl>
                 \\<nl>console.log(foo(5));
                 \\<nl>```
                 \\<nl>
                 \\<nl>## Inline HTML
                 \\<nl>
                 \\<nl>    To reboot your computer, press <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>del</kbd>.
                 \\<nl>
                 \\<nl>To reboot your computer, press <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>del</kbd>.
                 \\<nl>
                 \\<nl>## Headers
                 \\<nl>
                 \\<nl>    # Heading 1
                 \\<nl>    ## Heading 2
                 \\<nl>    ### Heading 3
                 \\<nl>
                 \\<nl># Heading 1
                 \\<nl>## Heading 2
                 \\<nl>### Heading 3
                 \\<nl>
                 \\<nl>## Lists
                 \\<nl>
                 \\<nl>### Unordered
                 \\<nl>
                 \\<nl>~~~
                 \\<nl>* One item
                 \\<nl>  * A sub-item
                 \\<nl>  * Another item
                 \\<nl>~~~
                 \\<nl>* One item
                 \\<nl>  * A sub-item
                 \\<nl>  * Another item
                 \\<nl>
                 \\<nl>### Ordered
                 \\<nl>
                 \\<nl>~~~
                 \\<nl>1. An ordered list
                 \\<nl>1. This is the second item
                 \\<nl>1. One more in the ordered list
                 \\<nl>~~~
                 \\<nl>1. An ordered list
                 \\<nl>1. This is the second item
                 \\<nl>1. One more in the ordered list
                 \\<nl>
                 \\<nl>
                 \\<nl>## Tables
                 \\<nl>
                 \\<nl>```
                 \\<nl>\| left-aligned \| centered  \| right-aligned
                 \\<nl>\| :-           \| :-:       \| -:
                 \\<nl>\| zebra        \| stripes   \| are neat
                 \\<nl>\| a            \| b         \| c
                 \\<nl>\| foo          \| foo       \| foo
                 \\<nl>```
                 \\<nl>
                 \\<nl>\| left-aligned \| centered  \| right-aligned
                 \\<nl>\| :-           \| :-:       \| -:
                 \\<nl>\| zebra        \| stripes   \| are neat
                 \\<nl>\| a            \| b         \| c
                 \\<nl>\| foo          \| foo       \| foo
                 \\<nl>
                 \\<nl>## Blockquotes
                 \\<nl>
                 \\<nl>~~~
                 \\<nl>> Blockquotes can also be nested...
                 \\<nl>>> ...by using additional greater-than signs right next to each other...
                 \\<nl>~~~
                 \\<nl>
                 \\<nl>> Blockquotes can also be nested...
                 \\<nl>>> ...by using additional greater-than signs right next to each other...
                 \\<nl>
                 \\<nl>## Links
                 \\<nl>
                 \\<nl>### Link
                 \\<nl>
                 \\<nl>    Go to Markdown [Code](#Code)
                 \\<nl>Go to Markdown [Code](#Code)
                 \\<nl>
                 \\<nl>### Autoconverted link
                 \\<nl>
                 \\<nl>    Autoconverted https://duckduckgo.com/ from link.
                 \\<nl>Autoconverted https://duckduckgo.com/ from link.
                 \\<nl>
                 \\<nl>
                 \\<nl>### Autoconverted mail
                 \\<nl>
                 \\<nl>    Autoconverted <address@example.com> mail.
                 \\<nl>Autoconverted <address@example.com> mail.
                 \\<nl>
                 \\<nl>## Images
                 \\<nl>
                 \\<nl>    ![Gruvbox64](https://raw.githubusercontent.com/czodroid/vscode-theme-gruvbox-64/main/store/icon.png)
                 \\<nl>
                 \\<nl>![Gruvbox64](https://raw.githubusercontent.com/czodroid/vscode-theme-gruvbox-64/main/store/icon.png)
                 \\<nl>
                 \\<nl>
                 \\<nl>
                 \\"

            "## template.perl #########################################
            catch /^perl$/
               0put = \"
                      \#! /usr/bin/env perl
                 \\<nl>#
                 \\<nl># Filename: template.perl
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl># Last Modified: Sunday 24 March 2024, 12:13
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl># Edit Time: 0:00:03
                 \\<nl># Description:
                 \\<nl>#          zpool scrub/resilver for munin
                 \\<nl>#          OK:  100 % (old: off=10)
                 \\<nl>#          BAD:   0 % (old: ON=90)
                 \\<nl>#
                 \\<nl># Copyright: (C) 2024 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>#use strict;
                 \\<nl>use warnings;
                 \\<nl>
                 \\<nl>foreach (qx(zpool status)) {
                 \\<nl>    if (m,^\\s*pool:\\s+(.*),) { $pool = $1; }
                 \\<nl>    if (m,^\\s*scan:\\s+(.*),) { $scan = $1; $ok = 1; }
                 \\<nl>    if ($ok) {
                 \\<nl>        $ok = 0;
                 \\<nl>        if ( $scan =~ '(scrub in progress)\|(resilver in progress)' ) {
                 \\<nl>            $poollist{$pool} = 0;
                 \\<nl>        } else {
                 \\<nl>            $poollist{$pool} = 100;
                 \\<nl>        }
                 \\<nl>    }
                 \\<nl>}
                 \\<nl>
                 \\<nl>if ( $ARGV[0] and $ARGV[0] eq \\"config\\" ) {
                 \\<nl>    print <<EOT;
                 \\<nl>graph_title \\@scrub or rslv zpool
                 \\<nl>graph_vlabel in scrub or rslv at 0
                 \\<nl>graph_category zfs
                 \\<nl>graph_args --base 1000 --lower-limit -5 --upper-limit 105 --rigid
                 \\<nl>graph_info This graph shows the pool scrub or resilver (OK=100 BAD=0).
                 \\<nl>EOT
                 \\<nl>
                 \\<nl>    foreach $d ( sort keys %poollist ) {
                 \\<nl>        print \\"$d.label $d\\n\\";
                 \\<nl>        print \\"$d.warning 90:\\n\\";
                 \\<nl>        ##print \\"$d.critical 90:\\n\\";
                 \\<nl>    }
                 \\<nl>    exit 0;
                 \\<nl>}
                 \\<nl>
                 \\<nl>foreach $d ( sort keys %poollist ) {
                 \\<nl>    print \\"$d.value $poollist{$d}\\n\\";
                 \\<nl>}
                 \\<nl>
                 \\<nl>__END__
                 \\<nl>
                 \\"

            "## template.php #########################################
            catch /^php$/
               0put = \"
                      \<?php
                 \\<nl>
                 \\<nl>// Filename: template.php
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl>// Last Modified: Thursday 13 October 2022, 18:03
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>// Edit Time: 0:00:12
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// Copyright: (C) 2022 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>phpinfo();
                 \\<nl>
                 \\<nl>?>
                 \\"

            "## template.python #########################################
            catch /^python$/
               0put = \"
                      \#! /usr/bin/env python3
                 \\<nl>#
                 \\<nl># Filename: template.python
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl># Last Modified: Sunday 24 March 2024, 15:47
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl># Edit Time: 0:00:04
                 \\<nl># Description:
                 \\<nl>#
                 \\<nl>#       Munin plugin for Freebox bandwith
                 \\<nl>#       bug: perl doenst work in debian 11 munin 2.0.67
                 \\<nl>#
                 \\<nl># Copyright: (C) 2024 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>import os
                 \\<nl>import sys
                 \\<nl>import json
                 \\<nl>
                 \\<nl>if len(sys.argv) > 1:
                 \\<nl>    if sys.argv[1] == \\"config\\":
                 \\<nl>        print('''graph_title Bandwith Freebox
                 \\<nl>graph_vlabel Mbps
                 \\<nl>graph_args --base 1024
                 \\<nl>graph_category sensors
                 \\<nl>up.type GAUGE
                 \\<nl>up.min 0
                 \\<nl>up.max 9000
                 \\<nl>up.label UP
                 \\<nl>dl.type GAUGE
                 \\<nl>dl.min 0
                 \\<nl>dl.max 9000
                 \\<nl>dl.label DL''')
                 \\<nl>    sys.exit(0)
                 \\<nl>
                 \\<nl>spt = json.load(os.popen('speedtest -f json'))
                 \\<nl>
                 \\<nl>up = spt[\\"upload\\"][\\"bandwidth\\"] * 8 / 1024 / 1024
                 \\<nl>dl = spt[\\"download\\"][\\"bandwidth\\"] * 8 / 1024 / 1024
                 \\<nl>
                 \\<nl>print(\\"up.value\\", up)
                 \\<nl>print(\\"dl.value\\", dl)
                 \\<nl>
                 \\"

            "## template.sh #########################################
            catch /^sh$/
               0put = \"
                      \#! /usr/bin/env bash
                 \\<nl>#
                 \\<nl># Filename: template.sh
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%d %B %Y\\")}
                 \\<nl># Last Modified: Sunday 24 March 2024, 16:08
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl># Edit Time: 0:00:03
                 \\<nl># Description:
                 \\<nl>#
                 \\<nl># Copyright: (C) 2024 Olivier Sirol <czo@free.fr>
                 \\<nl>
                 \\<nl>if [ $(id -u) -ne 0 ]; then
                 \\<nl>    echo \\"ERROR: this script must be run as root\\"
                 \\<nl>    exit 1
                 \\<nl>fi
                 \\<nl>
                 \\<nl>if [ \\"$#\\" -ne 1 ]; then
                 \\<nl>    echo \\"ERROR : please specify a device, e.g.: /dev/sdb\\"
                 \\<nl>    echo \\"Usage : $0 device\\"
                 \\<nl>    exit 1
                 \\<nl>fi
                 \\<nl>
                 \\<nl>export LC_ALL=C
                 \\<nl>
                 \\<nl>echo \\"BlaBla...\\"
                 \\"

            catch /.*/
        endtry
    endif
    " ------------- SearchThisThenDelete -------------

    exec ':0'
    call TemplateMacro ()
    call TemplateGetTime ()
    call TemplateTimeStamp ()
endfunction

function! TemplateNewFile (...)
    call call(function("TemplateCzo"), a:000)
    " to save all buffer with are not modofied do a
    " :tabdo saveas %
    " or a
    " :tabdo set modified
    " then
    " :xa
endfunction

function! Template (...)
    call call(function("TemplateCzo"), a:000)
    set modified
endfunction

endif
" end template.vim

" == commentary.vim ====================================================

if exists("g:loaded_commentary") || v:version < 700
    finish
else

    " https://github.com/tpope/vim-commentary/blob/master/plugin/commentary.vim
    " commentary.vim - Comment stuff out
    " Maintainer:   Tim Pope <http://tpo.pe/>
    " Version:      1.3
    " 2015-06-18: Modified by Olivier Sirol <czo@free.fr>
    " 2024-03-24:
    " version is stil 1.3, but has changed...
    " seems to work on >= 703
    " s: script local remplaced by s:commentary_

    let g:loaded_commentary = 1

    function! s:commentary_surroundings() abort
        return split(get(b:, 'commentary_format', substitute(substitute(substitute(
                    \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
    endfunction

    function! s:commentary_strip_white_space(l,r,line) abort
        let [l, r] = [a:l, a:r]
        if l[-1:] ==# ' ' && stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0
            let l = l[:-2]
        endif
        if r[0] ==# ' ' && (' ' . a:line)[-strlen(r)-1:] != r && a:line[-strlen(r):] == r[1:]
            let r = r[1:]
        endif
        return [l, r]
    endfunction

    function! s:commentary_go(...) abort
        if !a:0
            let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
            return 'g@'
        elseif a:0 > 1
            let [lnum1, lnum2] = [a:1, a:2]
        else
            let [lnum1, lnum2] = [line("'["), line("']")]
        endif

        let [l, r] = s:commentary_surroundings()
        let uncomment = 2
        let force_uncomment = a:0 > 2 && a:3
        for lnum in range(lnum1,lnum2)
            let line = matchstr(getline(lnum),'\S.*\s\@<!')
            let [l, r] = s:commentary_strip_white_space(l,r,line)
            if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
                let uncomment = 0
            endif
        endfor

        if get(b:, 'commentary_startofline')
            let indent = '^'
        else
            let indent = '^\s*'
        endif

        let lines = []
        for lnum in range(lnum1,lnum2)
            let line = getline(lnum)
            if strlen(r) > 2 && l.r !~# '\\'
                let line = substitute(line,
                            \'\M' . substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '') . '\|' . substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''),
                            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
            endif
            if force_uncomment
                if line =~ '^\s*' . l
                    let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
                endif
            elseif uncomment
                let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
            else
                let line = substitute(line,'^\%('.matchstr(getline(lnum1),indent).'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
            endif
            call add(lines, line)
        endfor
        call setline(lnum1, lines)
        let modelines = &modelines
        try
            set modelines=0
            silent doautocmd User CommentaryPost
        finally
            let &modelines = modelines
        endtry
        return ''
    endfunction

    function! s:commentary_textobject(inner) abort
        let [l, r] = s:commentary_surroundings()
        let lnums = [line('.')+1, line('.')-2]
        for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
            while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
                let lnums[index] += dir
                let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
                let [l, r] = s:commentary_strip_white_space(l,r,line)
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

    command! -range -bar -bang Commentary call s:commentary_go(<line1>,<line2>,<bang>0)

    " xnoremap <expr>   <Plug>Commentary     <SID>go()
    " nnoremap <expr>   <Plug>Commentary     <SID>go()
    " nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
    " onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
    " nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
    " nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

    " if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
    "     xmap gc  <Plug>Commentary
    "     nmap gc  <Plug>Commentary
    "     omap gc  <Plug>Commentary
    "     nmap gcc <Plug>CommentaryLine
    "     nmap gcu <Plug>Commentary<Plug>Commentary
    " endif

    " remove or add a comment with any key near backspace and right shift
    " 'C-_' or 'Ctrl-Shift-/' (French kbd) or 'Ctrl-Shift-=' (US kbd)
    map  <C-_>      :Commentary<CR>
    imap <C-_>      <C-O>:Commentary<CR>

endif
" end commentary.vim


" == Plugins ===========================================================

" Don't load Plugins if version < 703
if version < 703
  finish
else

  " if 1: Reload .vimrc and :PlugInstall to install plugins.
  if 0
    " Install vim-plug if not found
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    call plug#begin('~/.vim/pack/vendor/start')
    Plug 'vim-scripts/colorizer'
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/gruvbox-material'
    Plug 'Yggdroot/indentLine'
    Plug 'sbdchd/neoformat'
    Plug 'preservim/nerdtree'
    Plug 'godlygeek/tabular'
    Plug 'kevinoid/vim-jsonc'
    call plug#end()
  endif

  "" Neoformat options
  " On debian 12:
  " aptitude install perltidy clang-format python3-autopep8 shfmt php-pear
  " npm install -g prettier
  " pear install PHP_CodeSniffer
  "
  " perl in config ~/.perltidyrc
  let g:neoformat_perl_perltidy = {
        \ 'exe': 'perltidy',
        \ 'args': ['-q', '-ce', '-l=0', '-st'],
        \ 'stdin': 1,
        \ }
  " sh: shfmt
  let g:shfmt_opt="-i 4 -ci"
  " python3: config in ~/.pep8
  " php: config in ~/.phpcs.xml
  " html/css/js/ts/json: prettier config in ~/.prettierrc
  " C/C++/java: config in ~/.clang-format

endif
" end Plugins

