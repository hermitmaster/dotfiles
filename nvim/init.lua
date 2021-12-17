local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.opt

o.clipboard = 'unnamed,unnamedplus'
o.completeopt = 'menuone'
o.expandtab = true
o.fillchars = 'eob: ,vert:│'
o.ignorecase = true
o.list = true
o.listchars = 'tab:→ ,extends:↷,precedes:↶,eol:↵'
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
o.tabstop = 2
o.termguicolors = true
o.undofile = true
o.updatetime = 300
o.wrap = false

g.mapleader = ' '
g.maplocalleader = ','
g.startify_enable_special = 0
g.startify_fortune_use_unicode = 1
g.startify_relative_path = 1
g.startify_update_oldfiles = 1

cmd('silent! colorscheme monokai')

cmd([[
  augroup core
    au!
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
  augroup END
]])

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'christoomey/vim-tmux-navigator'
  use 'hermitmaster/vim-monokai'
  use 'mhinz/vim-startify'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
    end
  }

  use {
    'feline-nvim/feline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('feline').setup {
        theme = {
          bg = '#383830',
          fg = '#f9f8f5',
          black = '#383830',
          red = '#f92672',
          green = '#a6e22e',
          yellow = '#e6db74',
          oceanblue = '#49483e',
          magenta = '#ae81ff',
          violet = '#ae81ff',
          cyan = '#a1efe4',
          skyblue = '#66d9ef',
          orange = '#75715e',
          white = '#f9f8f5',
        }
      }
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      local wk = require('which-key')
      wk.setup {}
      wk.register({
        ["<leader>"] = {
          b = {
            name = "buffer",
            d = { "<cmd>bdelete<cr>", "Delete Current Buffer" },
            n = { "<cmd>bnext<cr>", "Next Buffer" },
            p = { "<cmd>bprevious<cr>", "Previous Buffer" },
          },
          f = {
            name = "file",
            n = { "<cmd>enew<cr>","New File" },
            s = { "<cmd>write<cr>", "Save File" },
            t = { "<cmd>NvimTreeToggle<cr>","File Tree" },
          },
          g = {
            name = "git",
            l = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Log" },
            L = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", "Log (Buffer)" },
            m = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Branches" },
            s = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Status" },
            t = { "<cmd>lua require('telescope.builtin').git_stash()<cr>", "Stash" },
          },
          h = {
            name = "hunks (git)",
          },
          l = {
            name = "lsp",
          },
          q = { "<cmd>qall<cr>", "Quit" },
          Q = { "<cmd>qall!<cr>", "Quit (Force)" },
          s = {
            name = "search",
            b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
            f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
            h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags" },
            m = { "<cmd>lua require('telescope.builtin').man_pages()<cr>", "Manual Pages" },
            r = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume Last Search" },
            s = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Fuzzy Search (Buffer)" },
            S = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "CWORD (Buffer)" },
            P = { "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<cr>", "CWORD (Project)" },
            y = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Symbols (Buffer)" },
            Y = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", "Symbols (Project)" },
            ["/"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Fuzzy Search (Project)" },
          },
          w = {
            name = "window",
            n = { "<cmd>wincmd w<cr>", "Next Window" },
            p = { "<cmd>wincmd p<cr>", "Previous Window" },
          },
          ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Buffer 1" },
          ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Buffer 2" },
          ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Buffer 3" },
          ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Buffer 4" },
          ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Buffer 5" },
          ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Buffer 6" },
          ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Buffer 7" },
          ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Buffer 8" },
          ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Buffer 9" },
        },
        ["<Tab>"] = { "<cmd>wincmd w<cr>", "Next Window" },
        ["<S-Tab>"] = { "<cmd>wincmd p<cr>", "Previous Window" },
      })
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'

      cmp.setup {
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback
      require('nvim-tree').setup {
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = "<CR>",   cb = tree_cb("edit") },
              { key = "<C-v>",  cb = tree_cb("vsplit") },
              { key = "<C-x>",  cb = tree_cb("split") },
              { key = "<C-t>",  cb = tree_cb("tabnew") },
              { key = "<",      cb = tree_cb("prev_sibling") },
              { key = ">",      cb = tree_cb("next_sibling") },
              { key = "P",      cb = tree_cb("parent_node") },
              { key = "<BS>",   cb = tree_cb("close_node") },
              { key = "K",      cb = tree_cb("first_sibling") },
              { key = "J",      cb = tree_cb("last_sibling") },
              { key = "I",      cb = tree_cb("toggle_ignored") },
              { key = "R",      cb = tree_cb("refresh") },
              { key = "a",      cb = tree_cb("create") },
              { key = "d",      cb = tree_cb("trash") },
              { key = "r",      cb = tree_cb("rename") },
              { key = "<C-r>",  cb = tree_cb("full_rename") },
              { key = "x",      cb = tree_cb("cut") },
              { key = "c",      cb = tree_cb("copy") },
              { key = "p",      cb = tree_cb("paste") },
              { key = "y",      cb = tree_cb("copy_name") },
              { key = "Y",      cb = tree_cb("copy_path") },
              { key = "gy",     cb = tree_cb("copy_absolute_path") },
              { key = "[c",     cb = tree_cb("prev_git_item") },
              { key = "]c",     cb = tree_cb("next_git_item") },
              { key = "-",      cb = tree_cb("dir_up") },
              { key = "o",      cb = tree_cb("system_open") },
              { key = "g?",     cb = tree_cb("toggle_help") },
            }
          }
        }
      }
      vim.cmd("au VimEnter * if @% == '' || @% == '.' | exe 'NvimTreeOpen' | wincmd p | endif")
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        char = '│',
        filetype_exclude = {
          'help',
          'packer',
          'startify',
        },
        show_current_context = true,
        show_first_indent_level = false,
        use_treesitter = true
      }
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = 'hrsh7th/cmp-nvim-lsp',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require('lspconfig')
      local servers = {
        'gopls',
        'pyright',
        'sumneko_lua',
        'terraformls'
      }

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
        buf_set_keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

      end

      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
          },
        }
      }

    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        highlight = {
          enable = true,
        },
      }
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true
      }
    end
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
