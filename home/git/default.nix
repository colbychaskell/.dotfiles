{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

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
}
