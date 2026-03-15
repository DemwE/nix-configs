# Exposes a `pkgs.stable` set pinned to the current release channel
# Useful when mixing `stable` and `unstable` side by side.

{ inputs, final, prev }:
let
  stablePkgs = import inputs.stable {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config or {};
  };
in {
  stable = stablePkgs;
}
