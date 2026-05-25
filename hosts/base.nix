{ config, pkgs, lib, username, homeDirectory, ... }:

{
  imports = [
    ../home/zsh
    ../home/git
    ../home/neovim
    ../home/fzf
    ../home/starship
    ../home/tmux
    ../home/ssh
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "24.05";
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/.local/scripts" ];

  home.packages = with pkgs; [
    curl
    ripgrep
    rustup
    cargo-lambda
    autossh
    fd
    pandoc
    zig
  ];

  programs.home-manager.enable = true;
}
