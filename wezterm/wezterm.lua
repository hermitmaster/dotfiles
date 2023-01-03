local wezterm = require('wezterm')
local act = wezterm.action

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
  color_scheme = 'Monokai',
  font = wezterm.font('Hack Nerd Font Mono'),
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

  colors = {
    tab_bar = {
      active_tab = {
        bg_color = '#fd971f',
        fg_color = '#1f201b',
      },

      inactive_tab = {
        bg_color = '#1f201b',
        fg_color = '#fd971f',
      },
      inactive_tab_edge = '#3c3d38',
      inactive_tab_hover = {
        bg_color = '#3c3d38',
        fg_color = '#fd971f',
        italic = true,
      },
      new_tab = {
        bg_color = '#1b1032',
        fg_color = '#fd971f',
      },

      new_tab_hover = {
        bg_color = '#fd971f',
        fg_color = '#1b1032',
      },
    },
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
