" Theme Config: {{{

set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "hermit"

" }}}
" Core: {{{

hi ColorColumn                              ctermbg=236   cterm=none
hi Comment                    ctermfg=8                   cterm=italic
hi Constant                   ctermfg=5
hi Delimiter                  ctermfg=8
hi DiffAdd                    ctermfg=2     ctermbg=none
hi DiffChange                 ctermfg=6     ctermbg=none
hi DiffDelete                 ctermfg=1     ctermbg=none
hi DiffText                   ctermfg=3     ctermbg=none
hi Directory                  ctermfg=4
hi EndOfBuffer                ctermfg=none
hi Error                      ctermfg=7     ctermbg=1
hi ErrorMsg                   ctermfg=1     ctermbg=none
hi Exception                  ctermfg=202
hi Function                   ctermfg=2
hi Identifier                 ctermfg=6                   cterm=italic
hi Keyword                    ctermfg=1                   cterm=italic
hi LineNr                     ctermfg=8     ctermbg=none
hi MatchParen                 ctermfg=5     ctermbg=none  cterm=bold,underline
hi MoreMsg                    ctermfg=3                   cterm=bold
hi NonText                    ctermfg=238   ctermbg=none
hi Normal                     ctermfg=7
hi Pmenu                      ctermfg=7     ctermbg=236
hi PmenuSBar                  ctermfg=none  ctermbg=0
hi PmenuSel                   ctermfg=236   ctermbg=202   cterm=bold
hi PreProc                    ctermfg=6
hi Question                   ctermfg=3                   cterm=bold
hi Search                     ctermfg=none  ctermbg=236   cterm=bold
hi Special                    ctermfg=202
hi SpecialComment             ctermfg=8     ctermbg=none  cterm=bold,italic
hi SpellBad                   ctermfg=1                   cterm=undercurl
hi SpellCap                   ctermfg=10                  cterm=undercurl
hi SpellLocal                 ctermfg=none
hi SpellRare                  ctermfg=none
hi Statement                  ctermfg=1
hi StatusLine                 ctermfg=7     ctermbg=236   cterm=bold
hi StatusLineNC               ctermfg=8     ctermbg=236   cterm=none
hi String                     ctermfg=3
hi TabLineFill                ctermfg=8     ctermbg=none  cterm=none
hi TablineSel                 ctermfg=7     ctermbg=236   cterm=bold,italic
hi Title                      ctermfg=2                   cterm=bold
hi Underlined                                             cterm=underline
hi User1                      ctermfg=1     ctermbg=238   cterm=bold
hi User2                      ctermfg=2     ctermbg=238   cterm=bold
hi User3                      ctermfg=3     ctermbg=238   cterm=bold
hi User4                      ctermfg=4     ctermbg=238   cterm=bold
hi User5                      ctermfg=5     ctermbg=238   cterm=bold
hi User6                      ctermfg=6     ctermbg=238   cterm=bold
hi User7                      ctermfg=7     ctermbg=238   cterm=bold
hi User8                      ctermfg=7     ctermbg=none  cterm=none
hi User9                      ctermfg=8     ctermbg=238   cterm=none
hi VertSplit                  ctermfg=238                 cterm=none
hi Visual                                   ctermbg=238
hi WarningMsg                 ctermfg=202
hi WildMenu                   ctermfg=4     ctermbg=236   cterm=bold
hi! link Conceal              NonText
hi! link CursorColumn         ColorColumn
hi! link CursorLine           ColorColumn
hi! link CursorLineNr         Normal
hi! link Folded               SpecialComment
hi! link FoldColumn           LineNr
hi! link IncSearch            Search
hi! link Operator             Normal
hi! link PmenuThumb           PmenuSBar
hi! link SignColumn           LineNr
hi! link SpecialKey           Whitespace
hi! link TabLine              TabLineFill
hi! link Todo                 SpecialComment
hi! link Type                 Keyword

" }}}
" Filetype: {{{

hi htmlTag                    ctermfg=4
hi htmlArg                    ctermfg=3
hi htmlScriptTag              ctermfg=1
hi! link diffAdded            DiffAdd
hi! link diffLine             Constant
hi! link diffRemoved          DiffDelete
hi! link helpExample          String
hi! link helpHyperTextEntry   Statement
hi! link helpHyperTextJump    Underlined
hi! link helpURL              Underlined
hi! link htmlEndTag           htmlTag
hi! link htmlTagN             htmlTag
hi! link htmlTagName          htmlTag
hi! link jsonQuote            String
hi! link lessVariableValue    Normal
hi! link makeCommands         Normal
hi! link vimCommentTitle      SpecialComment
hi! link vimBracket           Function
hi! link vimMapModKey         vimBracket
hi! link vimNotation          vimBracket
hi! link xmlTag               htmlTag
hi! link xmlTagName           htmlTagName
hi! link xmlEndTag            xmlTag

" }}}
" Startify: {{{

hi! link StartifyFile         Normal
hi! link StartifySpecial      Comment

" }}}

