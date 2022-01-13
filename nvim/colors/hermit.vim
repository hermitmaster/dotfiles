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
hi Cursor                                                 cterm=inverse
hi CursorLineNr               ctermfg=3     ctermbg=none
hi Delimiter                  ctermfg=8
hi DiffAdd                    ctermfg=2     ctermbg=none
hi DiffChange                 ctermfg=6     ctermbg=none
hi DiffDelete                 ctermfg=1     ctermbg=none
hi DiffText                   ctermfg=3     ctermbg=none
hi Directory                  ctermfg=4                   cterm=bold
hi EndOfBuffer                ctermfg=0
hi Error                      ctermfg=7     ctermbg=1
hi Folded                     ctermfg=8     ctermbg=none  cterm=italic
hi Function                   ctermfg=2
hi Identifier                 ctermfg=6                   cterm=none
hi LineNr                     ctermfg=8     ctermbg=none
hi MatchParen                 ctermfg=5     ctermbg=none  cterm=bold
hi ModeMsg                    ctermfg=3                   cterm=bold
hi NonText                    ctermfg=237   ctermbg=none
hi Normal                     ctermfg=7
hi Question                   ctermfg=3                   cterm=bold
hi Pmenu                      ctermfg=7     ctermbg=236
hi PmenuSBar                  ctermfg=none  ctermbg=0
hi PmenuSel                   ctermfg=0     ctermbg=7     cterm=bold
hi PreProc                    ctermfg=6
hi Search                     ctermfg=none  ctermbg=237   cterm=bold
hi Special                    ctermfg=202
hi SpecialComment             ctermfg=8     ctermbg=none  cterm=bold,italic
hi SpecialKey                 ctermfg=8
hi SpellBad                   ctermfg=1                   cterm=undercurl
hi SpellCap                   ctermfg=2                   cterm=undercurl
hi SpellLocal                 ctermfg=none
hi SpellRare                  ctermfg=none
hi Statement                  ctermfg=1
hi StatusLine                 ctermfg=7     ctermbg=236   cterm=bold
hi StatusLineNC               ctermfg=8     ctermbg=236   cterm=none
hi String                     ctermfg=3
hi Structure                  ctermfg=6
hi TablineSel                 ctermfg=7    ctermbg=237
hi Title                      ctermfg=2                   cterm=bold
hi Type                       ctermfg=1                   cterm=italic
hi Underlined                                             cterm=underline
hi VertSplit                  ctermfg=236                 cterm=none
hi WarningMsg                 ctermfg=3
hi WildMenu                   ctermfg=4     ctermbg=237   cterm=bold
hi! link lCursor              Cursor
hi! link Conceal              NonText
hi! link CursorColumn         ColorColumn
hi! link CursorLine           ColorColumn
hi! link ErrorMsg             Error
hi! link FoldColumn           LineNr
hi! link Ignore               NonText
hi! link IncSearch            Search
hi! link Keyword              Type
hi! link Macro                Special
hi! link MoreMsg              ModeMsg
hi! link Operator             Normal
hi! link PmenuThumb           PmenuSBar
hi! link SignColumn           LineNr
hi! link StorageClass         Special
hi! link TabLine              StatusLine
hi! link TabLineFill          StatusLine
hi! link Todo                 SpecialComment
hi! link Visual               Cursor

" }}}
" Filetype: {{{

hi htmlTag                    ctermfg=4
hi htmlArg                    ctermfg=3
hi htmlScriptTag              ctermfg=1
hi javaVarArg                 ctermfg=2
hi! link DiagnosticError      Error
hi! link diffLine             Constant
hi! link helpExample          String
hi! link helpHyperTextEntry   Statement
hi! link helpHyperTextJump    Underlined
hi! link helpURL              Underlined
hi! link htmlEndTag           htmlTag
hi! link htmlTagN             htmlTag
hi! link htmlTagName          htmlTag
hi! link javaDocTags          Identifier
hi! link javaScriptBraces     Delimiter
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

" " }}}
" " Coc: {{{
" hi! link CocErrorSign         DiagnosticError
" hi! link CocWarningSign       DiagnosticWarn
" hi! link CocInfoSign          DiagnosticInfo
" hi! link CocHintSign          DiagnosticHint

" }}}
" Startify: {{{

hi! link StartifyFile Normal
hi! link StartifySlash Normal

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker :
