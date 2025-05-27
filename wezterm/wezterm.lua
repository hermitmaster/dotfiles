local wezterm = require("wezterm")
local config = wezterm.config_builder()
local directions = {
  right = "l",
  left = "h",
  up = "k",
  down = "j",
}

local function isVim(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function vimAwareNavigate(window, pane, pane_direction, key)
  if isVim(pane) then
    window:perform_action(wezterm.action.SendKey({ key = key, mods = "CTRL" }), pane)
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

config.keys = config.keys or {}
for direction, key in pairs(directions) do
  wezterm.on("ActivatePaneDirection-" .. direction, function(window, pane)
    vimAwareNavigate(window, pane, direction:gsub("^%l", string.upper), key)
  end)
  table.insert(config.keys, {
    key = key,
    mods = "CTRL",
    action = wezterm.action.EmitEvent("ActivatePaneDirection-" .. direction),
  })
end

-- Add other static keybindings
for _, k in ipairs({
  { key = "/", mods = "CTRL", action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 20 } }) },
  { key = "{", mods = "SUPER", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "}", mods = "SUPER", action = wezterm.action.ActivateTabRelative(1) },
}) do
  table.insert(config.keys, k)
end

config.colors = wezterm.get_builtin_color_schemes()["Tokyo Night Moon"]
config.font_size = 13.0
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
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
