{ lib, ... }:

{
  programs.git.ignores = [
    "*~"
    ".nfs*"
  ];
}
