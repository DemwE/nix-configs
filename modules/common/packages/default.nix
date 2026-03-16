{ lib, pkgs, ... }:
{
  options.my.systemPackages = {
    enable = lib.mkEnableOption "Enable system packages configuration";
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "List of system packages to install";
    };
  };

  config = lib.mkIf config.my.systemPackages.enable {
    environment.systemPackages =
      config.my.systemPackages.packages
      ++ (with pkgs; [
        neovim
        zsh
        fastfetch
        btop
        duf
        tree
        wget
        git
        yazi
        bat
      ]);
  };
}
