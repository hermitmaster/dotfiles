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
  { name = 'DiagnosticSignError', numhl = 'DiagnosticSignError', texthl = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint', texthl = 'DiagnosticSignHint', text = ' ' },
  { name = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo', texthl = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignOther', numhl = 'DiagnosticSignOther', texthl = 'DiagnosticSignOther', text = ' ' },
  { name = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn', texthl = 'DiagnosticSignWarn', text = ' ' },
})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not io.open(lazypath) then
  os.execute('git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ' .. lazypath)
end

vim.opt.rtp:prepend(lazypath)

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

return require('lazy').setup({
  'sitiom/nvim-numbertoggle',
  'terrastruct/d2-vim',
  'towolf/vim-helm',
  {
    'ethanholz/nvim-lastplace',
    config = function() require('nvim-lastplace').setup({}) end,
  },
  {
    'folke/tokyonight.nvim',
    config = function() vim.cmd('colorscheme tokyonight-moon') end,
  },
  {
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
  },
  {
    'goolord/alpha-nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('alpha').setup(require('alpha.themes.hermit'))

      vim.keymap.set('n', '<leader>bh', '<cmd>Alpha<cr>', { desc = 'Dashboard' })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'jayp0521/mason-null-ls.nvim',
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
    },
    config = function()
      local nls = require('null-ls')

      nls.setup({
        on_attach = LSP_ON_ATTACH,
        sources = {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.shellcheck,
          nls.builtins.diagnostics.checkmake,
          nls.builtins.diagnostics.opacheck,
          nls.builtins.diagnostics.rubocop,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.terraform_validate,
          nls.builtins.diagnostics.tfsec,
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.rego,
          nls.builtins.formatting.rubocop,
          nls.builtins.formatting.shfmt.with({ extra_args = { '-bn', '-ci', '-i', '2', '-s' } }),
          nls.builtins.formatting.stylua,
        },
      })

      require('mason').setup()
      require('mason-null-ls').setup({
        automatic_installation = true,
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
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
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        scope = {
          highlight = { 'CursorLineNr' },
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local servers = {
        'bashls',
        'cssls',
        'dockerls',
        'gopls',
        'helm_ls',
        'html',
        'jsonls',
        'lua_ls',
        'marksman',
        'solargraph',
        'terraformls',
        'tflint',
        'tsserver',
      }

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

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
        elseif server == 'lua_ls' then
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
          config.filetypes = {
            'hcl',
            'terraform',
            'terraform-vars',
          }
        end

        require('lspconfig')[server].setup(config)
      end
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        ignore = '^$',
      })
    end,
  },
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()

      vim.keymap.set('n', '<C-h>', '<cmd>NavigatorLeft<cr>')
      vim.keymap.set('n', '<C-l>', '<cmd>NavigatorRight<cr>')
      vim.keymap.set('n', '<C-k>', '<cmd>NavigatorUp<cr>')
      vim.keymap.set('n', '<C-j>', '<cmd>NavigatorDown<cr>')
      vim.keymap.set('n', '<C-\\>', '<cmd>NavigatorPrevious<cr>')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('lualine').setup({
        options = {
          globalstatus = true,
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
                readonly = ' ',
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
                added = ' ',
                modified = ' ',
                removed = ' ',
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
        tabline = {
          lualine_a = {
            {
              'buffers',
              show_filename_only = false,
              symbols = {
                modified = ' ',
                alternate_file = '',
                directory = '',
              },
            },
          },
          lualine_z = { 'tabs' },
        },
        extensions = {
          'alpha',
          'nvim-dap-ui',
          'nvim-tree',
          'packer',
          'pager',
          'trouble',
        },
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
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
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
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
        renderer = {
          root_folder_label = false,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
          vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
          vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
          vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
          vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
          vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
          vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
          vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
          vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
          vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
          vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
          vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
          vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
          vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
          vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
          vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
          vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
          vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
          vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
          vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
          vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
          vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
          vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
          vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
          vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
          vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
          vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
          vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
          vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
          vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
          vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
          vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
          vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
          vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
          vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
          vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        end,
      })

      vim.keymap.set('n', '<leader>fj', '<cmd>NvimTreeFindFile<cr>', { desc = 'Jump to File' })
      vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle File Tree' })

      vim.api.nvim_create_autocmd({ 'VimEnter' }, {
        callback = function()
          local filetype = vim.bo.filetype
          local ignore_filetypes = {
            'man',
            'DiffviewFiles',
          }

          for _, ft in ipairs(ignore_filetypes) do
            if filetype == ft then
              break
            else
              if not require('nvim-tree.api').tree.is_visible() then
                require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
              end
            end
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'jay-babu/mason-nvim-dap.nvim',
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim',
    },
    config = function()
      require('dapui').setup()

      require('mason').setup()
      require('mason-nvim-dap').setup({
        automatic_installation = true,
        ensure_installed = {
          'bash',
          'delve',
          'js',
          'python',
        },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end,
  },
})
