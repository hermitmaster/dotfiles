local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
    end
  }

  use 'christoomey/vim-tmux-navigator'
  use {
    'famiu/feline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('feline').setup {
        colors = {
          bg = '#383830',
          black = '#383830',
          skyblue = '#a1efe4',
          cyan = '#009090',
          fg = '#f9f8f5',
          green = '#a6e22e',
          oceanblue = '#49483e',
          magenta = '#ae81ff',
          orange = '#FF9000',
          red = '#f92672',
          violet = '#ae81ff',
          white = '#f9f8f5',
          yellow = '#e6db74'
        }
      }
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end
  }

  use 'hermitmaster/vim-monokai'

  use 'jiangmiao/auto-pairs'

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        char = '│',
        filetype_exclude = { 'help', 'packer', 'startify' },
        show_current_context = true,
        show_first_indent_level = false,
        use_treesitter = true
      }
    end
  } 

  use 'mhinz/vim-startify'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('telescope').setup {}
    end
  }
  
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        },
      }
    end
  }
  
  use 'tpope/vim-commentary'
  
  use 'tpope/vim-dispatch'
  
  use 'tpope/vim-fugitive'
  
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup {}
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
