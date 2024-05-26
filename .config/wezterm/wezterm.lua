-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.75
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

-- Font
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "DemiBold",
	},
	"Segoe UI Emoji",
})
config.font_size = 11

-- Window
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.win32_system_backdrop = "Acrylic"
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Colors
config.colors = require("cyberdream")
config.force_reverse_video_cursor = true

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = transparent_bg,
	active_tab = {
		bg_color = transparent_bg,
		fg_color = "#ffffff",
	},
	inactive_tab = {
		bg_color = transparent_bg,
		fg_color = "#7b8496",
	},
	inactive_tab_hover = {
		bg_color = transparent_bg,
		fg_color = "#ffffff",
	},
	new_tab = {
		bg_color = transparent_bg,
		fg_color = "#ffffff",
	},
}

-- SSH
-- This is an example of SSH Domain setup.
-- This will create a new connection with `wezterm connect my.server`

config.ssh_domains = {
	{
		-- This name identifies the domain
		name = "my.server",
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = "192.168.1.1",
		-- The username to use on the remote host
		username = "wez",
	},
}

return config
