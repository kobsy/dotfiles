-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- Font configuration
-- config.font = wezterm.font('Source Code Pro', { weight = 'Medium' })
-- config.font = wezterm.font('Cascadia Mono NF')
-- config.font = wezterm.font('Zed Mono')
config.font = wezterm.font('Monaspace Neon', { weight = 'Regular' })
-- config.font = wezterm.font('Bitstream Vera Sans Mono')
-- config.font = wezterm.font('Monocraft')
-- config.font = wezterm.font('Px437 IBM VGA 9x16')

config.font_size = 13.0

-- Window configuration
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_background_opacity = 1.0
config.window_frame = {
  font = wezterm.font 'Verdana',
  font_size = 12.0
}

-- Color scheme
config.color_scheme = 'Dracula'

-- Launch zellij by default, but as part of fish, so we get the environment set up
config.default_prog = { os.getenv('SHELL'), '-c', 'zellij' }

-- and finally, return the configuration to wezterm
return config
