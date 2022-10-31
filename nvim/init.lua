local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
vim.opt.scrolloff = 1
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('acs')
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.sidescrolloff = 3
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
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
  augroup END
]])

vim.fn.sign_define({
  { name = 'DiagnosticSignError', numhl = 'DiagnosticSignError', texthl = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint', texthl = 'DiagnosticSignHint', text = ' ' },
  { name = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo', texthl = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn', texthl = 'DiagnosticSignWarn', text = ' ' },
})

if not io.open(packer_install_path) then
  vim.api.nvim_create_autocmd('User', { command = 'quitall', once = true, pattern = 'PackerComplete' })
  packer_bootstrap = os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim ' ..
    packer_install_path .. ' &>/dev/null')
end

return require('packer').startup(function(use)
  use {
    'folke/trouble.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require('trouble').setup {}
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
            w = { '<cmd>w<cr>', 'Write Buffer' },
          },
          d = { '<cmd>DiffviewOpen<cr>', 'DiffviewOpen' },
          f = {
            name = 'File',
            s = { '<cmd>w<cr>', 'Save File' },
          },
          g = {
            name = 'Global',
          },
          h = {
            name = 'Hunk',
          },
          n = { '<cmd>enew<cr>', 'New File' },
          q = { '<cmd>qall<cr>', 'Quit' },
          s = {
            name = 'Spectre',
          },
        },
        ['['] = {
          name = 'Previous',
          b = { '<cmd>bp<cr>', 'Previous Buffer' },
          t = { '<cmd>tabp<cr>', 'Previous Tab' },
          w = { '<cmd>wincmd p<cr>', 'Previous Window' },
        },
        [']'] = {
          name = 'Next',
          b = { '<cmd>bn<cr>', 'Next Buffer' },
          t = { '<cmd>tabn<cr>', 'Next Tab' },
          w = { '<cmd>wincmd w<cr>', 'Next Window' },
        },
        ['<esc>'] = { '<cmd>noh<cr><esc>', 'Clear Search Highlights' },
        ['<Tab>'] = { '<cmd>wincmd w<cr>', 'Next Window' },
        ['<S-Tab>'] = { '<cmd>wincmd p<cr>', 'Previous Window' },
        d = {
          name = 'Delete',
          B = { '<cmd>bd<cr>', 'Buffer' },
          W = { '<cmd>close<cr>', 'Window' },
        },
      })
    end,
  }

  use {
    'goolord/alpha-nvim',
    requires = {
      'folke/which-key.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('alpha').setup(require('alpha.themes.hermit').config)

      require('which-key').register({
        ['<leader>'] = {
          b = {
            h = { '<cmd>Alpha<cr>', 'Dashboard' },
          },
        },
      })
    end,
  }

  use {
    'hermitmaster/monokai.nvim',
    config = function()
      vim.cmd('colorscheme monokai')
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require('cmp') ---@cast cmp -?
      local luasnip = require('luasnip')

      cmp.setup {
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
          }),
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<cr>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
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
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'folke/which-key.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    ft = 'alpha',
    config = function()
      local tree_cb = require('nvim-tree.config').nvim_tree_callback

      require('nvim-tree').setup {
        diagnostics = {
          enable = true,
          icons = {
            error = vim.fn.sign_getdefined('DiagnosticSignError').icon,
            hint = vim.fn.sign_getdefined('DiagnosticSignHint').icon,
            info = vim.fn.sign_getdefined('DiagnosticSignInfo').icon,
            warn = vim.fn.sign_getdefined('DiagnosticSignWarn').icon,
          },
          show_on_dirs = false,
        },
        disable_netrw = true,
        ignore_buffer_on_setup = true,
        open_on_setup = true,
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = '<cr>', cb = tree_cb('edit') },
              { key = '<C-v>', cb = tree_cb('vsplit') },
              { key = '<C-x>', cb = tree_cb('split') },
              { key = 'h', cb = tree_cb('toggle_dotfiles') },
              { key = 'i', cb = tree_cb('toggle_git_ignored') },
              { key = 'R', cb = tree_cb('refresh') },
              { key = 'a', cb = tree_cb('create') },
              { key = 'd', cb = tree_cb('trash') },
              { key = 'q', cb = tree_cb('close') },
              { key = 'r', cb = tree_cb('rename') },
              { key = 'o', cb = tree_cb('system_open') },
              { key = 'x', cb = tree_cb('cut') },
              { key = 'c', cb = tree_cb('copy') },
              { key = 'p', cb = tree_cb('paste') },
              { key = 'y', cb = tree_cb('copy_path') },
              { key = 'Y', cb = tree_cb('copy_absolute_path') },
              { key = 'K', cb = tree_cb('toggle_help') },
            },
          },
        },
      }
    end,

    require('which-key').register({
      ['<leader>'] = {
        f = {
          j = { function() require('nvim-tree.api').tree.find_file(vim.fn.expand('%')) end, 'Jump to File' },
          t = { function() require('nvim-tree.api').tree.toggle() end, 'Toggle File Tree' },
        },
      },
    })
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'folke/which-key.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          require('which-key').register({
            ['<leader>'] = {
              h = {
                b = { function() gs.blame_line({ full = true }) end, 'Blame Hunk', },
                B = { function() gs.toggle_current_line_blame() end, 'Toggle Line Blame', },
                d = { function() gs.diffthis() end, 'Diff', },
                p = { function() gs.preview_hunk() end, 'Preview Hunk', },
                r = { function() gs.reset_hunk() end, 'Reset Hunk', },
                R = { function() gs.reset_buffer() end, 'Reset Buffer', },
                s = { function() gs.stage_hunk() end, 'Stage Hunk', },
                S = { function() gs.stage_buffer() end, 'Stage Buffer', },
                u = { function() gs.undo_stage_hunk() end, 'Undo Stage Hunk', },
              },
            },
            [']c'] = { function() gs.next_hunk() end, 'Next Hunk', },
            ['[c'] = { function() gs.prev_hunk() end, 'Prev Hunk', },
          }, { buffer = bufnr })

          require('which-key').register({
            ['ih'] = { ':<C-U>Gitsigns select_hunk<cr>', 'Select Hunk' },
          }, { buffer = bufnr, mode = 'o' })

          require('which-key').register({
            ['ih'] = { ':<C-U>Gitsigns select_hunk<cr>', 'Select Hunk' },
          }, { buffer = bufnr, mode = 'x' })
        end,
      }
    end,
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
        use_treesitter = true,
      }
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/which-key.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      local servers = {
        'ansiblels',
        'bashls',
        'cssls',
        'dockerls',
        'efm',
        'gopls',
        'html',
        'jsonls',
        'jsonnet_ls',
        'pyright',
        'rust_analyzer',
        'sumneko_lua',
        'terraformls',
        'tflint',
        'tsserver',
        'vimls',
        'volar',
        'yamlls',
      }

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local on_attach = function(client, bufnr)
        require('which-key').register({
          g = {
            d = { function() vim.lsp.buf.definition() end, 'Go to Definition', },
            D = { function() vim.lsp.buf.declaration() end, 'Go to Declaration', },
            I = { function() vim.lsp.buf.implementation() end, 'Go to Implementation', },
            R = { function() vim.lsp.buf.references() end, 'Show References', },
          },
          K = { function() vim.lsp.buf.hover() end, 'Help Tags', },
          ['<leader>'] = {
            b = {
              a = { function() vim.lsp.buf.code_action() end, 'Code Action', },
              d = { function() vim.diagnostic.setloclist() end, 'Diagnostics', },
              f = { function() vim.lsp.buf.format() end, 'Format Buffer', },
              k = { function() vim.lsp.buf.signature_help() end, 'Signature Help', },
              r = { function() vim.lsp.buf.rename() end, 'Rename Symbol', },
              t = { function() vim.lsp.buf.type_definition() end, 'TypeDef', },
            },
          },
          ['[d'] = { function() vim.diagnostic.goto_next() end, 'Previous Diagnostic', },
          [']d'] = { function() vim.diagnostic.goto_prev() end, 'Next Diagnostic', },
        }, { buffer = bufnr })

        if client.server_capabilities.documentFormattingProvider then
          local augroup = 'lsp_fmt'

          vim.api.nvim_create_augroup(augroup, { clear = true })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      for _, server in ipairs(servers) do
        local config = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        if server == 'efm' then
          config.filetypes = {}
          config.init_options = { documentFormatting = true }
          config.settings = {
            rootMarkers = { '.git/' },
            languages = {
              markdown = {
                { formatCommand = 'prettier --stdin --stdin-filepath ${INPUT}', formatStdin = true }
              },
              python = {
                { formatCommand = 'isort --profile black --quiet -', formatStdin = true },
                { formatCommand = 'black --quiet -', formatStdin = true },
              },
              sh = {
                { formatCommand = 'shfmt -bn -ci -i 2 -s', formatStdin = true },
                {
                  lintCommand = 'shellcheck -f gcc -x',
                  lintSource = 'shellcheck',
                  lintFormats = {
                    '%f:%l:%c: %trror: %m',
                    '%f:%l:%c: %tarning: %m',
                    '%f:%l:%c: %tote: %m',
                  },
                },
              },
              yaml = {
                { formatCommand = 'prettier --stdin --stdin-filepath ${INPUT}', formatStdin = true }
              },
            },
          }

          -- Get the filetypes from the languages table
          for k, _ in pairs(config.settings.languages) do
            table.insert(config.filetypes, k)
          end
        elseif server == 'sumneko_lua' then
          config.settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              runtime = {
                version = 'LuaJIT',
              },
              telemetry = {
                enable = false,
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          }
        elseif server == 'terraformls' then
          config.filetypes = { 'hcl', 'terraform' }
        end

        lspconfig[server].setup(config)
      end
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        ignore = '^$',
      }
    end,
  }

  use {
    'numToStr/Navigator.nvim',
    requires = {
      'folke/which-key.nvim',
    },
    config = function()
      require('Navigator').setup()

      require('which-key').register({
        ['<C-h>'] = { function() require('Navigator').left() end, 'Left' },
        ['<C-j>'] = { function() require('Navigator').down() end, 'Left' },
        ['<C-k>'] = { function() require('Navigator').up() end, 'Left' },
        ['<C-l>'] = { function() require('Navigator').right() end, 'Left' },
        ['<C-\\>'] = { function() require('Navigator').previous() end, 'Left' },
      })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    after = 'monokai.nvim',
    config = function()
      require('lualine').setup {
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'alpha', 'NvimTree' },
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            {
              'filetype',
              icon_only = true,
              padding = {
                left = 1,
                right = 0,
              },
              separator = {},
            },
            {
              'filename',
              path = 1,
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = ' [No Name]',
              },
            },
          },
          lualine_c = {
            'diagnostics',
          },
          lualine_x = {
            { 'b:gitsigns_head', icon = '' },
            {
              'diff',
              source = {
                function()
                  local gitsigns = vim.b.gitsigns_status_dict
                  if gitsigns then
                    return {
                      added = gitsigns.added,
                      modified = gitsigns.changed,
                      removed = gitsigns.removed,
                    }
                  end
                end,
              },

              symbols = {
                added = ' ',
                modified = '柳',
                removed = ' ',
              },
            },
          },
          lualine_y = {
            'encoding',
            {
              'fileformat',
              symbols = {
                dos = 'CRLF',
                mac = 'CR',
                unix = 'LF',
              },
            },
          },
          lualine_z = {
            'location',
            '%P',
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {
          lualine_a = {
            {
              'buffers',
              filetype_names = {
                alpha = 'Alpha',
                packer = 'Packer',
                NvimTree = 'NvimTree',
                TelescopePrompt = 'Telescope',
              },
              show_filename_only = false
            }
          },
          lualine_z = { 'tabs' },
        },
        extensions = {
          'man',
          'nvim-tree',
        }
      }
    end,
  }

  use {
    'nvim-pack/nvim-spectre',
    requires = {
      'folke/which-key.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('spectre').setup({
        live_update = true,
        replace_engine = {
          ['sed'] = {
            cmd = 'gsed',
            args = nil
          },
        },
      })

      require('which-key').register({
        ['<leader>'] = {
          s = {
            o = { function() require('spectre').open_visual() end, 'Open Spectre', },
            w = { function() require('spectre').open_visual({ select_word = true }) end, 'Search <cword> Using Spectre', },
          },
        },
      })
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'folke/which-key.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            '%.git/.*',
            'node_modules/.*',
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--column',
            '--hidden',
            '--line-number',
            '--no-heading',
            '--smart-case',
            '--trim',
            '--with-filename',
          },
        },
        pickers = {
          find_files = {
            find_command = {
              'fd',
              '--type',
              'f',
              '--strip-cwd-prefix',
              '--hidden'
            },
          },
        },
      }

      require('telescope').load_extension('fzf')

      require('which-key').register({
        ['<leader>'] = {
          b = {
            c = { function() require('telescope.builtin').grep_string() end, 'Find <cword>', },
            g = { function() require('telescope.builtin').current_buffer_fuzzy_find() end, 'Fuzzy Find', },
            l = { function() require('telescope.builtin').git_bcommits() end, 'Git Log', },
            y = { function() require('telescope.builtin').lsp_document_symbols() end, 'Find Symbols', },
          },
          f = {
            f = {
              function()
                if not pcall(require('telescope.builtin').git_files) then
                  require('telescope.builtin').find_files()
                end
              end,
              'Find Files',
            },
            r = { function() require('telescope.builtin').oldfiles() end, 'Recent Files', },
          },
          g = {
            c = { function() require('telescope.builtin').live_grep { default_text = vim.fn.expand '<cword>', } end,
              'Find <cword>', },
            g = { function() require('telescope.builtin').live_grep() end, 'Fuzzy Find', },
            h = { function() require('telescope.builtin').git_stash() end, 'Git Stashes', },
            l = { function() require('telescope.builtin').git_commits() end, 'Git Log', },
            m = { function() require('telescope.builtin').git_branches() end, 'Git Branches', },
            s = { function() require('telescope.builtin').git_status() end, 'Git Status', },
            y = { function() require('telescope.builtin').lsp_workspace_symbols() end, 'Find Symbols', },
          },
          r = { function() require('telescope.builtin').resume() end, 'Resume Search (Telescope)', },
        },
      })
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'andymass/vim-matchup',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = { enable = true },
        matchup = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      }
    end,
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
    }
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  use {
    'sitiom/nvim-numbertoggle',
    config = function()
      require('numbertoggle').setup()
    end
  }

  use {
    'wbthomason/packer.nvim'
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
      }
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
