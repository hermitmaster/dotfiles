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
    au BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
    au BufNewFile,BufRead .Brewfile set filetype=ruby
  augroup END
]])

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if not io.open(install_path) then
  PACKER_BOOTSTRAP = os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim '..install_path..' &>/dev/null')
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'tpope/vim-commentary'
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
            'alpha',
            'fugitive',
            'fugitiveblame',
            'help$',
            'NvimTree',
            'packer',
            'qf$',
            'startify$',
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
            c = { function() require('telescope.builtin').grep_string() end, 'Find <cword>' },
            d = { '<cmd>bd<cr>', 'Delete Current Buffer' },
            g = { function() require('telescope.builtin').current_buffer_fuzzy_find() end, 'Fuzzy Find' },
            l = { function() require('telescope.builtin').git_bcommits() end, 'Git Log' },
            n = { '<cmd>bn<cr>', 'Next Buffer' },
            p = { '<cmd>bp<cr>', 'Previous Buffer' },
            v = { '<cmd>Gvdiffsplit<cr>', 'Diff' },
            y = { function() require('telescope.builtin').lsp_document_symbols() end, 'Find Symbols' },
          },
          f = {
            name = 'File',
            f = { function() require('telescope.builtin').find_files() end, 'Find Files' },
            n = { '<cmd>enew<cr>', 'New File' },
            s = { '<cmd>w<cr>', 'Save File' },
            t = { '<cmd>NvimTreeToggle<cr>', 'File Tree' },
          },
          g = { name = 'Global',
            c = { function() require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') }) end, 'Find <cword>' },
            f = { function() require('telescope.builtin').live_grep() end, 'Fuzzy Find' },
            h = { function() require('telescope.builtin').git_stash() end, 'Git Stashes' },
            l = { function() require('telescope.builtin').git_commits() end, 'Git Log' },
            m = { function() require('telescope.builtin').git_branches() end, 'Git Branches'},
            p = {
              function()
                -- This is pretty close to the pattern I need to follow for tf/tg
                local Job = require('plenary.job')
                local chan = vim.api.nvim_open_term(vim.api.nvim_create_buf(true, true), {})

                Job:new({
                  command = 'pre-commit',
                  args = { 'run', '-a' },
                  cwd = os.getenv('PWD'),
                  on_stdout = vim.schedule_wrap(function(_, data)
                    vim.api.nvim_chan_send(chan, data .. '\r\n')
                  end)
                }):start()
              end,
              'pre-commit run -a'},
            s = { '<cmd>Git<cr>', 'Git Status' },
            y = { function() require('telescope.builtin').lsp_workspace_symbols() end, 'Find Symbols (Project)' },
          },
          h = { name = 'Hunk', },
          q = { '<cmd>qall<cr>', 'Quit' },
          r = { function() require('telescope.builtin').resume() end, 'Resume Search' },
          w = { name = 'Window',
            n = { '<cmd>wincmd w<cr>', 'Next Window' },
            p = { '<cmd>wincmd p<cr>', 'Previous Window' },
          },
        },
        ['<Tab>'] = { '<cmd>wincmd w<cr>', 'Next Window' },
        ['<S-Tab>'] = { '<cmd>wincmd p<cr>', 'Previous Window' },
      })
    end
  }

  use {
    'hermitmaster/nvim-kitty-navigator',
    run = 'cp ./*.py ~/.config/kitty/',
    config = function ()
      require('nvim-kitty-navigator').setup {}
    end
  }

  use {
    'hermitmaster/nvim-monokai',
    config = function ()
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
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback
      require('nvim-tree').setup {
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = "<cr>",  cb = tree_cb("edit") },
              { key = "<C-v>", cb = tree_cb("vsplit") },
              { key = "<C-x>", cb = tree_cb("split") },
              { key = "<",     cb = tree_cb("prev_sibling") },
              { key = ">",     cb = tree_cb("next_sibling") },
              { key = "P",     cb = tree_cb("parent_node") },
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
              { key = "K",     cb = tree_cb("toggle_help") },
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
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_enable_special = 0
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_relative_path = 1
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/which-key.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
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
            d = { function() vim.lsp.buf.definition() end, 'Go to Definition' },
            D = { function() vim.lsp.buf.declaration() end, 'Go to Declaration' },
            i = { function() vim.lsp.buf.implementation() end, 'Go to Implementation' },
            r = { function() vim.lsp.buf.references() end, 'Show References' },
          },
          K = { function() vim.lsp.buf.hover() end, 'Help Tags' },
          ['<leader>'] = {
            b = {
              a = { function() vim.lsp.buf.code_action() end, 'Code Action' },
              d = {
                f = { function() vim.diagnostic.open_float() end, 'Diagnostics (Float)' },
                l = { function() vim.diagnostic.setloclist() end, 'Diagnostics (LocationList)' },
                n = { function() vim.diagnostic.goto_prev() end, 'Next Diagnostic' },
                p = { function() vim.diagnostic.goto_next() end, 'Previous Diagnostic' },
              },
              f = { function() vim.lsp.buf.formatting_sync() end, 'Format Buffer' },
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

      -- Generic lsp config
      local servers = {
        'bashls',
        'gopls',
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
          'hcl',
          'html',
          'http',
          'javascript',
          'json',
          'jsonc',
          'lua',
          'make',
          'markdown',
          'python',
          'regex',
          'ruby',
          'toml',
          'typescript',
          'vim',
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
