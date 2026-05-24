OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)

ifeq ($(ARCH),arm64)
  ARCH := aarch64
endif

CONFIG := $(OS)-$(ARCH)@personal

.PHONY: all
all: apply brew

.PHONY: apply
apply:
	nix run home-manager -- switch --flake ".#$(CONFIG)" -b backup

.PHONY: brew
brew:
	brew bundle --file=$(HOME)/.config/brew/Brewfile

.PHONY: update
update:
	nix flake update
