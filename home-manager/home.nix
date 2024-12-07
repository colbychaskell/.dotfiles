{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "colbyhaskell";
  home.homeDirectory = "/Users/colbyhaskell";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.go
    pkgs.neovim
    pkgs.alacritty
    pkgs.starship
  ];

  home.file = {
    ".zshrc".source = ../zsh/.zshrc;
    ".gitconfig".source = ../git/.gitconfig;
    ".tmux.conf".source = ../tmux/.tmux.conf;
    ".ssh/config".source = ../ssh/config;

    ".config/nix".source = ../nix;
    ".config/nix-darwin".source = ../nix-darwin;

    ".config/alacritty".source = ../alacritty;
    ".config/nvim".source = ../nvim;
    ".config/starship".source = ../starship;
    ".config/yabai".source = ../yabai;
    ".config/skhd".source = ../skhd;

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
