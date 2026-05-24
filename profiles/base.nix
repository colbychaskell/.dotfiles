{ config, pkgs, lib, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    tree-sitter
    curl
    neovim
    fzf
    starship
    ripgrep
    tmux
    lazygit
    rustup
    lua-language-server
    stylua
    pyright
    clang-tools
    marksman
    markdownlint-cli
    prettierd
    autossh
  ];

  home.file = {
    ".config/nvim" = {
      source = ../config/nvim;
      recursive = true;
    };
    ".config/ghostty".source = ../config/ghostty;
    ".config/starship/starship.toml".source = ../config/starship/starship.toml;
    ".config/tmux/tmux.conf".source = ../config/tmux/tmux.conf;
    ".ssh/config".source = ../config/ssh/config;
    ".local/bin/tmux-sessionizer" = {
      source = ../config/scripts/tmux-sessionizer;
      executable = true;
    };
    ".local/bin/tmux-window-fzf" = {
      source = ../config/scripts/tmux-window-fzf;
      executable = true;
    };
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
      SNACKS_TMUX = "true";
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
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        setopt extended_glob null_glob

        path=(
          $path
          $HOME/.local/bin
          $SCRIPTS
        )

        typeset -U path
        path=($^path(N-/))
        export PATH
      '')
      ''
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
      ''
    ];
  };

  home.sessionVariables = { };

  programs.git = {
    enable = true;
    ignores = [
      "*.swp"
      ".direnv/"
      ".envrc"
    ];
    settings = {
      user.name = "Colby Haskell";
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
      color.ui = "auto";
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      pull.rebase = true;
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      difftool."nvimdiff".cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
    };
  };

  programs.home-manager.enable = true;
}
