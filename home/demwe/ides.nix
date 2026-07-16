{ pkgs, ... }:
let
  ides = {
    # Ides
    rider = pkgs.custom.rider;
    clion = pkgs.custom.clion;
    pycharm = pkgs.custom.pycharm;
    rust-rover = pkgs.custom.rust-rover;
    datagrip = pkgs.custom.datagrip;
    webstorm = pkgs.custom.webstorm;
    goland = pkgs.custom.goland;
  };
in
{
  # ~/.ides/<name> → nix store derivation
  # Używamy mapAttrs' aby jawnie zdefiniować pełną ścieżkę jako klucz
  home.file = builtins.listToAttrs (
    builtins.map (name: {
      name = ".ides/${name}";
      value = {
        source = ides.${name};
      };
    }) (builtins.attrNames ides)
  );

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.cabal/bin"
  ]
  ++ (builtins.map (name: "$HOME/.ides/${name}/bin") (builtins.attrNames ides));
}
