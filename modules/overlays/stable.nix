# Exposes a `pkgs.stable` set pinned to the current release channel
# Useful when mixing `stable` and `unstable` side by side.

final: prev:
let
  # Use the same channel the system is on (fallback to 25.11 if unknown)
  # For reproducibility, you may want to pin to a specific commit instead.
  stableUrl = "https://github.com/NixOS/nixpkgs/archive/nixos-25.11.tar.gz";
  stablePkgs = import (builtins.fetchTarball { url = stableUrl; sha256 = "0iha79h69bvzkkrdgz96nn1yqf23sa7zqw5mf9ayxgppwfsag15d"; }) {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config or {};
  };
in {
  stable = stablePkgs;
}
