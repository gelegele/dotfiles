-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font 'Cica'
config.font_size = 15
-- https://wezfurlong.org/wezterm/colorschemes/index.html
-- config.color_scheme = 'Espresso'
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'Monokai (dark) (terminal.sexy)'
config.window_background_opacity = 0.98
config.window_close_confirmation = 'NeverPrompt'

-- and finally, return the configuration to wezterm
return config
