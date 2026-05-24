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
        default = ./hosts/base.nix;
        darwin = ./hosts/darwin.nix;
        linux = ./hosts/linux.nix;
        personal = ./hosts/personal.nix;
      };

      homeConfigurations = {
        "darwin-x86_64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./hosts/base.nix
            ./hosts/darwin.nix
            ./hosts/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/Users/${username}";
          };
        };
        "darwin-aarch64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./hosts/base.nix
            ./hosts/darwin.nix
            ./hosts/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/Users/${username}";
          };
        };
      };
    };
}
