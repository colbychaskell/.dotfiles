{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    tree-sitter
    lua-language-server
    stylua
    pyright
    clang-tools
    marksman
    markdownlint-cli
    prettierd
  ];

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
