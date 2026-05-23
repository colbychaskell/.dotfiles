# .dotfiles

Personal dotfiles and home-manager configuration managed with Nix flakes.

## Setup

1. [Install Nix](https://nixos.org/download/)

2. Enable flakes:

   ```sh
   mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

3. Clone this repo
4. Apply:

```sh
./switch.sh
```
