{ lib, ... }:

{
  programs.zsh = {
    enable = true;
    history = {
      size = 100000;
      save = 100000;
      ignoreSpace = true;
      ignoreDups = true;
      share = true;
    };
    defaultKeymap = "viins";
    setOptions = [ "extended_glob" "null_glob" ];
    shellAliases = {
      v = "nvim";
      t = "tmux";
      ls = "ls --color=auto";
      la = "ls -lathr";
      dot = "cd $DOTFILES";
      gh = "cd $GHREPOS";
      lastmod = ''find . -type f -not -path "*/\.*" -exec ls -lrt {} +'';
      "in" = ''cd $ZETTELKASTEN/0\ Inbox/'';
    };
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      SNACKS_TMUX = "true";
      REPOS = "$HOME/src";
      GHREPOS = "$HOME/src/github.com";
      DOTFILES = "$HOME/src/github.com/colbychaskell/.dotfiles";
      SCRIPTS = "$HOME/.local/scripts";
      ZETTELKASTEN = "$HOME/Zettelkasten";
      GOBIN = "$HOME/.local/bin";
      VCPKG_ROOT = "$HOME/vcpkg";
      MANPAGER = "nvim +Man!";
    };
    initContent = ''
      zstyle ':completion:*' menu select

      # tmux auto-launch in SSH sessions only
      if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
        tmux attach -t TMUX || tmux new -s TMUX
      fi
    '';
  };
}
