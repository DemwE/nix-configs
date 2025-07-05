#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$HOME/nix-configs"
NIXOS_SRC="/etc/nixos"
HOME_MANAGER_SRC="$HOME/.config/home-manager"
NIX_SHELLS_SRC="$HOME/nix-shells"
NIXOS_DEST="$REPO_DIR/nixos"
HM_DEST="$REPO_DIR/home-manager"
NIX_SHELLS_DEST="$REPO_DIR/nix-shells"

echo "==> Cleaning old data in the repo"
sudo chmod -R a+rw "$NIXOS_DEST" "$HM_DEST" "$NIX_SHELLS_DEST"
rm -rf "$NIXOS_DEST" "$HM_DEST" "$NIX_SHELLS_DEST"
mkdir -p "$NIXOS_DEST" "$HM_DEST" "$NIX_SHELLS_DEST"

echo "==> Copying /etc/nixos → $NIXOS_DEST"
sudo cp -rT "$NIXOS_SRC" "$NIXOS_DEST"

echo "==> Copying ~/.config/home-manager → $HM_DEST"
cp -rT "$HOME_MANAGER_SRC" "$HM_DEST"

echo "==> Copying ~/nix-shells → $NIX_SHELLS_DEST"
cp -rT "$NIX_SHELLS_SRC" "$NIX_SHELLS_DEST"

echo "==> Adding changes to git"
cd "$REPO_DIR"
git add nixos/ home-manager/ nix-shells/
git status

echo "✅ Done! Current configurations have been copied into the repository."
