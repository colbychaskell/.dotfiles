{
  description = "Darwin configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.tmux
        pkgs.glow
        pkgs.skhd
        pkgs.yabai
        pkgs.cmatrix
        pkgs.python3
        pkgs.poetry
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      services.yabai.enable = true;
      services.skhd.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";

      # Use touch ID for sudo
      security.pam.enableSudoTouchIdAuth = true;

      # Home Manager setup
      users.users.colbyhaskell = {
        name = "colbyhaskell";
        home = "/Users/colbyhaskell";
      };

      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Colbys-MacBook-Pro-3
    darwinConfigurations."Colbys-MacBook-Pro-3" = nix-darwin.lib.darwinSystem {
      modules = [
          configuration
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.colbyhaskell = import ../home-manager/home.nix;
          }
        ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Colbys-MacBook-Pro-3".pkgs;
  };
}
