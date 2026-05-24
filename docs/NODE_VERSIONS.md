# Managing Node Versions with Nix

## Global Default

`nodejs_24` is installed globally via the Amazon work dotfiles (`DotFiles-colbyhas`). This is available in all shells without any extra setup.

## Per-Project Versions

For projects that need a different Node version, add a `.envrc` file to the project root. `.envrc` and `.direnv/` are globally gitignored so these won't pollute project repos.

### Simple (single package)

```bash
# .envrc
use flake "nixpkgs#nodejs_20"
```

### Multiple dependencies

```bash
# .envrc
use flake --impure --expr '{pkgs ? import <nixpkgs> {}}: pkgs.mkShell { packages = [pkgs.nodejs_20 pkgs.yarn]; }'
```

### Using a project's own flake

If the project has a `flake.nix` with a devShell:

```bash
# .envrc
use flake
```

## Setup

After adding a `.envrc`, run `direnv allow` in the project directory. The Node version activates automatically on `cd`.

## Available Versions

Check what's in nixpkgs:

```bash
nix-env -qaP 'nodejs_*'
```

Common packages: `nodejs_18`, `nodejs_20`, `nodejs_22`, `nodejs_24`.
