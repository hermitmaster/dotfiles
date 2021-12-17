inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> <leader>bd :bdelete<cr>
nmap <silent> <leader>be :enew<cr>
nmap <silent> <leader>bf :call CocAction('format')<cr>
nmap <silent> <leader>bh :Startify<cr>
nmap <silent> <leader>bn :bnext<cr>
nmap <silent> <leader>bp :bprevious<cr>

nmap <silent> <leader>fs :write<cr>
nmap <silent> <leader>ft <cmd>NvimTreeToggle<cr>

nmap <silent> <leader>ga :Git add %<cr>
nmap <silent> <leader>gb :Git blame<cr>
nmap <silent> <leader>gc :Git commit<cr>
nmap <silent> <leader>gd :Gvdiffsplit<cr>
nmap <silent> <leader>ge :Dispatch pre-commit run -a<cr>
nmap <silent> <leader>gf :Git fetch --all --prune<cr>
nmap <silent> <leader>gl :Gclog --<cr>
nmap <silent> <leader>gm :Git branch<cr>
nmap <silent> <leader>gp :Git push<cr>
nmap <silent> <leader>gs :Git<cr>
nmap <silent> <leader>gL :Gclog -- %<cr>
nmap <silent> <leader>gU :Git reset -q %<cr>

nmap <leader>la <Plug>(coc-codeaction-selected)
xmap <leader>la <Plug>(coc-codeaction-selected)
nmap <leader>lf <Plug>(coc-format-selected)
xmap <leader>lf <Plug>(coc-format-selected)
nmap <leader>lq <Plug>(coc-fix-current)
nmap <leader>lr <Plug>(coc-rename)
nmap <leader>lt <Plug>(coc-codeaction)

nmap <silent> <leader>q <cmd>qall<cr>

nnoremap <silent> <leader>sa :<C-u>CocList diagnostics<cr>
nnoremap <leader>sb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>sf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <leader>ss :<C-u>CocList words<cr>
nnoremap <silent> <leader>sw :<C-u>CocList windows<cr>
nnoremap <silent> <leader>sy :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>sP :<C-u>CocList -I --normal --input=<C-R><C-W> grep<cr>
nnoremap <silent> <leader>sS :<C-u>CocList -I --normal --input=<C-R><C-W> words<cr>
nnoremap <leader>s/ <cmd>lua require('telescope.builtin').live_grep()<cr>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

augroup core
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
augroup END

silent! colorscheme monokai

