{ config, pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    tree-sitter
    curl
    neovim
    fzf
    starship
    ripgrep
    tmux
    lazygit
  ];

  home.file = {
    ".config/nvim" = {
      source = ../nvim;
      recursive = true;
    };
    ".config/ghostty".source = ../ghostty;
    ".config/starship/starship.toml".source = ../starship/starship.toml;
    ".config/tmux/tmux.conf".source = ../tmux/tmux.conf;
    ".ssh/config".source = ../ssh/config;
  };

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
    shellAliases = {
      v = "nvim";
      t = "tmux";
      ls = "ls --color=auto";
      la = "ls -lathr";
      repos = "cd $REPOS";
      ghrepos = "cd $GHREPOS";
      dot = "cd $GHREPOS/colbychaskell/dotfiles";
      lastmod = ''find . -type f -not -path "*/\.*" -exec ls -lrt {} +'';
      "in" = ''cd $ZETTELKASTEN/0\ Inbox/'';
    };
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      REPOS = "$HOME/Repos";
      GHREPOS = "$HOME/Repos/github.com";
      SCRIPTS = "$HOME/.local/scripts";
      ZETTELKASTEN = "$HOME/Zettelkasten";
      GOBIN = "$HOME/.local/bin";
      GOPRIVATE = "*.gitlab.com/*";
      GOPATH = "$HOME/go/";
      VCPKG_ROOT = "$HOME/vcpkg";
      MANPAGER = "nvim +Man!";
      STARSHIP_CONFIG = "~/.config/starship/starship.toml";
    };
    initExtraFirst = ''
      setopt extended_glob null_glob

      path=(
        $path
        $HOME/.local/bin
        $SCRIPTS
      )

      typeset -U path
      path=($^path(N-/))
      export PATH
    '';
    initExtra = ''
      # Starship prompt
      eval "$(starship init zsh)"

      # fzf
      source <(fzf --zsh)

      # Local aliases
      if [ -f "$XDG_CONFIG_HOME/zsh/.zsh_aliases" ]; then
        source "$XDG_CONFIG_HOME/zsh/.zsh_aliases" > /dev/null
      fi

      # Completions
      fpath+=~/.zfunc
      zstyle ':completion:*' menu select

      # tmux auto-launch in SSH sessions only
      if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
        tmux attach -t TMUX || tmux new -s TMUX
      fi
    '';
  };

  home.sessionVariables = { };

  programs.git = {
    enable = true;
    userName = "Colby Haskell";
    ignores = [
      "*.swp"
      ".direnv/"
    ];
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
      color.ui = "auto";
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}
