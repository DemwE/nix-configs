# Update flake lock file
# Usage: update-lock

pkgs: {
  update-lock = pkgs.writeShellApplication {
    name = "update-lock";
    text = ''
      echo "Updating flake lock..."
      exec nix --extra-experimental-features flakes flake update
    '';
  };
}
