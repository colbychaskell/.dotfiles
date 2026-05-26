OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)

ifeq ($(ARCH),arm64)
  ARCH := aarch64
endif

CONFIG := $(OS)-$(ARCH)@personal

# Variables (override these as needed)
HOSTNAME ?= $(shell hostname -s)
FLAKE ?= .#$(HOSTNAME)
EXPERIMENTAL ?= --extra-experimental-features "nix-command flakes"

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  apply                - Detect OS and apply either hm or darwin config"
	@echo "  home-manager-switch  - Rebuild the home manager configuration"
	@echo "  darwin-rebuild       - Rebuild the nix-darwin configuration"
	@echo "  nix-gc               - Run Nix garbage collection"
	@echo "  flake-update         - Update flake inputs"
	@echo "  flake-check          - Check the flake for issues"
	@echo "  install-nix          - Install the Nix package manager"
	@echo "  install-nix-darwin   - Install nix-darwin for the first time"

# Use nix-darwin on mac or home manager on linux
ifeq ($(OS),darwin)
.PHONY: apply
apply: darwin-rebuild
else
.PHONY: apply
apply: home-manager-switch
endif

.PHONY: home-manager-switch
home-manager-switch:
	@echo "Rebuilding home manager configuration..."
	@nix run home-manager -- switch --flake ".#$(CONFIG)" -b backup
	@echo "Home Manager switch complete."

.PHONY: darwin-rebuild
darwin-rebuild:
	@echo "Rebuilding darwin configuration..."
	@sudo darwin-rebuild switch --flake $(FLAKE)
	@echo "Darwin rebuild complete."

.PHONY: flake-update
flake-update:
	@echo "Updating flake inputs..."
	@nix flake update
	@echo "Flake update complete."

.PHONY: flake-check
flake-check:
	@echo "Checking flake..."
	@nix flake check
	@echo "Flake check complete."

.PHONY: nix-gc
nix-gc:
	@echo "Collecting Nix garbage..."
	@sudo nix-collect-garbage -d
	@echo "Garbage collection complete."

.PHONY: install-nix
install-nix:
	@echo "Installing Nix..."
	@curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
	@echo "Nix installation complete."

.PHONY: install-nix-darwin
install-nix-darwin:
	@echo "Installing nix-darwin..."
	@sudo nix $(EXPERIMENTAL) run nix-darwin#darwin-rebuild -- switch --flake "$(FLAKE)"
	@echo "nix-darwin installation complete."
