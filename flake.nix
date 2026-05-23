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
        default = ./home-manager/home.nix;
        darwin = ./home-manager/darwin.nix;
        linux = ./home-manager/linux.nix;
        personal = ./home-manager/personal.nix;
      };

      homeConfigurations = {
        "darwin-x86_64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [
            ./home-manager/home.nix
            ./home-manager/darwin.nix
            ./home-manager/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/Users/${username}";
          };
        };
      };
    };
}
