# Expose Python interpreters to PyCharm via ~/.pyenv/versions/
# PyCharm automatically scans ~/.pyenv/versions/ for Python interpreters.
{ pkgs, ... }:
let
  pythons = {
    "3.11" = pkgs.python311;
    "3.12" = pkgs.python312;
    "3.13" = pkgs.python313;
    "3.14" = pkgs.python314;
    "3.15" = pkgs.python315;
  };
in
{
  home.file = builtins.listToAttrs (
    map (ver: {
      name  = ".pyenv/versions/${ver}";
      value = { source = pythons.${ver}; };
    }) (builtins.attrNames pythons)
  );
}
