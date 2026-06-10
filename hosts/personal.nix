{ pkgs, ... }:

{
  programs.git.settings.user.email = "chaskell35@gmail.com";

  home.packages = with pkgs; [
    claude-code
  ];
}
