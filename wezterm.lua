-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- Font configuration
-- config.font = wezterm.font('Bitstream Vera Sans Mono')
-- config.font = wezterm.font('Cascadia Mono NF')
-- config.font = wezterm.font('Departure Mono')
config.font = wezterm.font('IBM Plex Mono')
-- config.font = wezterm.font('Monaspace Argon', { weight = 'Regular' })
-- config.font = wezterm.font('Monaspace Krypton', { weight = 'Regular' })
-- config.font = wezterm.font('Monaspace Neon', { weight = 'Regular' })
-- config.font = wezterm.font('Monocraft')
-- config.font = wezterm.font('PT Mono')
-- config.font = wezterm.font('Px437 IBM VGA 9x16')
-- config.font = wezterm.font('Source Code Pro', { weight = 'Medium' })
-- config.font = wezterm.font('Zed Mono')

config.font_size = 13.0
config.freetype_load_target = 'Normal'
-- config.freetype_load_target = 'HorizontalLcd'

-- Window configuration
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_background_opacity = 1.0
config.window_frame = {
  font = wezterm.font 'Verdana',
  font_size = 12.0
}

-- Improve font rendering by using the WebGPU
config.front_end = "WebGpu"

-- Color scheme
config.color_scheme = 'Dracula'

-- Launch zellij by default, but as part of fish, so we get the environment set up
config.default_prog = { os.getenv('SHELL'), '-c', 'zellij' }

-- and finally, return the configuration to wezterm
return config
