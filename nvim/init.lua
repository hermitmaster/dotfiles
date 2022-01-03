vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.completeopt = 'menuone'
vim.opt.expandtab = true
vim.opt.fillchars = 'eob: ,vert:│'
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,extends:↷,precedes:↶,eol:↵'
vim.opt.matchtime = 0
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('acs')
vim.opt.showcmd = false
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd([[
  augroup core
    au!
    au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    au BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
    au BufNewFile,BufRead .Brewfile set filetype=ruby
  augroup END
]])

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-fugitive'

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
        ['<leader>'] = {
          b = {
            name = 'Buffer',
            d = { '<cmd>bdelete<cr>', 'Delete Current Buffer' },
            e = { '<cmd>enew<cr>','Empty Buffer' },
            f = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", 'Fuzzy Search (Buffer)' },
            F = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", 'Search <cword> (Buffer)' },
            n = { '<cmd>bnext<cr>', 'Next Buffer' },
            p = { '<cmd>bprevious<cr>', 'Previous Buffer' },
            w = { '<cmd>write<cr>', 'Write Buffer' },
            y = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", 'Search Symbols (Buffer)' },
          },
          f = {
            name = 'File',
            f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Search Files' },
            s = { '<cmd>write<cr>', 'Save File' },
            t = { '<cmd>NvimTreeToggle<cr>', 'File Tree' },
          },
          g = {
            name = 'Git',
            d = { '<cmd>Gvdiffsplit<cr>', 'Diff' },
            l = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", 'Log' },
            L = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", 'Log (Buffer)' },
            m = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", 'Branches'},
            t = { "<cmd>lua require('telescope.builtin').git_stash()<cr>", 'Stashes' },
            s = { '<cmd>Git<cr>', 'Status' },
          },
          h = {
            name = 'Hunks',
          },
          ['?'] = {
            name = 'Help',
            h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'Help Tags' },
            m = { "<cmd>lua require('telescope.builtin').man_pages()<cr>", 'Man Pages' },
          },
          q = { '<cmd>qall<cr>', 'Quit' },
          Q = { '<cmd>qall!<cr>', 'Quit (Force)' },
          R = { "<cmd>lua require('telescope.builtin').resume()<cr>", 'Resume Search' },
          w = {
            name = 'Workspace',
            f = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Fuzzy Search (Project)' },
            F = { "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>')", 'Search <cword> (Project)' },
            y = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", 'Search Symbols (Project)' },
          },
          ['1'] = { '<cmd>BufferLineGoToBuffer 1<cr>', 'Buffer 1' },
          ['2'] = { '<cmd>BufferLineGoToBuffer 2<cr>', 'Buffer 2' },
          ['3'] = { '<cmd>BufferLineGoToBuffer 3<cr>', 'Buffer 3' },
          ['4'] = { '<cmd>BufferLineGoToBuffer 4<cr>', 'Buffer 4' },
          ['5'] = { '<cmd>BufferLineGoToBuffer 5<cr>', 'Buffer 5' },
          ['6'] = { '<cmd>BufferLineGoToBuffer 6<cr>', 'Buffer 6' },
          ['7'] = { '<cmd>BufferLineGoToBuffer 7<cr>', 'Buffer 7' },
          ['8'] = { '<cmd>BufferLineGoToBuffer 8<cr>', 'Buffer 8' },
          ['9'] = { '<cmd>BufferLineGoToBuffer 9<cr>', 'Buffer 9' },
        },
        ['<Tab>'] = { '<cmd>wincmd w<cr>', 'Next Window' },
        ['<S-Tab>'] = { '<cmd>wincmd p<cr>', 'Previous Window' },
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
    'hermitmaster/nvim-monokai',
    config = function()
      vim.cmd('colorscheme monokai')
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
      local luasnip = require('luasnip')
      local cmp = require('cmp')

      cmp.setup {
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<cr>'] = cmp.mapping.confirm {
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
    run = 'cp -i ./*.py ~/.config/kitty/',
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      local nt_cb = require('nvim-tree.config').nvim_tree_callback
      require('nvim-tree').setup {
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = "<cr>",  cb = nt_cb("edit") },
              { key = "<C-v>", cb = nt_cb("vsplit") },
              { key = "<C-x>", cb = nt_cb("split") },
              { key = "i",     cb = nt_cb("toggle_ignored") },
              { key = "R",     cb = nt_cb("refresh") },
              { key = "a",     cb = nt_cb("create") },
              { key = "d",     cb = nt_cb("trash") },
              { key = "r",     cb = nt_cb("rename") },
              { key = "x",     cb = nt_cb("cut") },
              { key = "c",     cb = nt_cb("copy") },
              { key = "p",     cb = nt_cb("paste") },
              { key = "y",     cb = nt_cb("copy_name") },
              { key = "Y",     cb = nt_cb("copy_path") },
              { key = "gy",    cb = nt_cb("copy_absolute_path") },
              { key = "-",     cb = nt_cb("dir_up") },
              { key = "K",     cb = nt_cb("toggle_help") },
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
    requires = {
      'folke/which-key.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    run = 'npm i -g vscode-langservers-extracted',
    after = 'which-key.nvim',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require('lspconfig')
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign"..type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local on_attach = function(client, bufnr)
        require('which-key').register({
          g = {
            d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go To Definition' },
            D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go To Declaration' },
            i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go To Implementation' },
            r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Show References' },
            t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type Definition' },
          },
          K = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Help' },
          ['<leader>'] = {
            a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
            F = { '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', 'Format Buffer' },
            d = {
              name = 'Diagnostics (LSP)',
              e = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Diagnostics' },
              n = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Diagnostics Next' },
              p = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Diagnostics Previous' },
              q = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Diagnostics LL' },
            },
            r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename Symbol' },
          },
          ['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', '' },
        },
        { buffer = bufnr })

        if client.resolved_capabilities.document_formatting then
          vim.cmd [[
            augroup Format
              autocmd! * <buffer>
              au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
          ]]
        end
      end

      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      lspconfig.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }

      lspconfig.terraformls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          'hcl',
          'terraform'
        },
      }

      -- Generic lsp config
      local servers = {
        'bashls',
        'cssls',
        'gopls',
        'html',
        'pyright',
        'yamlls',
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = on_attach,
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
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob=!.git' }
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
        ensure_installed = {
          'bash',
          'comment',
          'css',
          'dockerfile',
          'go',
          'gomod',
          'gowork',
          'graphql',
          'hcl',
          'html',
          'http',
          'javascript',
          'json',
          'json5',
          'jsonc',
          'lua',
          'make',
          'markdown',
          'python',
          'regex',
          'ruby',
          'scss',
          'toml',
          'typescript',
          'vue',
          'yaml',
        },
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
