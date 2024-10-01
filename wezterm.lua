-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font 'Source Code Pro'
config.font_size = 13.0

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95
config.window_frame = {
  font = wezterm.font 'Verdana',
  font_size = 12.0
}

-- For example, changing the color scheme:
config.color_scheme = 'Dracula'

-- and finally, return the configuration to wezterm
return config
