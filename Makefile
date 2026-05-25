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
	@echo "  install-nix          - Install the Nix package manager"
	@echo "  install-nix-darwin   - Install nix-darwin for the first time"
	@echo "  darwin-rebuild       - Rebuild the nix-darwin configuration"
	@echo "  nix-gc               - Run Nix garbage collection"
	@echo "  flake-update         - Update flake inputs"
	@echo "  flake-check          - Check the flake for issues"

ifeq ($(OS),darwin)
.PHONY: apply
apply: darwin-rebuild
else
.PHONY: apply
apply:
	nix run home-manager -- switch --flake ".#$(CONFIG)" -b backup
endif

.PHONY: darwin-rebuild
darwin-rebuild:
	darwin-rebuild switch --flake "$(FLAKE)"

.PHONY: flake-update
flake-update:
	nix flake update

.PHONY: flake-check
flake-check:
	nix flake check

.PHONY: nix-gc
nix-gc:
	nix-collect-garbage -d

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
