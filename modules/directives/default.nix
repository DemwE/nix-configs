# Registry of all custom/patched package definitions

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./utils/compress.nix
    ./toolchains
    ./ide
    # ./cli
    # ./fonts
  ])
