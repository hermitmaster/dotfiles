local packer_install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap

vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.completeopt = 'menuone'
vim.opt.expandtab = true
vim.opt.fillchars = 'eob: ,vert:│'
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,extends:↷,precedes:↶,eol:↵'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('acs')
vim.opt.showcmd = false
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

vim.cmd([[
  augroup core
    au!
    au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    au BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
  augroup END
]])

if not io.open(packer_install_path) then
  packer_bootstrap = os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim '..packer_install_path..' &>/dev/null')
end

return require('packer').startup(function(use)
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
            'alpha',
            'fugitive',
            'fugitiveblame',
            'help',
            'NvimTree',
            'packer',
            'qf',
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
          b = { name = 'Buffer',
            d = { '<cmd>bd<cr>', 'Delete Current Buffer' },
            n = { '<cmd>bn<cr>', 'Next Buffer' },
            p = { '<cmd>bp<cr>', 'Previous Buffer' },
            v = { '<cmd>Gvdiffsplit<cr>', 'Diff' },
          },
          f = { name = 'File',
            n = { '<cmd>enew<cr>', 'New File' },
            s = { '<cmd>w<cr>', 'Save File' },
            t = { '<cmd>NvimTreeToggle<cr>', 'File Tree' },
          },
          g = { name = 'Global',
            s = { '<cmd>Git<cr>', 'Git Status' },
          },
          h = { name = 'Hunk', },
          q = { '<cmd>qall<cr>', 'Quit' },
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
    'hermitmaster/nvim-kitty-navigator',
    run = 'cp kitty/* ~/.config/kitty/',
    config = function()
      require('nvim-kitty-navigator').setup {}
    end
  }

  use {
    'hermitmaster/nvim-monokai',
    config = function()
      require('monokai').setup {}
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
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      local tree_cb = require('nvim-tree.config').nvim_tree_callback
      require('nvim-tree').setup {
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = '<cr>',  cb = tree_cb('edit') },
              { key = '<C-v>', cb = tree_cb('vsplit') },
              { key = '<C-x>', cb = tree_cb('split') },
              { key = 'i',     cb = tree_cb('toggle_ignored') },
              { key = 'R',     cb = tree_cb('refresh') },
              { key = 'a',     cb = tree_cb('create') },
              { key = 'd',     cb = tree_cb('trash') },
              { key = 'r',     cb = tree_cb('rename') },
              { key = 'x',     cb = tree_cb('cut') },
              { key = 'c',     cb = tree_cb('copy') },
              { key = 'p',     cb = tree_cb('paste') },
              { key = 'y',     cb = tree_cb('copy_path') },
              { key = 'Y',     cb = tree_cb('copy_absolute_path') },
              { key = 'K',     cb = tree_cb('toggle_help') },
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
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require('lspconfig')
      local servers = { 'bashls', 'gopls', 'pyright', 'yamlls', }
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign"..type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local on_attach = function(client, bufnr)
        require('which-key').register({
          g = {
            d = { function() vim.lsp.buf.definition() end, 'Go to Definition' },
            D = { function() vim.lsp.buf.declaration() end, 'Go to Declaration' },
            i = { function() vim.lsp.buf.implementation() end, 'Go to Implementation' },
            r = { function() vim.lsp.buf.references() end, 'Show References' },
          },
          K = { function() vim.lsp.buf.hover() end, 'Help Tags' },
          ['<leader>'] = {
            b = {
              a = { function() vim.lsp.buf.code_action() end, 'Code Action' },
              f = { function() vim.lsp.buf.formatting_sync() end, 'Format Buffer' },
              i = {
                f = { function() vim.diagnostic.open_float() end, 'Diagnostics (Float)' },
                l = { function() vim.diagnostic.setloclist() end, 'Diagnostics (LocationList)' },
                n = { function() vim.diagnostic.goto_prev() end, 'Next Diagnostic' },
                p = { function() vim.diagnostic.goto_next() end, 'Previous Diagnostic' },
              },
              k = { function() vim.lsp.buf.signature_help() end, 'Signature Help' },
              r = { function() vim.lsp.buf.rename() end, 'Rename Symbol' },
              t = { function() vim.lsp.buf.type_definition() end, 'TypeDef' },
            },
          },
        },
        { buffer = bufnr })

        if client.resolved_capabilities.document_formatting then
          vim.cmd [[
            augroup fmt
              au! * <buffer>
              " Seems like the undojoin may be a problem for certain providers
              au BufWritePre <buffer> undojoin | lua vim.lsp.buf.formatting_sync()
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
        filetypes = { 'hcl', 'terraform' },
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
      require('Comment').setup()
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'folke/which-key.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            find_command = { 'rg', '--files' }
          },
        }
      }

      require('which-key').register({
        ['<leader>'] = {
          b = {
            c = { function() require('telescope.builtin').grep_string() end, 'Find <cword>' },
            f = { function() require('telescope.builtin').current_buffer_fuzzy_find() end, 'Fuzzy Find' },
            l = { function() require('telescope.builtin').git_bcommits() end, 'Git Log' },
            y = { function() require('telescope.builtin').lsp_document_symbols() end, 'Find Symbols' },
          },
          f = {
            f = { function() require('telescope.builtin').find_files() end, 'Find Files' },
          },
          g = {
            c = { function() require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') }) end, 'Find <cword>' },
            f = { function() require('telescope.builtin').live_grep() end, 'Fuzzy Find' },
            h = { function() require('telescope.builtin').git_stash() end, 'Git Stashes' },
            l = { function() require('telescope.builtin').git_commits() end, 'Git Log' },
            m = { function() require('telescope.builtin').git_branches() end, 'Git Branches'},
            y = { function() require('telescope.builtin').lsp_workspace_symbols() end, 'Find Symbols' },
          },
          r = { function() require('telescope.builtin').resume() end, 'Resume Search' },
        },
      })

    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        highlight = { enable = true },
      }
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup { check_ts = true }
    end
  }

  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'

  if packer_bootstrap then require('packer').sync() end
end)
