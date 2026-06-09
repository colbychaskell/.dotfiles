{ pkgs, ... }:

{
  programs.git.settings.user.email = "chaskell35@gmail.com";

  home.packages = with pkgs; [
    claude-code
  ];

  home.file.".config/ghostty/auto-tmux".text = ''
    command = /bin/zsh -l -c "tmux new-session -A -s main"
  '';
}
