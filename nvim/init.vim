set clipboard=unnamed,unnamedplus
set cursorline
set fillchars=eob:\ ,vert:│
set hidden
set ignorecase smartcase
set list lcs=tab:→\ ,trail:·,extends:↷,precedes:↶,eol:↵
set mouse=a
set nowritebackup
set noshowcmd
set noshowmode
set nowrap
set number rnu
set shortmess+=acs
set showmatch matchtime=0
set signcolumn=yes
set smartindent
set ts=2 sw=2 et
set undofile

let g:is_posix = 1

let g:airline#extensions#hunks#coc_git = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_type = 0

let g:coc_data_home = stdpath('data') . '/coc'
let g:coc_global_extensions = [
      \ 'coc-docker',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:mapleader = ' '
let g:maplocalleader = ','

let g:startify_fortune_use_unicode = 1
let g:startify_relative_path = 1
let g:startify_update_oldfiles = 1

let plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug))
  silent exe '!curl -fLo '.plug.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'folke/which-key.nvim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
call plug#end()

lua require('which-key').setup {}

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
nmap <silent> gx <Plug>(openbrowser-smart-search)
vmap <silent> gx <Plug>(openbrowser-smart-search)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> <leader>bd :bdelete<cr>
nmap <silent> <leader>be :enew<cr>
nmap <silent> <leader>bf :call CocAction('format')<cr>
nmap <silent> <leader>bh :Startify<cr>
nmap <silent> <leader>bn :bnext<cr>
nmap <silent> <leader>bp :bprevious<cr>

nmap <silent> <leader>fs :write<cr>
nmap <silent> <leader>ft :CocCommand explorer<cr>

nmap <silent> <leader>ga :Git add %<cr>
nmap <silent> <leader>gb :Git blame<cr>
nmap <silent> <leader>gc :Git commit<cr>
nmap <silent> <leader>gd :Gvdiffsplit<cr>
nmap <silent> <leader>ge :Dispatch pre-commit run -a<cr>
nmap <silent> <leader>gf :Git fetch --all --prune<cr>
nmap <silent> <leader>gha :CocCommand git.chunkStage<cr>
nmap <silent> <leader>ghu :CocCommand git.chunkUndo<cr>
nmap <silent> <leader>ghv :CocCommand git.diffCached<cr>
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

nmap <silent> <leader>q :qall<cr>

nnoremap <silent> <leader>sa :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>sb :<C-u>CocList buffers<cr>
nnoremap <silent> <leader>sf :<C-u>CocList files<cr>
nnoremap <silent> <leader>ss :<C-u>CocList words<cr>
nnoremap <silent> <leader>sw :<C-u>CocList windows<cr>
nnoremap <silent> <leader>sy :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>sP :<C-u>CocList -I --normal --input=<C-R><C-W> grep<cr>
nnoremap <silent> <leader>sS :<C-u>CocList -I --normal --input=<C-R><C-W> words<cr>
nnoremap <silent> <leader>s/ :<C-u>CocList grep<cr>

nnoremap <silent> <leader>hg :call SynGroup()<cr>

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

nnoremap <silent><Tab> :wincmd w<cr>
nnoremap <silent><S-Tab> :wincmd p<cr>

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

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

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

augroup core
  au!
  au StdinReadPre * let s:std_in=1
  au VimEnter * if @% == '' || @% == '.' | exe 'CocCommand explorer' | wincmd p | endif
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
augroup END

colorscheme monokai

