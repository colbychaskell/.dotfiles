# .dotfiles

Personal dotfiles and home-manager configuration managed with Nix flakes.

## Setup

1. [Install Nix](https://nixos.org/download/)

2. Clone this repo to `~/.dotfiles`

3. Apply:

   ```sh
   make apply
   ```

## Usage

```sh
make apply   # rebuild home-manager config
make update  # update flake inputs
```

## macOS Casks

GUI apps are managed manually via Homebrew. Install them with:

```sh
brew bundle --file=Brewfile
```
