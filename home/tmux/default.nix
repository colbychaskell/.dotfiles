{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  home.file = {
    ".config/tmux/tmux.conf".source = ./tmux.conf;
    ".local/bin/tmux-sessionizer" = {
      source = ./tmux-sessionizer;
      executable = true;
    };
    ".local/bin/tmux-window-fzf" = {
      source = ./tmux-window-fzf;
      executable = true;
    };
  };
}
