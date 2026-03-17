# Registry of all custom/patched package definitions

pkgs:
pkgs.lib.mergeAttrsList (
  map (f: import f pkgs) [
    ./utils/switch.nix
    ./utils/switch-check.nix
    ./utils/update-lock.nix
    ./utils/compress.nix
    ./utils/battery.nix
    ./utils/gpu.nix
    ./utils/ventoy.nix
    ./toolchains
    ./ide
    ./libericaJDK
  ]
)
