# Registry of all custom/patched package definitions

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./utils/compress.nix
    ./utils/battery.nix
    ./utils/gpu.nix
    ./toolchains
    ./ide
    ./libericaJDK
    # ./cli
    # ./fonts
  ])
