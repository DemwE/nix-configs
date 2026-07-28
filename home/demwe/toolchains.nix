{ pkgs, ... }:
let
  toolchains = {
    # Toolchains
    cpp     = pkgs.custom.toolchain-cpp;
    rust    = pkgs.custom.toolchain-rust;
    python  = pkgs.custom.toolchain-python;
    dotnet  = pkgs.custom.toolchain-dotnet;
    nodejs  = pkgs.custom.toolchain-nodejs;
    bun     = pkgs.custom.toolchain-bun;
    # haskell = pkgs.custom.toolchain-haskell;
    odin    = pkgs.custom.toolchain-odin;
    esp     = pkgs.custom.toolchain-esp;
  };
in
{
  # ~/.toolchains/<name> → nix store derivation
  home.file = builtins.listToAttrs (builtins.map (name: {
    name = ".toolchains/${name}";
    value = { source = toolchains.${name}; };
  }) (builtins.attrNames toolchains));

  home.sessionPath = [
    "$HOME/.cargo/bin" # Rust
    "$HOME/.cabal/bin" # Haskell
  ] ++ (builtins.map (name: "$HOME/.toolchains/${name}/bin") (builtins.attrNames toolchains));
}