#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$HOME/nix-configs"
NIXOS_SRC="/etc/nixos"
HOME_MANAGER_SRC="$HOME/.config/home-manager"
NIXOS_DEST="$REPO_DIR/nixos"
HM_DEST="$REPO_DIR/home-manager"

echo "==> Cleaning old data in the repo"
sudo chmod -R a+rw "$NIXOS_DEST" "$HM_DEST"
rm -rf "$NIXOS_DEST" "$HM_DEST"
mkdir -p "$NIXOS_DEST" "$HM_DEST"

echo "==> Copying /etc/nixos → $NIXOS_DEST"
sudo cp -rT "$NIXOS_SRC" "$NIXOS_DEST"

echo "==> Copying ~/.config/home-manager → $HM_DEST"
cp -rT "$HOME_MANAGER_SRC" "$HM_DEST"

echo "==> Adding changes to git"
cd "$REPO_DIR"
git add nixos/ home-manager/
git status

echo "✅ Done! Current configurations have been copied into the repository."

