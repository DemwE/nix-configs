# Define the target and backup paths
TARGET="/etc/nixos"
BACKUP="/etc/nixos.bak"
CURRENT_DIR=$(pwd)

echo "Current path is: $CURRENT_DIR"
read -p "Is this the correct path for your NixOS configuration? (y/n): " confirm

if [[ $confirm != [yY] ]]; then
    echo "Operation cancelled by user."
    exit 1
fi

# Create backup
echo "Moving $TARGET to $BACKUP..."
sudo mv "$TARGET" "$BACKUP"

# Create symbolic link
echo "Creating symbolic link from $CURRENT_DIR to $TARGET..."
sudo ln -s "$CURRENT_DIR" "$TARGET"

echo "Done! Your NixOS configuration is now linked to $CURRENT_DIR"