-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Your configuration goes in here 
local config = wezterm.config_builder()

-- Setup Nerd Font SauceCodePro
config.font = wezterm.font("SauceCodePro NFM SemiBold")
config.font_size = 20

-- Color Scheme & Appearance
config.color_scheme = "Abernathy"
config.window_background_opacity = 0.96
config.macos_window_background_blur = 16

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_padding = { top = 20, right = 22, bottom = 15, left = 25 }

config.automatically_reload_config = true

-- Important for Pipe, geschwungene Klammer etc.
config.send_composed_key_when_left_alt_is_pressed = true

-- ======================
-- macOS-ähnliche Keybindings
-- ======================

config.keys = {
  -- Option + LeftArrow  → ein Wort zurück (wie im normalen macOS Terminal)
  { key = 'LeftArrow',  mods = 'OPT', action = act.SendString '\x1bb' },

  -- Option + RightArrow → ein Wort vor (wie im normalen macOS Terminal)
  { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },

  -- Optional, aber sehr praktisch:
  -- Command + LeftArrow  → Zeilenanfang
  -- Command + RightArrow → Zeilenende
  { key = 'LeftArrow',  mods = 'CMD', action = act.SendString '\x1ba' },  -- Ctrl+A
  { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x1be' },  -- Ctrl+E
}

return config