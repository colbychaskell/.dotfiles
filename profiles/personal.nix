{ pkgs, ... }:

{
  programs.git.userEmail = "chaskell35@gmail.com";

  home.packages = with pkgs; [
    claude-code
  ];
}
