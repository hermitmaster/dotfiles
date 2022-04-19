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
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
    au BufWinEnter * if(exists('b:_winview')) | call winrestview(b:_winview) | endif
    au BufWinLeave * let b:_winview = winsaveview()
  augroup END
]])

vim.fn.sign_define({
  { name = 'DiagnosticSignError', numhl = 'DiagnosticSignError', texthl = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint', texthl = 'DiagnosticSignHint', text = ' ' },
  { name = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo', texthl = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn', texthl = 'DiagnosticSignWarn', text = ' ' }
})

if not io.open(packer_install_path) then
  vim.api.nvim_create_autocmd('User', { command = 'quitall', once = true, pattern = 'PackerComplete' })
  packer_bootstrap = os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim ' ..
    packer_install_path .. ' &>/dev/null')
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup {
        keybindings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
          last_active = '<C-\\>',
          next = '<C-Space>',
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
            d = { '<cmd>bd<cr>', 'Delete Current Buffer' },
            h = { '<cmd>Alpha<cr>', 'Dashboard' },
            v = { '<cmd>Gvdiffsplit<cr>', 'Diff' },
            w = { '<cmd>w<cr>', 'Write Buffer' },
          },
          f = {
            name = 'File',
            j = { '<cmd>NvimTreeFindFile<cr>', 'Jump to File' },
            n = { '<cmd>enew<cr>', 'New File' },
            s = { '<cmd>w<cr>', 'Save File' },
            t = { '<cmd>NvimTreeToggle<cr>', 'File Tree' },
          },
          g = {
            name = 'Global',
          },
          q = { '<cmd>qall<cr>', 'Quit' },
          w = {
            name = 'Window',
            d = { '<cmd>close<cr>', 'Close Current Window' },
          },
        },
        ['['] = {
          name = 'Previous',
          ['b'] = { '<cmd>bp<cr>', 'Previous Buffer' },
          ['t'] = { '<cmd>tabp<cr>', 'Previous Tab' },
          ['w'] = { '<cmd>wincmd p<cr>', 'Previous Window' },
        },
        [']'] = {
          name = 'Next',
          ['b'] = { '<cmd>bn<cr>', 'Next Buffer' },
          ['t'] = { '<cmd>tabn<cr>', 'Next Tab' },
          ['w'] = { '<cmd>wincmd w<cr>', 'Next Window' },
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
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('alpha').setup(require('alpha.themes.hermit').config)
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
      local cmp = require('cmp')
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
          { name = 'buffer' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    ft = 'alpha',
    config = function()
      local tree_cb = require('nvim-tree.config').nvim_tree_callback

      require('nvim-tree').setup {
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
              { key = 's', cb = tree_cb('system_open') },
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
                name = 'Hunk',
                b = { function() gs.blame_line({ full = true }) end, 'Blame Hunk', },
                B = { function() gs.toggle_current_line_blame() end, 'Toggle Line Blame', },
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

  use { 'mfussenegger/nvim-dap' }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/which-key.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/nvim-lsp-installer',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require('lspconfig')
      local servers = {
        'bashls',
        'cssls',
        'dockerls',
        'efm',
        'gopls',
        'html',
        'jsonls',
        'pyright',
        'sumneko_lua',
        'terraformls',
        'tsserver',
        'volar',
        'yamlls',
      }

      require('nvim-lsp-installer').setup({
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
              f = { function() vim.lsp.buf.formatting_sync() end, 'Format Buffer', },
              i = {
                f = { function() vim.diagnostic.open_float() end, 'Diagnostics (Float)', },
                l = { function() vim.diagnostic.setloclist() end, 'Diagnostics (LocationList)', },
                n = { function() vim.diagnostic.goto_prev() end, 'Next Diagnostic', },
                p = { function() vim.diagnostic.goto_next() end, 'Previous Diagnostic', },
              },
              k = { function() vim.lsp.buf.signature_help() end, 'Signature Help', },
              r = { function() vim.lsp.buf.rename() end, 'Rename Symbol', },
              t = { function() vim.lsp.buf.type_definition() end, 'TypeDef', },
            },
          },
        }, { buffer = bufnr })

        if client.resolved_capabilities.document_formatting then
          local augroup = 'lsp_fmt'

          vim.api.nvim_create_augroup(augroup, { clear = true })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.formatting_sync()
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
      require('Comment').setup({
        ignore = '^$',
      })
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'monokai.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'alpha', 'help', 'NvimTree' },
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
              show_filename_only = false
            }
          },
          lualine_z = { 'tabs' },
        },
        extensions = {
          'fugitive',
          'nvim-tree',
        },
      }
    end,
  }

  use {
    'nvim-pack/nvim-spectre',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('spectre').setup({
        live_update = true,
        mapping = {
          ['toggle_line'] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item"
          },
          ['enter_file'] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file"
          },
          ['send_to_qf'] = {
            map = "<leader>sq",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix"
          },
          ['replace_cmd'] = {
            map = "<leader>sc",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace vim command"
          },
          ['show_option_menu'] = {
            map = "<leader>so",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option"
          },
          ['run_replace'] = {
            map = "<leader>sR",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all"
          },
          ['change_view_mode'] = {
            map = "<leader>sv",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode"
          },
          ['toggle_live_update'] = {
            map = "tu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "update change when vim write file."
          },
          ['toggle_ignore_case'] = {
            map = "ti",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case"
          },
          ['toggle_ignore_hidden'] = {
            map = "th",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "toggle search hidden"
          },
        },
        replace_engine = {
          ['sed'] = {
            cmd = "gsed",
            args = nil
          },
          options = {
            ['ignore-case'] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case"
            },
          }
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
            find_command = { 'rg', '--files', '--hidden' },
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
          r = { function() require('telescope.builtin').resume() end, 'Resume Search', },
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
          'javascript',
          'json',
          'jsonc',
          'lua',
          'make',
          'markdown',
          'python',
          'ruby',
          'sql',
          'toml',
          'typescript',
          'vim',
          'vue',
          'yaml',
        },
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
