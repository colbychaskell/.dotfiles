{ username, ... }:

{
  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    taps = [ "nikitabobko/tap" ];
    casks = [
      "nikitabobko/tap/aerospace"
      "obsidian"
      "raycast"
      "zen"
      "slack"
      "spotify"
      "whatsapp"
      "minecraft"
    ];
  };
}
