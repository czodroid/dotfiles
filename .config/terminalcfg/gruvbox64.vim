" Filename: gruvbox64.vim
" Author: Olivier Sirol <czo@free.fr>
" License: GPL-2.0 (http://www.gnu.org/copyleft)
" Maintainer: czo <czo@free.fr>
" Website: https://github.com/czo64/vim-gruvbox64/
" File Created: 19 juin 2015
" Last Modified: Thursday 09 October 2025, 20:26
" Edit Time: 5:10:44
" Description:
"
"       Retro color scheme for Vim.
"       The colors in my gruvbox64 theme for Vim are inspired
"       by the gruvbox style but without bold fonts.
"       This works with 'set termguicolors' in .vimrc (if your
"       terminal allows it) or in an xterm 8c / 16c / 256c
"       with nearly similar colors if you use a gruvbox64
"       terminal palette.
"
"       :source gruvbox64.vim
"
" Copyright: (C) 2015-2025 Olivier Sirol <czo@free.fr>

set background=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "gruvbox64"

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
hi TabLineSel    guifg=#ebdbb2 guibg=#282828 gui=NONE      ctermfg=White      ctermbg=Black    cterm=NONE      term=NONE
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

hi DiffAdd       guifg=NONE    guibg=#4f2e2a gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffChange    guifg=NONE    guibg=#4f2e2a gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffDelete    guifg=#753730 guibg=#4f2e2a gui=NONE      ctermfg=Black      ctermbg=DarkGray cterm=NONE      term=NONE
hi DiffText      guifg=NONE    guibg=#753730 gui=NONE      ctermfg=NONE       ctermbg=DarkBlue cterm=NONE      term=NONE

hi diffAdded     guifg=#b8bb26 guibg=NONE    gui=NONE      ctermfg=Green      ctermbg=NONE     cterm=NONE      term=NONE
hi diffRemoved   guifg=#fb4934 guibg=NONE    gui=NONE      ctermfg=Red        ctermbg=NONE     cterm=NONE      term=NONE

hi Visual        guifg=NONE    guibg=#36403c gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi Search        guifg=NONE    guibg=#503825 gui=NONE      ctermfg=NONE       ctermbg=DarkGray cterm=NONE      term=NONE
hi IncSearch     guifg=NONE    guibg=#596b63 gui=NONE      ctermfg=Black      ctermbg=Blue     cterm=NONE      term=NONE

if &t_Co < 16
hi Visual        guifg=#36403c guibg=#ebdbb2 gui=inverse   ctermfg=Gray       ctermbg=Black    cterm=inverse   term=inverse
hi Search        guifg=#503825 guibg=#ebdbb2 gui=inverse   ctermfg=Yellow     ctermbg=Black    cterm=inverse   term=inverse
hi IncSearch     guifg=#596b63 guibg=#ebdbb2 gui=inverse   ctermfg=Blue       ctermbg=Black    cterm=inverse   term=inverse
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
        let g:terminal_ansi_colors = [ '#282828', '#cc241d', '#98971a', '#fe8019', '#458588', '#b16286', '#689d6a', '#c9b788', '#4a4239', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#fbf1c7' ]
    endif
endif

