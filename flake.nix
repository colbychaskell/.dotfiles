{
  description = "Personal dotfiles and home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      username = "colbyhas";
    in
    {
      homeManagerModules = {
        default = ./profiles/base.nix;
        darwin = ./profiles/darwin.nix;
        linux = ./profiles/linux.nix;
        personal = ./profiles/personal.nix;
      };

      homeConfigurations = {
        "darwin-x86_64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./profiles/base.nix
            ./profiles/darwin.nix
            ./profiles/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/Users/${username}";
          };
        };
      };
    };
}
