set clipboard=unnamed,unnamedplus
set fillchars=eob:\ ,vert:│
set ignorecase smartcase
set list lcs=tab:→\ ,lead:·,trail:·,extends:↷,precedes:↶,eol:↵
set mouse=a
set noshowcmd
set noshowmode
set nowrap
set number rnu
set shortmess+=acs
set signcolumn=yes
set smartindent
set ts=2 sw=2 et
set undofile

let g:airline#extensions#hunks#coc_git = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_type = 0

let g:coc_data_home = stdpath('data') . '/coc'
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-docker',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-sumneko-lua',
      \ 'coc-toml',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

let g:is_posix = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:mapleader = ' '
let g:maplocalleader = ','

let g:startify_enable_special = 0
let g:startify_fortune_use_unicode = 1
let g:startify_relative_path = 1

let plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug))
  silent exe '!curl -fLo '.plug.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

augroup vim-plug
  au!
  au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif
augroup END

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

lua require('which-key').setup()

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> <leader>bd <cmd>bd<cr>
nmap <silent> <leader>be <cmd>enew<cr>
nmap <silent> <leader>bf <cmd>call CocAction('format')<cr>
nmap <silent> <leader>bh <cmd>Startify<cr>
nmap <silent> <leader>bn <cmd>bn<cr>
nmap <silent> <leader>bp <cmd>bp<cr>

nmap <silent> <leader>fs <cmd>write<cr>
nmap <silent> <leader>ft <cmd>CocCommand explorer<cr>

nmap <silent> <leader>gb <cmd>Git blame<cr>
nmap <silent> <leader>gc <cmd>Git commit<cr>
nmap <silent> <leader>gd <cmd>Gvdiffsplit<cr>
nmap <silent> <leader>ge <cmd>Dispatch pre-commit run -a<cr>
nmap <silent> <leader>gf <cmd>Git fetch --all --prune<cr>
nmap <silent> <leader>gl <cmd>Gclog --<cr>
nmap <silent> <leader>gm <cmd>Git branch<cr>
nmap <silent> <leader>gp <cmd>Git push<cr>
nmap <silent> <leader>gs <cmd>Git<cr>
nmap <silent> <leader>gL <cmd>Gclog -- %<cr>
nmap <silent> <leader>gu <cmd>Git reset -q %<cr>

nmap <silent> <leader>hp <cmd>CocCommand git.chunkInfo<cr>
nmap <silent> <leader>hr <cmd>CocCommand git.chunkUndo<cr>
nmap <silent> <leader>hs <cmd>CocCommand git.chunkStage<cr>
nmap <silent> <leader>hS <cmd>Git add %<cr>

nmap <silent> <leader>la <Plug>(coc-codeaction-selected)
xmap <silent> <leader>la <Plug>(coc-codeaction-selected)
nmap <silent> <leader>ld <cmd>CocDiagnostics<cr>
nmap <silent> <leader>lf <Plug>(coc-format-selected)
xmap <silent> <leader>lf <Plug>(coc-format-selected)
nmap <silent> <leader>lq <Plug>(coc-fix-current)
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lt <Plug>(coc-codeaction)

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
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

augroup core
  au!
  au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
  au BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
  au VimEnter * if @% == '' || @% == '.' | exe 'CocCommand explorer' | wincmd p | endif
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
augroup END

colorscheme hermit

