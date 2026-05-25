{ pkgs, lib, ... }:

{
  imports = [
    ../home/aerospace
    ../home/ghostty
  ];

  home.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.jetbrains-mono
  ];

  home.sessionPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

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
