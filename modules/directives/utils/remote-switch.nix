# Switch to a specific NixOS host while building on an explicit remote builder.
# Usage:
#   remote-switch <host> <user@ip> [system] [maxJobs] [speedFactor] [supportedFeatures]
# Example:
#   remote-switch NixBook demwe@192.168.7.151
#   remote-switch NixBook demwe@192.168.7.151 x86_64-linux 16 2 kvm,big-parallel

pkgs: {
  remote-switch = pkgs.writeShellApplication {
    name = "remote-switch";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      set -euo pipefail

      if [ "$#" -lt 2 ]; then
        echo "Usage: remote-switch <host> <user@ip> [system] [maxJobs] [speedFactor] [supportedFeatures]"
        echo "Example: remote-switch NixBook demwe@192.168.7.151"
        exit 1
      fi

      HOST="$1"
      BUILDER="$2"
      SYSTEM="''${3:-x86_64-linux}"
      MAX_JOBS="''${4:-auto}"
      SPEED_FACTOR="''${5:-1}"
      SUPPORTED_FEATURES="''${6:-}"

      if [ "$MAX_JOBS" = "auto" ]; then
        MAX_JOBS="-"
      fi

      BUILDERS_LINE="ssh-ng://$BUILDER $SYSTEM - $MAX_JOBS $SPEED_FACTOR"
      if [ -n "$SUPPORTED_FEATURES" ]; then
        BUILDERS_LINE="$BUILDERS_LINE $SUPPORTED_FEATURES"
      fi

      echo "Building host: $HOST"
      echo "Remote builder: $BUILDERS_LINE"

      exec env NIX_CONFIG="builders = $BUILDERS_LINE" \
        sudo nixos-rebuild switch --flake "/etc/nixos#$HOST" --log-format bar-with-logs
    '';
  };
}