# Switch to a specific NixOS host
# Usage: switch NixBook

pkgs: {
  switch = pkgs.writeShellApplication {
    name = "switch";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      HOST="''${1:-NixBook}"
      echo "Building host: $HOST"
      exec sudo nixos-rebuild switch --flake ".$HOST" --log-format bar-with-logs
    '';
  };
}
