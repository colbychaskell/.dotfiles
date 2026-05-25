{
  description = "Personal dotfiles and home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      home-manager,
      ...
    }:
    let
      username = "colbyhaskell";
    in
    {
      darwinConfigurations."Colbys-MacBook-Air" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit username; };
        modules = [
          ./darwin/default.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username;
              homeDirectory = "/Users/${username}";
            };
            home-manager.users.${username}.imports = [
              ./hosts/base.nix
              ./hosts/darwin.nix
              ./hosts/personal.nix
            ];
          }
        ];
      };

      homeConfigurations = {
        "linux-x86_64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./hosts/base.nix
            ./hosts/linux.nix
            ./hosts/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/home/${username}";
          };
        };
        "linux-aarch64@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./hosts/base.nix
            ./hosts/linux.nix
            ./hosts/personal.nix
          ];
          extraSpecialArgs = {
            inherit username;
            homeDirectory = "/home/${username}";
          };
        };
      };

      darwinModules = {
        default = ./darwin/default.nix;
        ghostty = ./darwin/ghostty.nix;
        homebrew = ./darwin/homebrew.nix;
      };

      homeManagerModules = {
        default = ./hosts/base.nix;
        darwin = ./hosts/darwin.nix;
        linux = ./hosts/linux.nix;
        personal = ./hosts/personal.nix;
      };
    };
}
