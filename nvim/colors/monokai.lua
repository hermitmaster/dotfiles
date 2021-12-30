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
  -- If target is set, assume it's a link and ignore everything else
  if attributes.target then
    vim.cmd('hi! link '..group..' '..attributes.target)
  else
    local fg = attributes.fg and 'guifg = ' .. attributes.fg or 'guifg = NONE'
    local bg = attributes.bg and 'guibg = ' .. attributes.bg or 'guibg = NONE'
    local sp = attributes.sp and 'guisp = ' .. attributes.sp or ''
    local style = attributes.style and 'gui=' .. table.concat(attributes.style, ',') or 'gui=NONE'
    vim.cmd('hi '..group..' '..style..' '..fg..' '..bg..' '.. sp)
  end
end

M.highlights = {
  Boolean = {
    target = 'Contant',
  },
  ColorColumn = {
    bg = M.palette.gray1,
  },
  Comment = {
    fg = M.palette.gray,
    style = {
      M.style.italic,
    }
  },
  Conceal = {
    target = 'NonText',
  },
  Constant = {
    fg = M.palette.magenta,
  },
  CursorColumn = {
    target = 'ColorColumn',
  },
  CursorLine = {
    target = 'ColorColumn',
  },
  CursorLineNr = {
    target = 'Normal',
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
  },
  Error = {
    fg = M.palette.bright_white,
    bg = M.palette.red,
  },
  ErrorMsg = {
    fg = M.palette.bright_white,
    bg = M.palette.red,
  },
  Exception = {
    fg = M.palette.orange,
  },
  ExtraWhitespace = {
    bg = M.palette.red,
  },
  Float = {
    target = 'Contant',
  },
  FoldColumn = {
    target = 'LineNr',
  },
  Folded = {
    target ='SpecialComment'
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
    fg = M.palette.gray
  },
  IncSearch = {
    target = 'Search',
  },
  Macro = {
    target = 'Special',
  },
  MatchParen = {
    fg = M.palette.magenta,
    style = { M.style.bold },
  },
  ModeMsg = {
    target = 'Normal',
  },
  MoreMsg = {
    fg = M.palette.yellow,
  },
  NonText = {
    fg = M.palette.gray2,
  },
  Normal = {
    fg = M.palette.bright_white,
  },
  Number = {
    target = 'Contant',
  },
  Operator = {
    target = 'Normal',
  },
  Pmenu = {
    fg = M.palette.bright_white,
    bg = M.palette.gray2,
  },
  PmenuSBar = {
    bg = M.palette.black,
  },
  PmenuSel = {
    fg = M.palette.gray2,
    bg = M.palette.white,
  },
  PmenuThumb = {
    target = 'PmenuSBar',
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
  },
  SignColumn = {
    target = 'LineNr',
  },
  Special = {
    fg = M.palette.orange,
  },
  SpecialComment = {
    fg = M.palette.gray,
    style = {
      M.style.bold,
      M.style.italic,
    },
  },
  SpecialKey = {
    target = 'NonText',
  },
  Statement = {
    fg = M.palette.red,
  },
  StatusLine = {
    fg = M.palette.bright_white,
    bg = M.palette.gray1,
  },
  StatusLineNC = {
    fg = M.palette.gray,
    bg = M.palette.gray1,
  },
  StorageClass = {
    target = 'Special',
  },
  String = {
    fg = M.palette.yellow,
  },
  StringDelimiter = {
    target = 'String',
  },
  Structure = {
    fg = M.palette.cyan,
  },
  TabLine = {
    fg = M.palette.gray,
    bg = M.palette.gray1,
  },
  TabLineFill = {
    target = 'Tabline'
  },
  TablineSel = {
    fg = M.palette.white,
    bg = M.palette.gray,
  },
  Title = {
    fg = M.palette.green,
    style = {
      M.style.bold,
    },
  },
  Todo = {
    target = 'SpecialComment',
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
    style = {
      M.style.bold,
    },
  },
  helpExample = {
    target = 'String',
  },
  helpHyperTextEntry = {
    target = 'Statement',
  },
  helpHyperTextJump = {
    target = 'Underlined',
  },
  helpURL = {
    target = 'Underlined',
  },
  lessVariableValue = {
    target = 'Normal',
  },
  vimCommentTitle = {
    target = 'SpecialComment',
  },
  NvimTreeRootFolder = {
    target = 'Directory',
  },
  NvimTreeFolderName = {
    target = 'Directory',
  },
  StartifyFile = {
    target = 'Normal',
  },
  StartifySlash = {
    target = 'Normal',
  },
  StartifyHeader = {
    target = 'Constant',
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
