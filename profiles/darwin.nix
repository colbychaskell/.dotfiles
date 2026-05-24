{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    ".config/aerospace/aerospace.toml".source = ../config/aerospace/aerospace.toml;
  };

  programs.zsh.initContent = lib.mkAfter ''
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
    settings.credential.helper = "osxkeychain";
  };
}
