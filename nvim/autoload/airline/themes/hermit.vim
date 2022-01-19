let s:inactive = airline#themes#get_highlight('StatusLineNC')
let s:active2 = airline#themes#get_highlight('User8')
let s:active3 = airline#themes#get_highlight('User9')
let s:modified   = { 'airline_c': airline#themes#get_highlight('DiffAdd')}

let g:airline#themes#hermit#palette = {
      \ 'commandline': airline#themes#generate_color_map(
          \ s:inactive,
          \ s:active2,
          \ s:active3
          \ ),
      \ 'commandline_modified': s:modified,
      \ 'commandline_paste': s:modified,
      \ 'inactive': airline#themes#generate_color_map(
          \ s:inactive,
          \ s:inactive,
          \ s:inactive
          \ ),
      \ 'inactive_modified': s:modified,
      \ 'insert': airline#themes#generate_color_map(
          \ airline#themes#get_highlight('User2'),
          \ s:active2,
          \ s:active3
          \ ),
      \ 'insert_modified': s:modified,
      \ 'normal': airline#themes#generate_color_map(
          \ airline#themes#get_highlight('User7'),
          \ s:active2,
          \ s:active3
          \ ),
      \ 'normal_modified': s:modified,
      \ 'normal_paste': s:modified,
      \ 'replace': airline#themes#generate_color_map(
          \ airline#themes#get_highlight('User1'),
          \ s:active2,
          \ s:active3
          \ ),
      \ 'replace_modified': s:modified,
      \ 'terminal': airline#themes#generate_color_map(
          \ airline#themes#get_highlight('User3'),
          \ s:active2,
          \ s:active3
          \ ),
      \ 'visual': airline#themes#generate_color_map(
          \ airline#themes#get_highlight('User5'),
          \ s:active2,
          \ s:active3),
      \ 'visual_modified': s:modified,
\ }

