local wezterm = require('wezterm')
local act = wezterm.action
local theme_name = 'Tokyo Night Moon'

local function isVim(pane) return pane:get_foreground_process_name():find('n?vim') ~= nil end

local function vimAwareNavigate(window, pane, pane_direction, vim_direction)
  if isVim(pane) then
    window:perform_action(act.SendKey({ key = vim_direction, mods = 'CTRL' }), pane)
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane) vimAwareNavigate(window, pane, 'Right', 'l') end)
wezterm.on('ActivatePaneDirection-left', function(window, pane) vimAwareNavigate(window, pane, 'Left', 'h') end)
wezterm.on('ActivatePaneDirection-up', function(window, pane) vimAwareNavigate(window, pane, 'Up', 'k') end)
wezterm.on('ActivatePaneDirection-down', function(window, pane) vimAwareNavigate(window, pane, 'Down', 'j') end)

return {
  colors = wezterm.get_builtin_color_schemes()[theme_name],
  color_scheme = theme_name,
  font = wezterm.font('JetbrainsMono NFM'),
  font_size = 13.0,
  keys = {
    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = '/', mods = 'CTRL', action = wezterm.action.SplitPane({ direction = 'Down', size = { Percent = 20 } }) },
    { key = '{', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'SUPER', action = act.ActivateTabRelative(1) },
  },
  tab_bar_at_bottom = true,
  window_decorations = 'RESIZE',
  window_frame = {
    font_size = 11.0,
    active_titlebar_bg = '#1f201b',
    inactive_titlebar_bg = '#1a1b26',
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
