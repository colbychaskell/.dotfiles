{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

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
    pkgs.tree-sitter
    pkgs.curl
    pkgs.neovim
    pkgs.starship
    pkgs.stow
    pkgs.fzf
    pkgs.ripgrep
    pkgs.tmux
  ];

  # Use stow to copy files instead of home-manager (leave this empty)
  home.file = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
