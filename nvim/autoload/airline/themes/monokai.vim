let s:statusline    = airline#themes#get_highlight('StatusLine')
let s:statusline_nc = airline#themes#get_highlight('StatusLineNC')
let s:active        = airline#themes#get_highlight2(['StatusLine', 'fg'], ['NonText', 'fg'])
let s:modified      = { 'airline_c': airline#themes#get_highlight('DiffAdd')}

let g:airline#themes#monokai#palette = {
      \ 'normal': airline#themes#generate_color_map(
          \ s:active,
          \ s:statusline,
          \ s:statusline_nc,
      \ ),
      \ 'insert': airline#themes#generate_color_map(
          \ airline#themes#get_highlight2(['DiffAdd', 'fg'], ['NonText', 'fg']),
          \ s:statusline,
          \ s:statusline_nc,
          \ s:statusline_nc,
          \ s:statusline,
          \ s:active,
      \ ),
      \ 'replace': airline#themes#generate_color_map(
          \ airline#themes#get_highlight2(['DiffDelete', 'fg'], ['NonText', 'fg']),
          \ s:statusline,
          \ s:statusline_nc,
          \ s:statusline_nc,
          \ s:statusline,
          \ s:active,
      \ ),
      \ 'visual': airline#themes#generate_color_map(
          \ airline#themes#get_highlight2(['DiffChange', 'fg'], ['NonText', 'fg']),
          \ s:statusline,
          \ s:statusline_nc,
          \ s:statusline_nc,
          \ s:statusline,
          \ s:active,
      \ ),
      \ 'inactive': airline#themes#generate_color_map(
          \ s:statusline_nc,
          \ s:statusline_nc,
          \ s:statusline_nc,
      \ ),
      \ 'commandline_modified': s:modified,
      \ 'inactive_modified': s:modified,
      \ 'insert_modified': s:modified,
      \ 'normal_modified': s:modified,
      \ 'replace_modified': s:modified,
      \ 'visual_modified': s:modified,
\ }

