# Switch to a specific NixOS host
# Usage: switch <hostname> (e.g., switch NixBook, switch ServerName)

pkgs: {
  switch = pkgs.writeShellApplication {
    name = "switch";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      if [ -z "$1" ]; then
        echo "Usage: switch <hostname>"
        echo "Available hosts: NixBook"
        exit 1
      fi
      HOST="$1"
      echo "Building host: $HOST"
      exec sudo nixos-rebuild switch --flake ".$HOST" --log-format bar-with-logs
    '';
  };
}
