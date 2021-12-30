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

g.is_posix = 1
g.mapleader = ' '
g.maplocalleader = ','

cmd('colorscheme monokai')

cmd([[
  augroup core
    au!
    au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    au BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
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
  use 'wbthomason/packer.nvim'

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
      vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<cr>', { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<cr>', { noremap = true, silent = true } )
    end
  }

  use {
    'feline-nvim/feline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('feline').setup {
        force_inactive = {
          filetypes = {
            '^alpha$',
            '^fugitive$',
            '^fugitiveblame$',
            '^help$',
            '^NvimTree$',
            '^packer$',
            '^qf$',
          },
        },
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
            d = { "<cmd>Gvdiffsplit<cr>", "Diff" },
            s = { "<cmd>Git<cr>", "Status" },
          },
          q = { "<cmd>qall<cr>", "Quit" },
          Q = { "<cmd>qall!<cr>", "Quit (Force)" },
          s = {
            name = "search",
          },
        },
        ["<Tab>"] = { "<cmd>wincmd w<cr>", "Next Window" },
        ["<S-Tab>"] = { "<cmd>wincmd p<cr>", "Previous Window" },
      })
    end
  }

  use {
    'goolord/alpha-nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require('alpha').setup(require('alpha.themes.startify').opts)
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
    'knubie/vim-kitty-navigator',
    run = 'cp ./*.py ~/.config/kitty/',
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
              { key = "<CR>",  cb = tree_cb("edit") },
              { key = "<C-v>", cb = tree_cb("vsplit") },
              { key = "<C-x>", cb = tree_cb("split") },
              { key = "<",     cb = tree_cb("prev_sibling") },
              { key = ">",     cb = tree_cb("next_sibling") },
              { key = "P",     cb = tree_cb("parent_node") },
              { key = "K",     cb = tree_cb("first_sibling") },
              { key = "J",     cb = tree_cb("last_sibling") },
              { key = "i",     cb = tree_cb("toggle_ignored") },
              { key = "R",     cb = tree_cb("refresh") },
              { key = "a",     cb = tree_cb("create") },
              { key = "d",     cb = tree_cb("trash") },
              { key = "r",     cb = tree_cb("rename") },
              { key = "x",     cb = tree_cb("cut") },
              { key = "c",     cb = tree_cb("copy") },
              { key = "p",     cb = tree_cb("paste") },
              { key = "y",     cb = tree_cb("copy_name") },
              { key = "Y",     cb = tree_cb("copy_path") },
              { key = "gy",    cb = tree_cb("copy_absolute_path") },
              { key = "[c",    cb = tree_cb("prev_git_item") },
              { key = "]c",    cb = tree_cb("next_git_item") },
              { key = "-",     cb = tree_cb("dir_up") },
              { key = "o",     cb = tree_cb("system_open") },
              { key = "g?",    cb = tree_cb("toggle_help") },
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
          'alpha',
          'help',
          'packer',
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
    run = 'npm i -g vscode-langservers-extracted',
    config = function()
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require('lspconfig')
      local servers = {
        'bashls',
        'cssls',
        'gopls',
        'html',
        'pyright',
        'sumneko_lua',
        'terraformls',
        'yamlls',
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
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {}
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
          },
        }
      }
      vim.api.nvim_set_keymap('n', '<leader>gl', "<cmd>lua require('telescope.builtin').git_commits()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>gL', "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>gm', "<cmd>lua require('telescope.builtin').git_branches()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>gt', "<cmd>lua require('telescope.builtin').git_stash()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sf', "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sm', "<cmd>lua require('telescope.builtin').man_pages()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sr', "<cmd>lua require('telescope.builtin').resume()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>ss', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sS', "<cmd>lua require('telescope.builtin').grep_string()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sP', "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>')", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sy', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>sY', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", { noremap = true, silent = true } )
      vim.api.nvim_set_keymap('n', '<leader>s/', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true, silent = true } )
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

  use 'tpope/vim-dispatch'

  use 'tpope/vim-fugitive'

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
