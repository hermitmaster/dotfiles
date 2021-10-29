set background=dark
set notermguicolors

hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "monokai"

hi ColorColumn                ctermfg=none  ctermbg=10    cterm=none
hi Comment                    ctermfg=8     ctermbg=none  cterm=italic
hi Constant                   ctermfg=5     ctermbg=none  cterm=none
hi Delimiter                  ctermfg=12    ctermbg=none  cterm=none
hi DiffAdd                    ctermfg=2     ctermbg=none  cterm=none
hi DiffChange                 ctermfg=6     ctermbg=none  cterm=none
hi DiffDelete                 ctermfg=1     ctermbg=none  cterm=none
hi DiffText                   ctermfg=3     ctermbg=none  cterm=none
hi Directory                  ctermfg=4     ctermbg=none  cterm=none
hi Error                      ctermfg=15    ctermbg=1     cterm=none
hi Folded                     ctermfg=8     ctermbg=none  cterm=italic
hi Function                   ctermfg=2     ctermbg=none  cterm=none
hi Identifier                 ctermfg=6     ctermbg=none  cterm=italic
hi Keyword                    ctermfg=1     ctermbg=none  cterm=none
hi LineNr                     ctermfg=8     ctermbg=none  cterm=none
hi MatchParen                 ctermfg=5     ctermbg=none  cterm=bold
hi ModeMsg                    ctermfg=3     ctermbg=none  cterm=none
hi NonText                    ctermfg=11    ctermbg=none  cterm=none
hi Normal                     ctermfg=15    ctermbg=none  cterm=none
hi Question                   ctermfg=11    ctermbg=none  cterm=bold
hi Pmenu                      ctermfg=15    ctermbg=11    cterm=none
hi PmenuSBar                  ctermfg=none  ctermbg=0     cterm=none
hi PmenuSel                   ctermfg=11    ctermbg=7     cterm=bold
hi PreProc                    ctermfg=6     ctermbg=none  cterm=none
hi Search                     ctermfg=none  ctermbg=11    cterm=bold
hi Special                    ctermfg=9     ctermbg=none  cterm=none
hi SpecialComment             ctermfg=8     ctermbg=none  cterm=bold,italic
hi Statement                  ctermfg=1     ctermbg=none  cterm=none
hi StatusLine                 ctermfg=15    ctermbg=10    cterm=bold
hi StatusLineNC               ctermfg=8     ctermbg=10    cterm=none
hi StorageClass               ctermfg=6     ctermbg=none  cterm=italic
hi String                     ctermfg=3     ctermbg=none  cterm=none
hi Structure                  ctermfg=6     ctermbg=none  cterm=none
hi TabLineFill                ctermfg=8     ctermbg=10    cterm=none
hi TablineSel                 ctermfg=7     ctermbg=8     cterm=none
hi Title                      ctermfg=2     ctermbg=none  cterm=bold
hi Type                       ctermfg=1     ctermbg=none  cterm=italic
hi Underlined                 ctermfg=none  ctermbg=none  cterm=underline
hi VertSplit                  ctermfg=10    ctermbg=none  cterm=none
hi Visual                     ctermfg=none  ctermbg=11    cterm=none
hi WarningMsg                 ctermfg=9     ctermbg=none  cterm=none
hi WildMenu                   ctermfg=4     ctermbg=none  cterm=bold

hi! link Conceal              NonText
hi! link CursorColumn         ColorColumn
hi! link CursorLine           ColorColumn
hi! link CursorLineNr         Normal
hi! link ErrorMsg             Error
hi! link FoldColumn           LineNr
hi! link IncSearch            Search
hi! link Macro                Special
hi! link MoreMsg              ModeMsg
hi! link Operator             Normal
hi! link PmenuThumb           PmenuSBar
hi! link SignColumn           LineNr
hi! link SpecialKey           NonText
hi! link StringDelimiter      String
hi! link TabLine              TabLineFill
hi! link Todo                 SpecialComment

hi! link helpExample          String
hi! link helpHyperTextEntry   Statement
hi! link helpHyperTextJump    Underlined
hi! link helpURL              Underlined
hi! link lessVariableValue    Normal
hi! link vimCommentTitle      SpecialComment

hi! link StartifyFile         Normal
hi! link StartifySlash        Normal
hi! link StartifyHeader       Constant

