{ pkgs, ... }:

{
  home.file = {
    ".config/aerospace/aerospace.toml".source = ../aerospace/aerospace.toml;
  };

  programs.zsh.initExtra = ''
    # Brew completions
    if type brew &>/dev/null; then
      FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    fi
  '';

  programs.git = {
    ignores = [
      ".DS_Store"
      "._*"
    ];
    extraConfig = {
      credential.helper = "osxkeychain";
    };
  };
}
