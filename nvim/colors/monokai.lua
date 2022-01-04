local M = {}

M.palette = {
  black          = '#272822',
  red            = '#f92672',
  green          = '#a6e22e',
  yellow         = '#e6db74',
  blue           = '#66d9ef',
  magenta        = '#ae81ff',
  cyan           = '#a1efe4',
  white          = '#f8f8f2',
  gray           = '#75715e',
  orange         = '#fd971f',
  gray1          = '#383830',
  gray2          = '#49483e',
  gray3          = '#a59f85',
  gray4          = '#f5f4f1',
  bright_orange  = '#cc6633',
  bright_white   = '#f9f8f5',
}

M.style = {
  bold = 'bold',
  inverse = 'inverse',
  italic = 'italic',
  undercurl = 'undercurl',
  underline = 'underline',
}

M.highlight = function(group, attributes)
  local guifg = attributes.fg or 'NONE'
  local guibg = attributes.bg or 'NONE'
  local gui = attributes.style and table.concat(attributes.style, ',') or 'NONE'

  vim.cmd('highlight '..group..' guifg='..guifg..' guibg='..guibg..' gui='..gui)

  if attributes.links then
    for _, link in ipairs(attributes.links) do
      vim.cmd('highlight! link '..link..' '..group)
    end
  end
end

M.highlights = {
  ColorColumn = {
    bg = M.palette.gray1,
    links = {
      'CursorColumn',
      'CursorLine',
    }
  },
  Comment = {
    fg = M.palette.gray,
    style = {
      M.style.italic,
    }
  },
  Constant = {
    fg = M.palette.magenta,
  },
  Delimiter = {
    fg = M.palette.gray3,
  },
  DiffAdd = {
    fg = M.palette.green,
  },
  DiffChange = {
    fg = M.palette.cyan,
  },
  DiffDelete = {
    fg = M.palette.red,
  },
  DiffText = {
    fg = M.palette.yellow,
  },
  Directory = {
    fg = M.palette.blue,
    links = {
      'NvimTreeFolderName',
      'NvimTreeRootFolder',
    }
  },
  Error = {
    fg = M.palette.bright_white,
    bg = M.palette.red,
  },
  ErrorMsg = {
    fg = M.palette.red,
  },
  Exception = {
    fg = M.palette.orange,
  },
  ExtraWhitespace = {
    bg = M.palette.red,
  },
  Function = {
    fg = M.palette.green,
  },
  Identifier = {
    fg = M.palette.cyan,
    style = {
      M.style.italic,
    },
  },
  Keyword = {
    fg = M.palette.red,
    style = {
      M.style.italic,
    },
  },
  LineNr = {
    fg = M.palette.gray,
    links = {
      'FoldColumn',
      'SignColumn',
    }
  },
  MatchParen = {
    fg = M.palette.magenta,
    style = { M.style.bold },
  },
  MoreMsg = {
    fg = M.palette.yellow,
  },
  NonText = {
    fg = M.palette.gray2,
    links = {
      'Conceal',
      'SpecialKey',
    }
  },
  Normal = {
    fg = M.palette.bright_white,
    links = {
      'CursorLineNr',
      'ModeMsg',
      'Operator',
      'lessVariableValue',
    },
  },
  Pmenu = {
    fg = M.palette.bright_white,
    bg = M.palette.gray2,
  },
  PmenuSBar = {
    bg = M.palette.black,
    links = {
      'PmenuThumb',
    }
  },
  PmenuSel = {
    fg = M.palette.gray2,
    bg = M.palette.white,
  },
  PreProc = {
    fg = M.palette.cyan,
  },
  Question = {
    fg = M.palette.yellow,
    style = {
      M.style.bold,
    },
  },
  Search = {
    bg = M.palette.gray2,
    links = {
      'IncSearch',
    },
  },
  Special = {
    fg = M.palette.orange,
    links = {
      'Macro',
      'StorageClass',
    },
  },
  SpecialComment = {
    fg = M.palette.gray,
    style = {
      M.style.bold,
      M.style.italic,
    },
    links = {
      'Folded',
      'Todo',
      'vimCommentTitle',
    },
  },
  Statement = {
    fg = M.palette.red,
    links = {
      'Label',
      'Repeat',
      'TSRepeat',
      'TSTag',
      'helpHyperTextEntry',
    },
  },
  StatusLine = {
    fg = M.palette.bright_white,
    bg = M.palette.gray1,
  },
  StatusLineNC = {
    fg = M.palette.gray,
    bg = M.palette.gray1,
  },
  String = {
    fg = M.palette.yellow,
    links = {
      'StringDelimiter',
      'TSString',
      'helpExample',
    },
  },
  Structure = {
    fg = M.palette.cyan,
  },
  TabLine = {
    fg = M.palette.gray,
    bg = M.palette.gray1,
  },
  TablineFill = {
    bg = M.palette.gray1
  },
  TablineSel = {
    fg = M.palette.white,
    bg = M.palette.gray2,
  },
  Title = {
    fg = M.palette.green,
    style = {
      M.style.bold,
    },
  },
  TSError = {
    style = {
      M.style.underline,
    },
  },
  Type = {
    fg = M.palette.red,
    style = {
      M.style.italic,
    },
  },
  Underlined = {
    style = {
      M.style.underline,
    },
    links = {
      'helpHyperTextJump',
      'helpURL',
    },
  },
  VertSplit = {
    fg = M.palette.gray1,
  },
  Visual = {
    bg = M.palette.gray2,
  },
  WarningMsg = {
    fg = M.palette.orange,
  },
  WildMenu = {
    fg = M.palette.blue,
    bg = M.palette.gray2,
    style = {
      M.style.bold,
    },
  },
}

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = "monokai"

vim.opt.termguicolors = true
vim.opt.background = 'dark'

for group, attributes in pairs(M.highlights) do
  M.highlight(group, attributes)
end
