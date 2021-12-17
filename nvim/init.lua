require 'plugins'

local fn = vim.fn
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

g.coc_data_home = fn.stdpath('data')..'/coc'
g.coc_global_extensions = {
  'coc-docker',
  'coc-go',
  'coc-json',
  'coc-lists',
  'coc-prettier',
  'coc-pyright',
  'coc-sh',
  'coc-snippets',
  'coc-vimlsp',
  'coc-yaml',
}

g.mapleader = ' '
g.maplocalleader = ','

g.startify_fortune_use_unicode = 1

vim.cmd('source '..fn.stdpath('config')..'/i.vim')

