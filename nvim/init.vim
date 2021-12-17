lua<<EOF
local g = vim.g
local o = vim.opt

o.clipboard = 'unnamed,unnamedplus'
o.cursorline = true
o.cursorlineopt = 'number'
o.expandtab = true
o.fillchars = 'eob: ,vert:│'
o.hidden = true
o.ignorecase = true
o.list = true
o.listchars = 'tab:→ ,trail:·,extends:↷,precedes:↶,eol:↵'
o.matchtime = 0
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.shiftwidth = 2
o.shortmess:append('acs')
o.showcmd = false
o.showmatch = true
o.showmode = false
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.termguicolors = true
o.tabstop = 2
o.undofile = true
o.updatetime = 300
o.wrap = false
o.writebackup = false

g.mapleader = ' '
g.maplocalleader = ','

g.startify_fortune_use_unicode = 1
EOF

let g:coc_data_home = stdpath('data') . '/coc'
let g:coc_global_extensions = [
      \ 'coc-docker',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

let plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug))
  silent exe '!curl -fLo '.plug.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'akinsho/bufferline.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'famiu/feline.nvim'
Plug 'folke/which-key.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

lua<<EOF
require('bufferline').setup {}

require('feline').setup {
  colors = {
    bg = '#383830',
    black = '#383830',
    skyblue = '#a1efe4',
    cyan = '#009090',
    fg = '#f9f8f5',
    green = '#a6e22e',
    oceanblue = '#49483e',
    magenta = '#ae81ff',
    orange = '#FF9000',
    red = '#f92672',
    violet = '#ae81ff',
    white = '#f9f8f5',
    yellow = '#e6db74'
  }
}

require('gitsigns').setup {}

require('indent_blankline').setup {
  char = '│',
  filetype_exclude = { 'help', 'packer', 'startify' },
  show_current_context = true,
  show_first_indent_level = false,
  use_treesitter = true
}

require('nvim-tree').setup {}

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

require('which-key').setup {}
EOF

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
nnoremap <silent> <leader>sb :<C-u>CocList buffers<cr>
nnoremap <silent> <leader>sf :<C-u>CocList files<cr>
nnoremap <silent> <leader>ss :<C-u>CocList words<cr>
nnoremap <silent> <leader>sw :<C-u>CocList windows<cr>
nnoremap <silent> <leader>sy :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>sP :<C-u>CocList -I --normal --input=<C-R><C-W> grep<cr>
nnoremap <silent> <leader>sS :<C-u>CocList -I --normal --input=<C-R><C-W> words<cr>
nnoremap <silent> <leader>s/ :<C-u>CocList grep<cr>

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

augroup core
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
  au BufWinLeave * let b:_winview = winsaveview()
augroup END

colorscheme monokai

