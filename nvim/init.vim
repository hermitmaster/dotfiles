" Core Config: {{{
set clipboard^=unnamed,unnamedplus
set colorcolumn=80
set completeopt=menu,menuone,longest
set display+=lastline
set expandtab
set fillchars=eob:\ ,vert:│,fold:·
set hidden
set ignorecase
set incsearch
set linebreak
set list
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
set matchtime=0
set mouse=nv
set noshelltemp
set noshowcmd
set noshowmode
set noswapfile
set nowrap
set number
set scrolloff=3
set shiftwidth=2
set sidescrolloff=5
set signcolumn=yes
set shortmess+=Facs
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set ttimeoutlen=50
set undofile
set updatetime=100
set wildignore+='*/tmp/*,*.swp,*.zip,*.class,*/target/*,.git,.DS_Store'
set wildignorecase

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
" }}}
" Global Variables: {{{

let g:airline_filetype_overrides = {
      \ 'fugitiveblame': ['fugitiveblame',''],
      \ 'nerdtree': ['NERDTree','']
      \ }
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0

let g:coc_data_home = $HOME . '/.local/share/coc'
let g:coc_global_extensions = [
      \ 'coc-docker',
      \ 'coc-explorer',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-python',
      \ 'coc-sh',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

let g:indentLine_fileTypeExclude = [
      \ 'coc-explorer',
      \ 'help',
      \ 'startify'
      \ ]

let g:neoformat_enabled_json = ['jq']

let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1

let g:netrw_nogx = 1

let g:openbrowser_default_search = 'duckduckgo'

let g:srcery_italic = 1

let g:shfmt_opt="-ci"

let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
let g:startify_skiplist = ['pack/.*/doc']

let g:terraform_fmt_on_save = 1

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

let g:which_key_localleader_map = {}
let g:which_key_leader_map = {
      \ 'b': {'name': '+Buffers'},
      \ 'f': {'name': '+Files'},
      \ 'g': {'name': '+Git',
          \ 'h': {'name': '+Hunks'},
      \ },
      \ 'l': {'name': '+LSP'},
      \ 's': {'name' : '+Search'},
      \ 'w': {'name': '+Windows'},
      \ 'x': {'name': '+Text'},
      \ }
" }}}
" Key Mapping: {{{
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
nnoremap <silent>g :<c-u>WhichKey 'g'<CR>
vnoremap <silent>g :<c-u>WhichKey 'g'<CR>

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gx <Plug>(openbrowser-smart-search)
vmap <silent> gx <Plug>(openbrowser-smart-search)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> <leader>bd :bdelete<CR>
nmap <silent> <leader>bD :bdelete!<CR>
nmap <silent> <leader>be :enew<CR>
nmap <silent> <leader>bf :Neoformat<CR>
nmap <silent> <leader>bh :Startify<CR>
nmap <silent> <leader>bn :bnext<CR>
nmap <silent> <leader>bp :bprevious<CR>
nmap <silent> <leader>b/ :Buffers<CR>

nmap <silent> <leader>fs :write<CR>
nmap <silent> <leader>ft :NERDTreeToggleVCS<CR>
nmap <silent> <leader>fS :wall<CR>
nmap <silent> <leader>f/ :GFiles<CR>

nmap <silent> <leader>ga :Git add %<CR>
nmap <silent> <leader>gb :Git blame<CR>
nmap <silent> <leader>gc :Git commit<CR>
nmap <silent> <leader>gd :Gvdiffsplit<CR>
nmap <silent> <leader>gf :Git fetch --all --prune<CR>
nmap <silent> <leader>gha <Plug>(GitGutterStageHunk)
nmap <silent> <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <silent> <leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>gl :Gclog --<CR>
nmap <silent> <leader>gm :Git branch<CR>
nmap <silent> <leader>gp :Gpush<CR>
nmap <silent> <leader>gs :Git<CR>
nmap <silent> <leader>gA :Git add .<CR>
nmap <silent> <leader>gL :Gclog -- %<CR>
nmap <silent> <leader>gU :Git reset -q %<CR>

nmap <leader>la <Plug>(coc-codeaction-selected)
xmap <leader>la <Plug>(coc-codeaction-selected)
nmap <leader>lf <Plug>(coc-format-selected)
xmap <leader>lf <Plug>(coc-format-selected)
nmap <leader>lq <Plug>(coc-fix-current)
nmap <leader>lr <Plug>(coc-rename)
nmap <leader>lt <Plug>(coc-codeaction)
nmap <leader>l. :CocConfig<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap <leader>lif <Plug>(coc-funcobj-i)
omap <leader>lif <Plug>(coc-funcobj-i)
xmap <leader>laf <Plug>(coc-funcobj-a)
omap <leader>laf <Plug>(coc-funcobj-a)
xmap <leader>lic <Plug>(coc-classobj-i)
omap <leader>lic <Plug>(coc-classobj-i)
xmap <leader>lac <Plug>(coc-classobj-a)
omap <leader>lac <Plug>(coc-classobj-a)

nmap <silent> <leader>q :qall<CR>
nmap <silent> <leader>Q :qall!<CR>

nmap <silent> <leader>ss :BLines<CR>
nmap <silent> <leader>sP :Rg <C-R><C-W><CR>
nmap <silent> <leader>sS :BLines <C-R><C-W><CR>
nmap <silent> <leader>s/ :Rg<CR>

nmap <silent> <leader>wd :close<CR>
nmap <silent> <leader>wh :split<CR>
nmap <silent> <leader>wo :only<CR>
nmap <silent> <leader>ws :vsplit +bp<CR>
nmap <silent> <leader>wv :vsplit<CR>
nmap <silent> <leader>w/ :Windows<CR>

" Tab navigation
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Window navigation
nnoremap <silent><Tab> :wincmd w<cr>
nnoremap <silent><S-Tab> :wincmd p<cr>
" }}}
" Local Functions: {{{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
" Auto Commands: {{{
augroup core
  au!
  autocmd VimEnter * if !argc() | Startify | NERDTree | wincmd w | endif
  au VimEnter * call which_key#register('<Space>', 'g:which_key_leader_map')
  au BufEnter * call which_key#register(',', 'g:which_key_localleader_map')
  au BufEnter * :syntax sync fromstart
  au BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) | bd | q | endif
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter diff,quickfix nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
augroup END
" }}}
" Colorscheme: {{{
set background=dark
silent! colorscheme srcery
" }}}
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker :
