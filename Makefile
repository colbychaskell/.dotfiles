.PHONY: all stow

# These targets assume you have already installed nix and home-manager
all: stow

stow:
	@echo "Installing dotfiles..."
	stow . --target ~/.config
