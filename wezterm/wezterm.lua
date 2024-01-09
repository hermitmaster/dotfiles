local wezterm = require('wezterm')
local config = wezterm.config_builder()
local theme_name = 'Tokyo Night Moon'

local function isVim(pane) return pane:get_foreground_process_name():find('n?vim') ~= nil end

local function vimAwareNavigate(window, pane, pane_direction, key)
  if isVim(pane) then
    window:perform_action(wezterm.action.SendKey({ key = key, mods = 'CTRL' }), pane)
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function (window, pane) vimAwareNavigate(window, pane, 'Right', 'l') end)
wezterm.on('ActivatePaneDirection-left', function (window, pane) vimAwareNavigate(window, pane, 'Left', 'h') end)
wezterm.on('ActivatePaneDirection-up', function (window, pane) vimAwareNavigate(window, pane, 'Up', 'k') end)
wezterm.on('ActivatePaneDirection-down', function (window, pane) vimAwareNavigate(window, pane, 'Down', 'j') end)

config.colors = wezterm.get_builtin_color_schemes()[theme_name]
config.color_scheme = theme_name
config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 13.0
config.keys = {
  { key = 'h', mods = 'CTRL',  action = wezterm.action.EmitEvent('ActivatePaneDirection-left') },
  { key = 'j', mods = 'CTRL',  action = wezterm.action.EmitEvent('ActivatePaneDirection-down') },
  { key = 'k', mods = 'CTRL',  action = wezterm.action.EmitEvent('ActivatePaneDirection-up') },
  { key = 'l', mods = 'CTRL',  action = wezterm.action.EmitEvent('ActivatePaneDirection-right') },
  { key = '/', mods = 'CTRL',  action = wezterm.action.SplitPane({ direction = 'Down', size = { Percent = 20 } }) },
  { key = '{', mods = 'SUPER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = '}', mods = 'SUPER', action = wezterm.action.ActivateTabRelative(1) },
}
config.tab_bar_at_bottom = true
config.window_decorations = 'RESIZE'
config.window_frame = {
  font_size = 11.0,
  active_titlebar_bg = config.colors.background,
  inactive_titlebar_bg = config.colors.background,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
