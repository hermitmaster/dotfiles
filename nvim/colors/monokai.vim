set background=dark

hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "monokai"

let s:palette = [
      \ '#272822',
      \ '#f92672',
      \ '#a6e22e',
      \ '#e6db74',
      \ '#66d9ef',
      \ '#ae81ff',
      \ '#a1efe4',
      \ '#f8f8f2',
      \ '#75715e',
      \ '#fd971f',
      \ '#383830',
      \ '#49483e',
      \ '#a59f85',
      \ '#f5f4f1',
      \ '#cc6633',
      \ '#f9f8f5'
      \ ]

hi ColorColumn                ctermfg=NONE ctermbg=10   guifg=NONE      guibg='#383830' cterm=NONE          gui=NONE
hi Comment                    ctermfg=8    ctermbg=NONE guifg='#75715e' guibg=NONE      cterm=italic        gui=italic
hi Constant                   ctermfg=5    ctermbg=NONE guifg='#ae81ff' guibg=NONE      cterm=NONE          gui=NONE
hi Delimiter                  ctermfg=12   ctermbg=NONE guifg='#a59f85' guibg=NONE      cterm=NONE          gui=NONE
hi DiffAdd                    ctermfg=2    ctermbg=NONE guifg='#a6e22e' guibg=NONE      cterm=NONE          gui=NONE
hi DiffChange                 ctermfg=6    ctermbg=NONE guifg='#a1efe4' guibg=NONE      cterm=NONE          gui=NONE
hi DiffDelete                 ctermfg=1    ctermbg=NONE guifg='#f92672' guibg=NONE      cterm=NONE          gui=NONE
hi DiffText                   ctermfg=3    ctermbg=NONE guifg='#e6db74' guibg=NONE      cterm=NONE          gui=NONE
hi Directory                  ctermfg=4    ctermbg=NONE guifg='#66d9ef' guibg=NONE      cterm=NONE          gui=NONE
hi Error                      ctermfg=15   ctermbg=1    guifg='#f9f8f5' guibg='#f92672' cterm=NONE          gui=NONE
hi Folded                     ctermfg=8    ctermbg=NONE guifg='#75715e' guibg=NONE      cterm=italic        gui=italic
hi Function                   ctermfg=2    ctermbg=NONE guifg='#a6e22e' guibg=NONE      cterm=NONE          gui=NONE
hi Identifier                 ctermfg=6    ctermbg=NONE guifg='#a1efe4' guibg=NONE      cterm=italic        gui=italic
hi Keyword                    ctermfg=1    ctermbg=NONE guifg='#f92672' guibg=NONE      cterm=NONE          gui=NONE
hi LineNr                     ctermfg=8    ctermbg=NONE guifg='#75715e' guibg=NONE      cterm=NONE          gui=NONE
hi MatchParen                 ctermfg=5    ctermbg=NONE guifg='#ae81ff' guibg=NONE      cterm=bold          gui=bold
hi ModeMsg                    ctermfg=3    ctermbg=NONE guifg='#e6db74' guibg=NONE      cterm=NONE          gui=NONE
hi NonText                    ctermfg=11   ctermbg=NONE guifg='#49483e' guibg=NONE      cterm=NONE          gui=NONE
hi Normal                     ctermfg=15   ctermbg=NONE guifg='#f9f8f5' guibg=NONE      cterm=NONE          gui=NONE
hi Question                   ctermfg=11   ctermbg=NONE guifg='#49483e' guibg=NONE      cterm=bold          gui=bold
hi Pmenu                      ctermfg=15   ctermbg=11   guifg='#f9f8f5' guibg='#49483e' cterm=NONE          gui=NONE
hi PmenuSBar                  ctermfg=NONE ctermbg=0    guifg=NONE      guibg='#272822' cterm=NONE          gui=NONE
hi PmenuSel                   ctermfg=11   ctermbg=7    guifg='#49483e' guibg='#f8f8f2' cterm=bold          gui=bold
hi PreProc                    ctermfg=6    ctermbg=NONE guifg='#a1efe4' guibg=NONE      cterm=NONE          gui=none
hi Search                     ctermfg=NONE ctermbg=11   guifg=NONE      guibg='#49483e' cterm=bold          gui=bold
hi Special                    ctermfg=9    ctermbg=NONE guifg='#fd971f' guibg=NONE      cterm=NONE          gui=NONE
hi SpecialComment             ctermfg=8    ctermbg=NONE guifg='#75715e' guibg=NONE      cterm=bold,italic   gui=bold,italic
hi Statement                  ctermfg=1    ctermbg=NONE guifg='#f92672' guibg=NONE      cterm=NONE          gui=NONE
hi StatusLine                 ctermfg=15   ctermbg=10   guifg='#f9f8f5' guibg='#383830' cterm=bold          gui=bold
hi StatusLineNC               ctermfg=8    ctermbg=10   guifg='#75715e' guibg='#383830' cterm=NONE          gui=NONE
hi StorageClass               ctermfg=6    ctermbg=NONE guifg='#a1efe4' guibg=NONE      cterm=italic        gui=italic
hi String                     ctermfg=3    ctermbg=NONE guifg='#e6db74' guibg=NONE      cterm=NONE          gui=NONE
hi Structure                  ctermfg=6    ctermbg=NONE guifg='#a1efe4' guibg=NONE      cterm=NONE          gui=NONE
hi TabLineFill                ctermfg=8    ctermbg=10   guifg='#75715e' guibg='#383830' cterm=NONE          gui=NONE
hi TablineSel                 ctermfg=7    ctermbg=8    guifg='#f8f8f2' guibg='#75715e' cterm=NONE          gui=NONE
hi Title                      ctermfg=2    ctermbg=NONE guifg='#a6e22e' guibg=NONE      cterm=bold          gui=bold
hi Type                       ctermfg=1    ctermbg=NONE guifg='#f92672' guibg=NONE      cterm=italic        gui=italic
hi Underlined                 ctermfg=NONE ctermbg=NONE guifg=NONE      guibg=NONE      cterm=underline     gui=underline
hi VertSplit                  ctermfg=10   ctermbg=NONE guifg='#383830' guibg=NONE      cterm=NONE          gui=NONE
hi Visual                     ctermfg=NONE ctermbg=11   guifg=NONE      guibg='#49483e' cterm=NONE          gui=NONE
hi WarningMsg                 ctermfg=9    ctermbg=NONE guifg='#fd971f' guibg=NONE      cterm=NONE          gui=NONE
hi WildMenu                   ctermfg=4    ctermbg=NONE guifg='#66d9ef' guibg=NONE      cterm=bold          gui=bold

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

