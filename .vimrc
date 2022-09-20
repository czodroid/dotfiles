"             ,,,
"            (o o)
"###=====oOO--(_)--OOO===============================================##"
"
" Filename: .vimrc
" Author: Olivier Sirol <czo@free.fr>
" License: GPL-2.0 (http://www.gnu.org/copyleft)
" File Created: mai 1995
" Last Modified: dimanche 18 septembre 2022, 17:17
" Edit Time: 211:35:44
" Description:
"              my vim config file
"              self contained, no .gvimrc, nothing in .vim
"
" $Id: .vimrc,v 1.331 2022/09/18 16:11:27 czo Exp $

if version >= 505

" == Options ===========================================================

" works in gnome-shell, kde, xfce, xterm, iTerm, mintty but not on apple
" terminal which has no 24-bit colors
if version >= 800 && has("termguicolors") && $TERM_PROGRAM !~ 'Apple_Terminal'
    set termguicolors
else
    if has('nvim') && has("termguicolors")
        set termguicolors
    endif
    set t_Co=16
endif

" for non working terminal colors, just set this:
"set t_Co=16

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

set history=2000
set viminfo='100,\"1000,ra:,rb:,rz:,%

" don't write on my embedded toy
if $PLATFORM == "Linux_mips"
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
set whichwrap=<,>,[,]


set expandtab
set smarttab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround

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
    set tabpagemax=20
endif


if !has('nvim')
    set ttymouse=xterm2
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
    if &term =~ '^xterm'
        if version > 604
            " color: \e]12;#b8bb26\x7
            " NORMAL mode
            let &t_EI .= "\e[ q"
            " INSERT mode
            let &t_SI .= "\e[5 q"
        endif
        if version > 704
            let &t_SR .= "\e[3 q"
        endif
    endif
endif

" vt100
if &term =~ '^vt100'
    execute "set <S-Up>=\e[1;2A"
    execute "set <S-Down>=\e[1;2B"
    execute "set <S-Right>=\e[1;2C"
    execute "set <S-Left>=\e[1;2D"
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

" tags search path
set tags=./tags,tags,/users/soft5/newlabo/cvstree/alliance/sources/tags
"set errorformat=%f:%l:\ %m,In\ file\ included\ from\ %f:%l:,\^I\^Ifrom\ %f:%l%m

" dictionary completion: (Ctrl-X Ctrl-k)
set dictionary=/usr/dict/words,/users/soft5/newlabo/cvstree/alliance/sources/tags



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

" pos on the last edit line
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

if version > 601
    " vim diff with wrap
    autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
endif

if version > 604
    " cursorline when in insert mode
    autocmd InsertEnter * set cul
    autocmd InsertLeave * set nocul
endif

" reset cursor when vim exits
"autocmd VimLeave * silent !echo -n "\033]112\007"

autocmd BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufNewFile,BufRead *.h   set filetype=c
autocmd BufNewFile,BufRead *.h++ set filetype=cpp
autocmd Filetype json      let g:indentLine_setConceal = 0 | let g:vim_json_syntax_conceal = 0
autocmd FileType perl      setlocal equalprg=perltidy\ -ce\ -l=0\ -st
autocmd FileType xdefaults setlocal commentstring=!\ %s
autocmd FileType json      setlocal commentstring=//\ %s
autocmd FileType cpp       setlocal commentstring=//\ %s
autocmd FileType php       setlocal commentstring=//\ %s
autocmd FileType cfg       setlocal commentstring=#\ %s
autocmd FileType apache    setlocal commentstring=#\ %s

endif


" == ABbreviations =====================================================

" insert the current filename:
iab _n    <C-R>=expand("%:t:r")<cr>
iab _e    <C-R>=expand("%:e")<cr>
iab _fn   <C-R>=expand("%:t")<cr>
iab _ffn  <C-R>=expand("%:p")<cr>

iab _home <C-R>=$HOME<cr>
iab _vim  <C-R>=$VIMRUNTIME<cr>
iab _date <C-R>=strftime("%Y-%m-%d")<cr>
iab _ma # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@asim.lip6.fr>
iab _mc # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@free.fr>
iab _mi # <C-R>=strftime("%Y-%m-%d")<cr> : Modified by Olivier Sirol <czo@ipgp.fr>

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


" == Command ===========================================================

command!  CzoEditorTabToSpaceAndTrailWhite call CzoEditorTabToSpaceAndTrailWhite ()
function! CzoEditorTabToSpaceAndTrailWhite ()
    echom "Convert Tab to Space"
    execute '%s/\t/    /gce'
    echom "Trim Trailing Whitespace"
    execute '%s/\s\+$//ce'
endfunction

command!  CzoTabToSpaces call CzoTabToSpaces ()
function! CzoTabToSpaces ()
    execute '%s/\t/    /gce'
endfunction

command!  CzoTrimTrailingWhitespace call CzoTrimTrailingWhitespace ()
function! CzoTrimTrailingWhitespace ()
    " execute '%s/\s\+$//en'
    " execute '%s/\s\+$//e'
    execute '%s/\s\+$//ce'
 endfunction

command!  CzoRemoveEmptyLinesAndComment call CzoRemoveEmptyLinesAndComment ()
function! CzoRemoveEmptyLinesAndComment ()
    " execute 'g/^\s*#/d'
    " execute 'g/^\s*$/d'
    execute 'g/\(^\s*#\)\|\(^\s*$\)/d'
endfunction

command!  CzoInvList call CzoInvList ()
function! CzoInvList ()
    execute 'set invlist'
 endfunction

command!  CzoInvWrap call CzoInvWrap ()
function! CzoInvWrap ()
    execute 'set invwrap'
 endfunction

command!  CzoInvPaste call CzoInvPaste ()
function! CzoInvPaste ()
    execute 'set invpaste'
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
    hi Search        guifg=#503825 guibg=#3c3836 gui=inverse   ctermfg=Yellow     ctermbg=Black    cterm=inverse   term=inverse
    hi IncSearch     guifg=#596B63 guibg=#3c3836 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
endfunction

command!  CzoMSwinEnable call CzoMSwinEnable ()
function! CzoMSwinEnable ()
    if filereadable(expand("$VIMRUNTIME/mswin.vim"))
        so $VIMRUNTIME/mswin.vim
    endif
endfunction

command!  CzoMSwinDisable call CzoMSwinDisable ()
function! CzoMSwinDisable ()
    if !has("unix")
        set guioptions+=a
    endif
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

if has('clipboard')
    call CzoMSwinEnable()
else
    "Please install vim-athena/vim-gtk (debian) or vim-X11 (redhat)
    echoe "NO SYSTEM CLIPBOARD: n/vim is compiled without clipboard or works without X11!!!"
    call CzoMSwinDisable()
endif

" always use Ctrl-Q instead of Ctrl-V
noremap <C-Q> <C-V>

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

"goto diff
nmap <M-Down> ]c
imap <M-Down> <C-O>]c
map  <M-Up> [c
imap <M-Up> <C-O>[c

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

if version >= 600
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
endif

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

  " 2021/10/03 : macvim
  let g:colors_name = "gruvbox64"

" gruvbox64.vim
" Description: Retro groove color scheme for Vim
"     gruvbox64 colors, inspired by gruvbox style, without bold
"     works with xterm-256color with 'set termguicolors' in vim
"     works with xterm 8c / 16c with nearly similar colors

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
hi Search        guifg=#503825 guibg=#3c3836 gui=inverse   ctermfg=Yellow     ctermbg=Black    cterm=inverse   term=inverse
hi IncSearch     guifg=#596B63 guibg=#3c3836 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
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
\                           '#282828',
\                           '#cc241d',
\                           '#98971a',
\                           '#fe8019',
\                           '#458588',
\                           '#b16286',
\                           '#689d6a',
\                           '#c9b788',
\                           '#4a4239',
\                           '#fb4934',
\                           '#b8bb26',
\                           '#fabd2f',
\                           '#83a598',
\                           '#d3869b',
\                           '#8ec07c',
\                           '#fbf1c7'
\                                     ]
endif
endif

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
let TemplateLicense="GPL-2.0 (http:\\/\\/www.gnu.org\\/copyleft)"
"let TemplateLicense="GPL-2.0"

command! -nargs=? Template call Template (<q-args>)
command! TemplateMacro call TemplateMacro ()
command! TemplateTimeStamp call TemplateTimeStamp ()

autocmd BufNewFile * call TemplateNewFile ("")
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

        " This is the third time I did modified my headers
        " Filename: .vimrc
        " Copyright (C) 1995 Olivier Sirol
        " License: GPL-2.0 (http://www.gnu.org/copyleft)
        " Author: Olivier Sirol <czo@free.fr>
        " File Created: mai 1995
        " Last Modified: jeudi 06 mai 2021, 19:55
        " Edit Time: 188:01:29
        " Description:
        "
        " $Id: .vimrc,v 1.331 2022/09/18 16:11:27 czo Exp $
        "
        if 1
            " modif Started: in File Created:
            let pattern = '\(^.\=.\=.\=\s*\)Started:\(.*\)'
            if FindStrInHeader(pattern)
                exec 's/'.pattern.'/\1File Created:\2/e'
            endif
            " modif Started: in File Created:
            let pattern = '\(^.\=.\=.\=\s*\)Created:\(.*\)'
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
    "    let mytemplatefile = expand("$HOME/etc/vim/templates/template\." . xft)
    "    if filereadable(mytemplatefile)
    "        normal 1G
    "        execute ":r " . mytemplatefile
    "        1d
    "    endif
    "
    " run this:
    " :r !cd ~/etc/vim/templates ; ./template
    " after delting this
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
                 \\<nl> * File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl> * Last Modified: Wednesday 15 December 2021, 20:11
                 \\<nl> * Edit Time: 0:00:49
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
                 \\<nl>// File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>// Last Modified: Wednesday 15 December 2021, 20:12
                 \\<nl>// Edit Time: 0:01:02
                 \\<nl>// Description:
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

            "## template.css #########################################
            catch /^css$/
               0put = \"
                      \/*
                 \\<nl> * Filename: template.css
                 \\<nl> * Author: Olivier Sirol <czo@free.fr>
                 \\<nl> * License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl> * File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl> * Last Modified: Wednesday 15 December 2021, 20:12
                 \\<nl> * Edit Time: 0:01:19
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * $VIMEX{=strftime(\\"Id:$\\")}
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
                 \\<nl> * File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl> * Last Modified: Wednesday 15 December 2021, 20:12
                 \\<nl> * Edit Time: 0:01:27
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
                 \\<nl>#endif
                 \\"

            "## template.hpp #########################################
            catch /^hpp$/
               0put = \"
                      \// Filename: template.hpp
                 \\<nl>// Author: Olivier Sirol <czo@free.fr>
                 \\<nl>// License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>// File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>// Last Modified: Saturday 13 November 2021, 18:16
                 \\<nl>// Edit Time: 0:00:01
                 \\<nl>// Description:
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
                 \\<nl>Filename: template.html
                 \\<nl>Author: Olivier Sirol <czo@free.fr>
                 \\<nl>License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>Last Modified: Saturday 13 November 2021, 18:16
                 \\<nl>Edit Time: 0:00:01
                 \\<nl>$VIMEX{=strftime(\\"Id:$\\")}
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
                 \\<nl>// File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>// Last Modified: Wednesday 15 December 2021, 20:12
                 \\<nl>// Edit Time: 0:01:55
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
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
                 \\<nl> * File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl> * Last Modified: Wednesday 15 December 2021, 20:13
                 \\<nl> * Edit Time: 0:02:08
                 \\<nl> * Description:
                 \\<nl> *
                 \\<nl> * $VIMEX{=strftime(\\"Id:$\\")}
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

            "## template.make #########################################
            catch /^make$/
               0put = \"
                      \# Filename: template.make
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl># Last Modified: Wednesday 15 December 2021, 20:13
                 \\<nl># Edit Time: 0:02:20
                 \\<nl># Description:
                 \\<nl>#      Makefile:
                 \\<nl>#      $@ Le nom de la cible
                 \\<nl>#      $< Le nom de la première dépendance
                 \\<nl>#      $^ La liste des dépendances
                 \\<nl>#      $? La liste des dépendances plus récentes que la cible
                 \\<nl>#      $* Le nom du fichier sans suffixe
                 \\<nl>#
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
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
                 \\"

            "## template.markdown #########################################
            catch /^markdown$/
               0put = \"
                      \<!--
                 \\<nl>Filename: template.markdown
                 \\<nl>Author: Olivier Sirol <czo@free.fr>
                 \\<nl>License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl>File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>Last Modified: mercredi 27 avril 2022, 19:55
                 \\<nl>Edit Time: 0:00:07
                 \\<nl>$VIMEX{=strftime(\\"Id:$\\")}
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
                 \\<nl># File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl># Last Modified: samedi 12 février 2022, 11:23
                 \\<nl># Edit Time: 0:00:09
                 \\<nl># Description:
                 \\<nl>#
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>
                 \\<nl>#use strict;
                 \\<nl>#use warnings;
                 \\<nl>
                 \\<nl>foreach (qx(zpool status)) {
                 \\<nl>    if (m,^\\s*pool:\\s+(.*),) { $pool = $1; }
                 \\<nl>    if (m,^\\s*scan:\\s+(.*),) { $scan = $1; $ok = 1; }
                 \\<nl>    if ($ok) {
                 \\<nl>        $ok = 0;
                 \\<nl>        if ( $scan =~ 'scrub in progress\|resilver' ) {
                 \\<nl>            $poollist{$pool} = 90;
                 \\<nl>        } else {
                 \\<nl>            $poollist{$pool} = 10;
                 \\<nl>        }
                 \\<nl>    }
                 \\<nl>}
                 \\<nl>
                 \\<nl>if ( $ARGV[0] and $ARGV[0] eq \\"config\\" ) {
                 \\<nl>    print <<EOT;
                 \\<nl>graph_title scrub/resilver zpool
                 \\<nl>graph_vlabel in scrub/rslv at 90
                 \\<nl>graph_category ZFS
                 \\<nl>graph_args --base 1000 --lower-limit 0 --upper-limit 100 --rigid
                 \\<nl>graph_info This graph shows the pool scrub.
                 \\<nl>EOT
                 \\<nl>
                 \\<nl>    foreach $d ( sort keys %poollist ) {
                 \\<nl>        print \\"$d.label $d\\n\\";
                 \\<nl>        print \\"$d.warning 2:20\\n\\";
                 \\<nl>        print \\"$d.critical 1:99\\n\\";
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
                 \\<nl>// File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl>// Last Modified: Saturday 13 November 2021, 18:17
                 \\<nl>// Edit Time: 0:00:01
                 \\<nl>// Description:
                 \\<nl>//
                 \\<nl>// $VIMEX{=strftime(\\"Id:$\\")}
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
                 \\<nl># File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl># Last Modified: samedi 12 février 2022, 11:31
                 \\<nl># Edit Time: 0:00:16
                 \\<nl># Description:
                 \\<nl>#
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>
                 \\<nl>import numpy as np
                 \\<nl>import matplotlib.pyplot as plt
                 \\<nl>
                 \\<nl>x = np.linspace(0, 2*np.pi, 30)
                 \\<nl>y = np.cos(x)
                 \\<nl>plt.plot(x, y)
                 \\<nl>
                 \\<nl>plt.show()
                 \\"

            "## template.sh #########################################
            catch /^sh$/
               0put = \"
                      \#! /usr/bin/env sh
                 \\<nl>#
                 \\<nl># Filename: template.sh
                 \\<nl># Author: Olivier Sirol <czo@free.fr>
                 \\<nl># License: GPL-2.0 (http://www.gnu.org/copyleft)
                 \\<nl># File Created: VIMEX{=strftime(\\"%b %Y\\")}
                 \\<nl># Last Modified: samedi 12 février 2022, 11:33
                 \\<nl># Edit Time: 0:00:34
                 \\<nl># Description:
                 \\<nl>#
                 \\<nl># $VIMEX{=strftime(\\"Id:$\\")}
                 \\<nl>
                 \\<nl>if [ \\"$#\\" -ne 1 ]; then
                 \\<nl>    echo \\"ERROR : please specify a message...\\"
                 \\<nl>    echo \\"Usage : $0 'a message text'\\"
                 \\<nl>    exit 42
                 \\<nl>fi
                 \\<nl>
                 \\<nl>(
                 \\<nl>gdbus call --session   \\
                 \\<nl>   --dest org.freedesktop.Notifications \\
                 \\<nl>   --object-path /org/freedesktop/Notifications \\
                 \\<nl>   --method org.freedesktop.Notifications.Notify \\
                 \\<nl>   'notify-send' '42' 'utilities-terminal' 'notify-send!' \\
                 \\<nl>   \\"$1\\" \\
                 \\<nl>   '[]' '{}' '5000'
                 \\<nl>) > /dev/null 2>&1
                 \\"

            catch /.*/
        endtry
    endif

    " ------------- SearchThisThenDelete -------------

    execute ':0'
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
" end template.vim =====================================================

endif
" The end! =============================================================


" ======================================================================
" == Don't load Commentary nor Plugins if version < 700 ================

if version < 700
  finish
else

" ======================================================================
" == commentary.vim ====================================================

" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim
" autocmd FileType apache setlocal commentstring=#\ %s
" 2019/06/18: Modified by Olivier Sirol <czo@free.fr>
" https://github.com/tpope/vim-commentary/blob/master/plugin/commentary.vim

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
" end commentary.vim ===================================================


" ======================================================================
" == Plugins ===========================================================

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
    " Then reload .vimrc and :PlugInstall to install plugins.
  endif
" end Plugins ==========================================================

endif
" The end, really ! ====================================================


