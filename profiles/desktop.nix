{ ... }:
{
  my.features.hyprland.enable = true;
  my.features.sddm.enable = true;
  my.features.docker.enable = true;
  my.features.qemu.enable = true;
  my.features.polkit.enable = true;
  my.features.bluetooth.enable = false;

  my.desktop = {
    # Check available options in modules/desktop.nix
  };
}
