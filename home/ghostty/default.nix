{ pkgs, ... }:

{
  programs.ghostty = {
    package = null;
    enable = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 11;
      theme = "Everforest Dark Hard";

      # Transparency effect
      background-opacity = 0.90;
      background-blur = true;
      macos-titlebar-style = "transparent";

      # Turn on clipboard support
      clipboard-read = "allow";
      clipboard-write = "allow";

      # Shortcuts (Nix uses lists for keybinds)
      keybind = [
        "super+r=reload_config"
      ];

      window-save-state = "always";
    };
  };
}
