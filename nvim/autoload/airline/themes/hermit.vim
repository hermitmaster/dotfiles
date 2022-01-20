let s:active2   = airline#themes#get_highlight('StatusLine')
let s:active3   = airline#themes#get_highlight('User8')
let s:modified  = { 'airline_c': airline#themes#get_highlight('DiffAdd')}

let g:airline#themes#hermit#palette = {
    \ 'replace': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User1'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'insert': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User2'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'terminal': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User3'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'commandline': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User4'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'visual': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User5'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'normal': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User7'),
        \ s:active2,
        \ s:active3
    \ ),
    \ 'inactive': airline#themes#generate_color_map(
        \ airline#themes#get_highlight('User9'),
        \ airline#themes#get_highlight('StatusLineNC'),
        \ airline#themes#get_highlight('TabLineFill')
    \ ),
    \ 'commandline_modified': s:modified,
    \ 'commandline_paste': s:modified,
    \ 'inactive_modified': s:modified,
    \ 'insert_modified': s:modified,
    \ 'normal_modified': s:modified,
    \ 'normal_paste': s:modified,
    \ 'replace_modified': s:modified,
    \ 'visual_modified': s:modified,
\ }

