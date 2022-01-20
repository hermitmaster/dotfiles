set clipboard=unnamed,unnamedplus
set colorcolumn=80
set fillchars=eob:\ ,vert:│
set ignorecase smartcase wildignorecase
set list lcs=tab:→\ ,lead:·,trail:·,extends:↷,precedes:↶,eol:↵
set mouse=a
set nosc nosmd
set nowrap
set number rnu
set shortmess+=acs
set signcolumn=yes
set smartindent
set ts=2 sw=2 et
set undofile

let g:airline#extensions#tabline#enabled = 1
let g:coc_global_extensions = [ 'coc-snippets' ]
let g:is_posix = 1
let g:mapleader = ' '
let g:neoformat_hcl_terraform = {
    \ 'exe': 'terraform',
    \ 'args': ['fmt', '-write', '-'],
    \ 'stdin': 1
    \ }
let g:neoformat_enabled_hcl = ['terraform']
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:srcery_italic = 1
let g:which_key_fallback_to_native_key=1

let packager = stdpath('config') . '/pack/packager/opt/vim-packager'
if empty(glob(packager.'autoload/packager.vim'))
  silent exe '!git clone https://github.com/kristijanhusak/vim-packager '.packager
endif

function! s:packager_init(packager) abort
  call a:packager.add('airblade/vim-gitgutter')
  call a:packager.add('christoomey/vim-tmux-navigator')
  call a:packager.add('davidhalter/jedi-vim')
  call a:packager.add('fatih/vim-go')
  call a:packager.add('jiangmiao/auto-pairs')
  call a:packager.add('junegunn/fzf')
  call a:packager.add('junegunn/fzf.vim')
  call a:packager.add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call a:packager.add('liuchengxu/vim-which-key')
  call a:packager.add('mhinz/vim-startify')
  call a:packager.add('neoclide/coc.nvim', {'branch': 'release'})
  call a:packager.add('preservim/nerdtree', {'requires': 'Xuyuanp/nerdtree-git-plugin'})
  call a:packager.add('ryanoasis/vim-devicons')
  call a:packager.add('sbdchd/neoformat')
  call a:packager.add('sheerun/vim-polyglot')
  call a:packager.add('srcery-colors/srcery-vim')
  call a:packager.add('tpope/vim-commentary')
  call a:packager.add('tpope/vim-dispatch')
  call a:packager.add('tpope/vim-fugitive')
  call a:packager.add('vim-airline/vim-airline')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<cr>
vnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<cr>

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"

nnoremap <silent> K :call <SID>show_documentation()<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> <leader>bd <cmd>bd<cr>
nmap <silent> <leader>bf <cmd>Neoformat<cr>
nmap <silent> <leader>bh <cmd>Startify<cr>
nmap <silent> <leader>bn <cmd>bn<cr>
nmap <silent> <leader>bp <cmd>bp<cr>

nmap <silent> <leader>fs <cmd>write<cr>
nmap <silent> <leader>ft <cmd>NERDTreeToggle<cr>

nmap <silent> <leader>ga <cmd>Git add %<cr>
nmap <silent> <leader>gb <cmd>Git blame<cr>
nmap <silent> <leader>gc <cmd>Git commit<cr>
nmap <silent> <leader>gd <cmd>Gvdiffsplit<cr>
nmap <silent> <leader>ge <cmd>Dispatch pre-commit run -a<cr>
nmap <silent> <leader>gf <cmd>Git fetch --all --prune<cr>
nmap <silent> <leader>gl <cmd>Gclog --<cr>
nmap <silent> <leader>gs <cmd>Git<cr>
nmap <silent> <leader>gL <cmd>Gclog -- %<cr>
nmap <silent> <leader>gu <cmd>Git reset -q %<cr>

nmap <silent> <leader>lq <Plug>(coc-fix-current)
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lt <Plug>(coc-codeaction)

nmap <silent> <leader>q <cmd>qall<cr>

nmap <silent> <leader>sf <cmd>Files<cr>
nmap <silent> <leader>ss <cmd>BLines<cr>
nmap <silent> <leader>sP <cmd>Rg <C-R><C-W><cr>
nmap <silent> <leader>sS <cmd>BLines <C-R><C-W><cr>
nmap <silent> <leader>s/ <cmd>Rg<cr>

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
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

augroup core
  au!
  au VimEnter * if @% == '' || @% == '.' | NERDTree | wincmd p | endif
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

silent! colorscheme srcery

