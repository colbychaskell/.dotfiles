#!/bin/sh
os=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)

case "$os" in
  darwin) os="darwin" ;;
  linux)  os="linux" ;;
  *)      echo "Unsupported OS: $os" && exit 1 ;;
esac

case "$arch" in
  arm64) arch="aarch64" ;;
esac

home-manager switch --flake ".#${os}-${arch}@personal"
