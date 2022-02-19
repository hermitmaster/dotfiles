
local palette = {
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
  none           = 'NONE'
}

local style = {
  bold = 'bold',
  inverse = 'inverse',
  italic = 'italic',
  strikethrough = 'strikethrough',
  undercurl = 'undercurl',
  underline = 'underline',
  none = 'NONE',
}

local function highlight(group, attributes)
  local bg = attributes.bg or palette.none
  local fg = attributes.fg or palette.none
  local gui = style.none

   if attributes.gui then
     if type(attributes.gui) == "table" then
       gui = table.concat(attributes.gui, ',')
     elseif type(attributes.gui) == "string" then
       gui = attributes.gui
     end
   end

  vim.cmd('hi '..group..' guifg='..fg..' guibg='..bg..' gui='..gui)

  if attributes.links then
    for _, link in ipairs(attributes.links) do
      vim.cmd('hi! link '..link..' '..group)
    end
  end
end

local highlights = {
  ColorColumn = {
    bg = palette.gray1,
    links = {
      'CursorColumn',
      'CursorLine',
    }
  },
  Comment = {
    fg = palette.gray,
    gui = style.italic,
  },
  Constant = {
    fg = palette.magenta,
    links = {
      'StartifyHeader',
      'diffLine',
    }
  },
  Delimiter = {
    fg = palette.red,
    links = {
      'TSPunctSpecial',
    }
  },
  DiffAdd = {
    fg = palette.green,
    links = {
      'NvimTreeGitStaged',
      'diffAdded',
    }
  },
  DiffChange = {
    fg = palette.cyan,
    links = {
      'NvimTreeGitNew',
    }
  },
  DiffDelete = {
    fg = palette.red,
    links = {
      'IndentBlanklineContextChar',
      'NvimTreeGitDirty',
      'diffRemoved',
    }
  },
  DiffText = {
    fg = palette.yellow,
  },
  Directory = {
    fg = palette.blue,
    links = {
      'NvimTreeFolderName',
      'NvimTreeRootFolder',
    }
  },
  Error = {
    bg = palette.red,
    fg = palette.white,
  },
  ErrorMsg = {
    fg = palette.red,
  },
  Exception = {
    fg = palette.orange,
  },
  ExtraWhitespace = {
    bg = palette.red,
  },
  Function = {
    fg = palette.blue,
  },
  Identifier = {
    fg = palette.green,
    links = {
      'Structure',
    }
  },
  Keyword = {
    fg = palette.blue,
  },
  LineNr = {
    fg = palette.gray,
    links = {
      'FoldColumn',
      'SignColumn',
    }
  },
  MatchParen = {
    fg = palette.magenta,
    gui = {
      style.bold,
      style.underline,
    },
  },
  MoreMsg = {
    fg = palette.yellow,
  },
  NonText = {
    fg = palette.gray2,
    links = {
      'Conceal',
      'SpecialKey',
      'StartifyBracket',
    }
  },
  Normal = {
    fg = palette.white,
    links = {
      'CursorLineNR',
      'ModeMsg',
      'Operator',
      'StartifyFile',
      'StartifySlash',
      'lessVariableValue',
    }
  },
  NvimTreeFolderIcon = {
    fg = palette.gray3,
  },
  Pmenu = {
    bg = palette.gray2,
    fg = palette.white,
  },
  PmenuSBar = {
    bg = palette.black,
    fg = palette.none,
    links = {
      'PmenuThumb',
    }
  },
  PmenuSel = {
    bg = palette.white,
    fg = palette.gray2,
  },
  PreProc = {
    fg = palette.cyan,
    links = {
      'Define',
      'Include',
      'Macro',
      'PreCondit',
    }
  },
  Question = {
    fg = palette.yellow,
    gui = style.bold,
  },
  Search = {
    bg = palette.gray2,
    links = {
      'IncSearch',
    }
  },
  Special = {
    fg = palette.orange,
    links = {
      'SpecialChar',
      'StorageClass',
    }
  },
  SpecialComment = {
    fg = palette.gray,
    gui = {
      style.bold,
      style.italic,
    },
    links = {
      'Folded',
      'Todo',
      'vimCommentTitle',
    }
  },
  Statement = {
    fg = palette.red,
    links = {
      'Conditional',
      'Label',
      'Repeat',
      'helpHyperTextEntry',
    }
  },
  StatusLine = {
    bg = palette.gray1,
    fg = palette.white,
    gui = style.bold,
    links = {
      'MsgSeparator',
    }
  },
  StatusLineNC = {
    bg = palette.gray1,
    fg = palette.gray,
    links = {
      'Tabline',
      'TablineFill',
    }
  },
  String = {
    fg = palette.yellow,
    links = {
      'StringDelimiter',
      'helpExample',
    }
  },
  TablineSel = {
    bg = palette.black,
    fg = palette.white,
    gui = {
      style.bold,
      style.italic,
    },
  },
  Title = {
    fg = palette.green,
    gui = style.bold,
  },
  Type = {
    fg = palette.green,
  },
  TSField = {
    fg = palette.white,
  },
  TSPunctBracket = {
    fg = palette.white,
  },
  TSVariable = {
    fg = palette.white,
  },
  TSVariableBuiltin = {
    fg = palette.blue,
  },
  Underlined = {
    gui = style.underline,
    links = {
      'helpHyperTextJump',
      'helpUrl',
    }
  },
  VertSplit = {
    fg = palette.gray1,
  },
  Visual = {
    bg = palette.gray2,
  },
  WarningMsg = {
    fg = palette.orange,
  },
  WildMenu = {
    bg = palette.gray2,
    fg = palette.blue,
    gui = style.bold,
  },
  modeInsert = {
    bg = palette.gray1,
    fg = palette.green,
    gui = style.bold,
  },
  modeReplace = {
    bg = palette.gray1,
    fg = palette.red,
    gui = style.bold,
  },
  modeVisual = {
    bg = palette.gray1,
    fg = palette.magenta,
    gui = style.bold,
  },
}

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'monokai'

for group, attributes in pairs(highlights) do
  highlight(group, attributes)
end

