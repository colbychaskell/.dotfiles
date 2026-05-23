# .dotfiles

Personal dotfiles and home-manager configuration managed with Nix flakes.

## Setup

1. [Install Nix](https://nixos.org/download/)

2. Enable flakes:

   ```sh
   mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

3. Clone this repo
4. First-time apply (bootstraps home-manager):

```sh
nix run home-manager -- switch --flake .#darwin-x86_64@personal
```

After that, just use:

```sh
./switch.sh
```
