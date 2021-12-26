" Core: {{{
set background=dark

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = "monokai"

" }}}
" Palette: {{{
let s:none           = ['NONE', 'NONE']
let s:black          = ['#272822', 0]
let s:red            = ['#f92672', 1]
let s:green          = ['#a6e22e', 2]
let s:yellow         = ['#e6db74', 3]
let s:blue           = ['#66d9ef', 4]
let s:magenta        = ['#ae81ff', 5]
let s:cyan           = ['#a1efe4', 6]
let s:white          = ['#f8f8f2', 7]
let s:gray           = ['#75715e', 8]
let s:orange         = ['#fd971f', 9]
let s:gray1          = ['#383830', 10]
let s:gray2          = ['#49483e', 11]
let s:gray3          = ['#a59f85', 12]
let s:gray4          = ['#f5f4f1', 13]
let s:bright_orange  = ['#cc6633', 14]
let s:bright_white   = ['#f9f8f5', 15]

" }}}
" Emphasis" {{{
let s:bold = 'bold,'
let s:italic = 'italic,'
let s:underline = 'underline,'
let s:undercurl = 'undercurl,'
let s:inverse = 'inverse,'
" }}}
" Highlight Function: {{{
function! s:HL(gn, fg, ...)
  " Arguments: gn, fg, bg, em, sp
  let l:bg = get(a:, 1, s:none)
  let l:em = get(a:, 2, 'NONE,')

  exe 'hi '.a:gn.' guifg='.a:fg[0].' guibg='.l:bg[0].' gui='.l:em[:-2]
        \ .' ctermfg='.a:fg[1].' ctermbg='.l:bg[1].' cterm='.l:em[:-2]
endfunction

" }}}
" UI: {{{
call s:HL('ColorColumn', s:none, s:gray1)
call s:HL('DiffAdd', s:green)
call s:HL('DiffChange', s:cyan)
call s:HL('DiffDelete', s:red)
call s:HL('DiffText', s:yellow)
call s:HL('Error', s:bright_white, s:red)
call s:HL('ErrorMsg', s:bright_white, s:red)
call s:HL('LineNr', s:gray)
call s:HL('MatchParen', s:magenta, s:none, s:bold)
call s:HL('MoreMsg', s:yellow)
call s:HL('NonText', s:gray2)
call s:HL('Normal', s:bright_white)
call s:HL('Question', s:yellow, s:none, s:bold)
call s:HL('Pmenu', s:bright_white, s:gray2)
call s:HL('PmenuSBar', s:none, s:black)
call s:HL('PmenuSel', s:gray2, s:white)
call s:HL('Search', s:none, s:gray2)
call s:HL('SignColumn', s:gray)
call s:HL('Special', s:orange)
call s:HL('StatusLine', s:bright_white, s:gray1)
call s:HL('StatusLineNC', s:gray, s:gray1)
call s:HL('TabLine', s:gray, s:gray1)
call s:HL('TabLineFill', s:gray, s:gray1)
call s:HL('TablineSel', s:white, s:gray)
call s:HL('Underlined', s:none, s:none, s:underline)
call s:HL('VertSplit', s:gray1)
call s:HL('Visual', s:none, s:gray2)
call s:HL('WarningMsg', s:orange)
call s:HL('WildMenu', s:blue, s:none, s:bold)

hi! link lCursor              Cursor
hi! link Conceal              NonText
hi! link CursorColumn         ColorColumn
hi! link CursorLine           ColorColumn
hi! link CursorLineNr         Normal
hi! link ErrorMsg             Error
hi! link FoldColumn           LineNr
hi! link Folded               SpecialComment
hi! link IncSearch            Search
hi! link ModeMsg              Normal
hi! link PmenuThumb           PmenuSBar
hi! link SignColumn           LineNr
hi! link SpecialKey           NonText
hi! link TabLine              TabLineFill

" }}}
" Syntax: {{{
call s:HL('Comment', s:gray, s:none, s:italic)
call s:HL('Constant', s:magenta)
call s:HL('Delimiter', s:gray3)
call s:HL('Directory', s:blue)
call s:HL('Exception', s:orange)
call s:HL('Function', s:green)
call s:HL('Identifier', s:cyan, s:none, s:italic)
call s:HL('Keyword', s:red, s:none, s:italic)
call s:HL('Operator', s:bright_white)
call s:HL('PreProc', s:cyan)
call s:HL('SpecialComment', s:gray, s:none, s:bold . s:italic)
call s:HL('SpecialKey', s:gray2)
call s:HL('Statement', s:red)
call s:HL('StorageClass', s:orange, s:none, s:italic)
call s:HL('String', s:yellow)
call s:HL('StringDelimiter', s:yellow)
call s:HL('Structure', s:cyan)
call s:HL('Title', s:green, s:none, s:bold)
call s:HL('Type', s:red, s:none, s:italic)

hi! link Boolean              Constant
hi! link Float                Constant
hi! link Macro                Special
hi! link Number               Constant
hi! link Operator             Normal
hi! link StorageClass         Special
hi! link Todo                 SpecialComment
" }}}
" Vimscript: {{{
hi! link helpExample          String
hi! link helpHyperTextEntry   Statement
hi! link helpHyperTextJump    Underlined
hi! link helpURL              Underlined
hi! link lessVariableValue    Normal
hi! link vimCommentTitle      SpecialComment
" }}}

" Coc: {{{
call s:HL('CocExplorerGitContentChange_Internal', s:orange)

" }}}
" NvimTree: {{{
hi! link NvimTreeRootFolder   Directory
hi! link NvimTreeFolderName   Directory

" }}}
" Startify: {{{
hi! link StartifyFile         Normal
hi! link StartifySlash        Normal
hi! link StartifyHeader       Constant

" }}}
" Misc: {{{
call s:HL('ExtraWhitespace', s:none, s:red)

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker :
