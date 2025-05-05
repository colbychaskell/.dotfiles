-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.8
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

-- Font Configuration
local emoji_font = "Segoe UI Emoji"
config.font = wezterm.font_with_fallback({
  {
    family = "BlexMono Nerd Font",
    weight = "Regular",
  },
  emoji_font,
})
config.font_size = 10

-- Color Configuration
config.colors = require("cyberdream")
config.force_reverse_video_cursor = true

-- Window Configuration
-- This will get handled by aerospace anyways
-- config.initial_rows = 45
-- config.initial_cols = 180

-- I hide the buttons because aerospace handles the windows anyways
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.macos_window_background_blur = 40
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
  background = transparent_bg,
  new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
  new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

-- Tab Formatting
wezterm.on("format-tab-title", function(tab, _, _, _, hover)
  local background = config.colors.brights[1]
  local foreground = config.colors.foreground

  if tab.is_active then
    background = config.colors.brights[7]
    foreground = config.colors.background
  elseif hover then
    background = config.colors.brights[8]
    foreground = config.colors.background
  end

  local title = tostring(tab.tab_index + 1)
  return {
    { Foreground = { Color = background } },
    { Text = "█" },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Foreground = { Color = background } },
    { Text = "█" },
  }
end)

-- Keybindings
--
-- Default keybindings of note:
--   SUPER-t: New tab
--   SUPER-w: Close tab

return config
