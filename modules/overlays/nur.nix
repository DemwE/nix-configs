# Expose NUR (Nix User Repository) under `pkgs.nur`
# Usage: pkgs.nur.repos.<owner>.<pkg>

final: prev:
let
  nurPkgs =
    import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        sha256 = "05c7c422xnphmdk1d2s5wa6fmvg1v42nz3ggffc2d0irjfrgsfxc";
      })
      {
        pkgs = prev;
      };
in
{
  nur = nurPkgs;
}
