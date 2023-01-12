vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.colorcolumn = '+1'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.cursorline = true
vim.opt.diffopt:append('vertical')
vim.opt.fillchars = { eob = ' ', vert = '│' }
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = { eol = '↵', extends = '↷', precedes = '↶', tab = '→ ' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.scrolloff = 1
vim.opt.shortmess:append('acs')
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.sidescrolloff = 3
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '

vim.fn.sign_define({
  { name = 'DiagnosticSignError', numhl = 'DiagnosticSignError', texthl = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint', texthl = 'DiagnosticSignHint', text = ' ' },
  { name = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo', texthl = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignOther', numhl = 'DiagnosticSignOther', texthl = 'DiagnosticSignOther', text = '﫠' },
  { name = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn', texthl = 'DiagnosticSignWarn', text = ' ' },
})

local ensure_packer = function()
  local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if io.open(packer_install_path) then
    return false
  else
    os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. packer_install_path)
    vim.cmd([[packadd packer.nvim]])
    return true
  end
end

local packer_bootstrap = ensure_packer()

LSP_ON_ATTACH = function(client, bufnr)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { desc = 'Go to Definition' })
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, { desc = 'Go to Declaration' })
  vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation() end, { desc = 'Go to Implementation' })
  vim.keymap.set('n', 'gR', function() vim.lsp.buf.references() end, { desc = 'Show References' })

  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'Hover' })

  vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, { desc = 'Code Action' })
  vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.setloclist() end, { desc = 'Diagnostics' })
  vim.keymap.set('n', '<leader>bf', function() vim.lsp.buf.format() end, { desc = 'Format Buffer' })
  vim.keymap.set('n', '<leader>lk', function() vim.lsp.buf.signature_help() end, { desc = 'Signature Help' })
  vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, { desc = 'Rename Symbol' })
  vim.keymap.set('n', '<leader>lt', function() vim.lsp.buf.type_definition() end, { desc = 'TypeDef' })

  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, { desc = 'Previous Diagnostic' })
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, { desc = 'Next Diagnostic' })

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('lsp_fmt', { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end,
    })
  end
end

return require('packer').startup(function(use)
  use({
    'gpanders/editorconfig.nvim',
    'sitiom/nvim-numbertoggle',
    'towolf/vim-helm',
    'wbthomason/packer.nvim',
  })

  use({
    'ethanholz/nvim-lastplace',
    config = function() require('nvim-lastplace').setup({}) end,
  })

  use({
    'folke/which-key.nvim',
    config = function()
      local wk = require('which-key')

      wk.setup({})
      wk.register({
        ['<leader>'] = {
          b = {
            name = 'Buffer',
            w = { '<cmd>w<cr>', 'Write Buffer' },
          },
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
          l = {
            name = 'LSP',
          },
          n = { '<cmd>enew<cr>', 'New File' },
          q = { '<cmd>qall<cr>', 'Quit' },
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
  })

  use({
    'goolord/alpha-nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('alpha').setup(require('alpha.themes.hermit'))

      vim.keymap.set('n', '<leader>bh', '<cmd>Alpha<cr>', { desc = 'Dashboard' })
    end,
  })

  use({
    'hermitmaster/monokai.nvim',
    config = function() vim.cmd('colorscheme monokai') end,
  })

  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol',
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
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local nls = require('null-ls')

      nls.setup({
        on_attach = LSP_ON_ATTACH,
        sources = {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.shellcheck,
          nls.builtins.diagnostics.checkmake,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.diagnostics.opacheck,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.rego,
          nls.builtins.formatting.shfmt.with({ extra_args = { '-bn', '-ci', '-i', '2', '-s' } }),
          nls.builtins.formatting.stylua,
        },
      })
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          vim.keymap.set(
            'n',
            '<leader>hb',
            function() gs.blame_line({ full = true }) end,
            { desc = 'Blame Hunk', buffer = bufnr }
          )
          vim.keymap.set(
            'n',
            '<leader>hB',
            function() gs.toggle_current_line_blame() end,
            { desc = 'Line Blame', buffer = bufnr }
          )
          vim.keymap.set('n', '<leader>hd', function() gs.diffthis() end, { desc = 'Diff', buffer = bufnr })
          vim.keymap.set('n', '<leader>hp', function() gs.preview_hunk() end, { desc = 'Preview Hunk', buffer = bufnr })
          vim.keymap.set('n', '<leader>hr', function() gs.reset_hunk() end, { desc = 'Reset Hunk', buffer = bufnr })
          vim.keymap.set('n', '<leader>hR', function() gs.reset_buffer() end, { desc = 'Reset Buffer', buffer = bufnr })
          vim.keymap.set('n', '<leader>hs', function() gs.stage_hunk() end, { desc = 'Stage Hunk', buffer = bufnr })
          vim.keymap.set('n', '<leader>hS', function() gs.stage_buffer() end, { desc = 'Stage Buffer', buffer = bufnr })
          vim.keymap.set(
            'n',
            '<leader>hu',
            function() gs.undo_stage_hunk() end,
            { desc = 'Unstage Hunk', buffer = bufnr }
          )
          vim.keymap.set('n', '[c', function() gs.prev_hunk() end, { desc = 'Previous Hunk', buffer = bufnr })
          vim.keymap.set('n', ']c', function() gs.next_hunk() end, { desc = 'Next Hunk', buffer = bufnr })
        end,
      })
    end,
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        char = '│',
        show_current_context = true,
        show_first_indent_level = false,
        use_treesitter = true,
      })
    end,
  })

  use({
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local servers = {
        'bashls',
        'cssls',
        'dockerls',
        'gopls',
        'html',
        'jsonls',
        'marksman',
        'pyright',
        'sumneko_lua',
        'taplo',
        'terraformls',
        'tflint',
        'tsserver',
        'vimls',
        'yamlls',
      }

      for _, server in ipairs(servers) do
        local config = {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          on_attach = LSP_ON_ATTACH,
        }

        if server == 'gopls' then
          config.settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
              gofumpt = true,
            },
          }
        elseif server == 'sumneko_lua' then
          config.settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              format = {
                enable = false,
              },
              runtime = {
                version = 'LuaJIT',
              },
              telemetry = {
                enable = false,
              },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('*.lua', true),
              },
            },
          }
        elseif server == 'terraformls' then
          config.filetypes = { 'hcl', 'terraform' }
        end

        require('lspconfig')[server].setup(config)
      end
    end,
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        ignore = '^$',
      })
    end,
  })

  use({
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()

      vim.keymap.set('n', '<C-h>', '<cmd>NavigatorLeft<cr>')
      vim.keymap.set('n', '<C-l>', '<cmd>NavigatorRight<cr>')
      vim.keymap.set('n', '<C-k>', '<cmd>NavigatorUp<cr>')
      vim.keymap.set('n', '<C-j>', '<cmd>NavigatorDown<cr>')
      vim.keymap.set('n', '<C-\\>', '<cmd>NavigatorPrevious<cr>')
    end,
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('lualine').setup({
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
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
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = {
                error = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
                hint = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
                info = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
                warn = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
              },
            },
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
            'progress',
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
                dashboard = 'Dashboard',
                packer = 'Packer',
                NvimTree = 'NvimTree',
                TelescopePrompt = 'Telescope',
              },
              show_filename_only = false,
              symbols = {
                modified = ' ●',
                alternate_file = '',
                directory = '',
              },
            },
          },
          lualine_z = { 'tabs' },
        },
        extensions = {
          'alpha',
          'nvim-tree',
          'packer',
          'pager',
        },
      })
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      local tb = require('telescope.builtin')

      require('telescope').setup({
        defaults = {
          file_ignore_patterns = {
            '%.git/.*',
            'node_modules/.*',
          },
          vimgrep_arguments = { 'rg', '-nHS.', '--column', '--no-heading', '--trim' },
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden' },
          },
        },
      })

      require('telescope').load_extension('fzf')

      vim.keymap.set('n', '<leader>bc', function() tb.grep_string() end, { desc = 'Find <cword>' })
      vim.keymap.set('n', '<leader>bg', function() tb.current_buffer_fuzzy_find() end, { desc = 'Fuzzy Find' })
      vim.keymap.set('n', '<leader>bl', function() tb.git_bcommits() end, { desc = 'Git Log' })
      vim.keymap.set('n', '<leader>by', function() tb.lsp_document_symbols() end, { desc = 'Find Symbols' })

      vim.keymap.set('n', '<leader>ff', function()
        if not pcall(tb.git_files) then tb.find_files() end
      end, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fr', function() tb.oldfiles({ cwd_only = true }) end, { desc = 'Recent Files' })

      vim.keymap.set(
        'n',
        '<leader>gc',
        function() tb.live_grep({ default_text = vim.fn.expand('<cword>') }) end,
        { desc = 'Find <cword>' }
      )
      vim.keymap.set('n', '<leader>gg', function() tb.live_grep() end, { desc = 'Fuzzy Find' })
      vim.keymap.set('n', '<leader>gh', function() tb.git_stash() end, { desc = 'Git Stashes' })
      vim.keymap.set('n', '<leader>gl', function() tb.git_commits() end, { desc = 'Git Log' })
      vim.keymap.set('n', '<leader>gm', function() tb.git_branches() end, { desc = 'Git Branches' })
      vim.keymap.set('n', '<leader>gs', function() tb.git_status() end, { desc = 'Git Status' })
      vim.keymap.set('n', '<leader>gy', function() tb.lsp_workspace_symbols() end, { desc = 'Find Symbols' })
      vim.keymap.set('n', '<leader>r', function() tb.resume() end, { desc = 'Resume Search (Telescope)' })
    end,
  })

  use({
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    ft = 'alpha',
    config = function()
      require('nvim-tree').setup({
        diagnostics = {
          enable = true,
          icons = {
            error = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
            hint = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
            info = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
            warning = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
          },
          show_on_dirs = true,
        },
        disable_netrw = true,
        filters = { custom = { '^.git$' } },
        ignore_buffer_on_setup = true,
        open_on_setup = true,
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },
        view = {
          hide_root_folder = true,
          mappings = {
            list = {
              { key = '<Tab>', action = '' },
            },
          },
        },
      })

      vim.keymap.set('n', '<leader>fj', '<cmd>NvimTreeFindFile<cr>', { desc = 'Jump to File' })
      vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle File Tree' })
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  })

  use({
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function() require('dapui').setup() end,
  })

  use({
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() vim.keymap.set('n', '<leader>d', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview Open' }) end,
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end,
  })

  if packer_bootstrap then require('packer').sync() end
end)
