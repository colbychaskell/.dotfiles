{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ollama
    tree-sitter
    lua-language-server
    stylua
    pyright
    clang-tools
    marksman
    markdownlint-cli
    prettierd
    imagemagick
  ];

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
