local plenary_path = require('plenary.path')

--- @param sc string
--- @param txt string
--- @optional keybind string
--- @optional keybind_opts table
local function button(sc, txt, keybind, keybind_opts)
  local leader = 'SPC'
  local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = 'Keyword',
  }

  if keybind then
    keybind_opts = keybind_opts or { noremap = true, silent = true, nowait = true }
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local cdir = vim.fn.getcwd()

local nvim_web_devicons = {
  enabled = true,
  highlight = true,
}

local function get_extension(fn)
  local match = fn:match('^.+(%..+)$')
  local ext = ''

  if match ~= nil then ext = match:sub(2) end

  return ext
end

local function icon(fn)
  local ext = get_extension(fn)

  return require('nvim-web-devicons').get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn)
  short_fn = short_fn or fn
  local ico_txt
  local fb_hl = {}

  local ico, hl = icon(fn)
  local hl_option_type = type(nvim_web_devicons.highlight)

  if hl_option_type == 'boolean' then
    table.insert(fb_hl, { hl, 0, 3 })
  elseif hl_option_type == 'string' then
    table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
  end

  ico_txt = ico .. '  '

  local file_button_el = button(sc, ico_txt .. short_fn, '<cmd>e ' .. fn .. ' <CR>')
  local fn_start = short_fn:match('.*/')

  if fn_start ~= nil then table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt }) end

  file_button_el.opts.hl = fb_hl

  return file_button_el
end

local default_mru_ignore = { 'gitcommit' }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
}

--- @param start number
--- @param cwd string optional
--- @optional items_number number optional number of items to generate, default = 10
--- @optional opts
local function mru(start, cwd, items_number, opts)
  opts = opts or mru_opts
  items_number = items_number or 10

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then break end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then oldfiles[#oldfiles + 1] = v end
  end
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ':.')
    else
      short_fn = vim.fn.fnamemodify(fn, ':~')
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then short_fn = plenary_path.new(short_fn):shorten(1, { -1 }) end
    end

    local shortcut = tostring(i + start - 1)

    local file_button_el = file_button(fn, shortcut, short_fn)
    tbl[i] = file_button_el
  end
  return {
    type = 'group',
    val = tbl,
    opts = {},
  }
end

local config = {
  layout = {
    { type = 'padding', val = 2 },
    {
      type = 'text',
      val = {
        [[                            _         ]],
        [[     ____  ___  ____ _   __(_)___ ___ ]],
        [[    / __ \/ _ \/ __ \ | / / / __ `__ \]],
        [[   / / / /  __/ /_/ / |/ / / / / / / /]],
        [[  /_/ /_/\___/\____/|___/_/_/ /_/ /_/ ]],
      },
      opts = {
        hl = 'WarningMsg',
        position = 'center',
        shrink_margin = false,
      },
    },
    { type = 'padding', val = 2 },
    {
      type = 'group',
      val = {
        {
          type = 'text',
          val = 'Recent files',
          opts = {
            hl = 'Statement',
            shrink_margin = false,
            position = 'center',
          },
        },
        { type = 'padding', val = 1 },
        {
          type = 'group',
          val = function() return { mru(0, cdir) } end,
          opts = { shrink_margin = false },
        },
      },
    },
    { type = 'padding', val = 2 },
    {
      type = 'group',
      val = {
        {
          type = 'text',
          val = 'Quick links',
          opts = { hl = 'Statement', position = 'center' },
        },
        { type = 'padding', val = 1 },
        button('e', '  New file', '<cmd>ene<CR>'),
        button('SPC f f', '  Find file'),
        button('SPC g g', '  Live grep'),
        button('c', '  Configuration', '<cmd>cd ~/.config/nvim/ <CR>'),
        button('u', '  Update plugins', '<cmd>PackerSync<CR>'),
        button('q', '  Quit', '<cmd>qa<CR>'),
      },
      position = 'center',
    },
    { type = 'padding', val = 2 },
    {
      type = 'text',
      val = require('alpha.fortune')(),
      opts = {
        position = 'center',
        hl = 'Comment',
      },
    },
  },
  opts = {
    margin = 5,
    setup = function()
      vim.api.nvim_create_autocmd('DirChanged', {
        group = 'alpha_temp',
        callback = function() require('alpha').redraw() end,
      })
    end,
  },
}

return {
  config = config,
  nvim_web_devicons = nvim_web_devicons,
}
