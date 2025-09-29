{ ... }:
{
  imports = [
    ./base.nix # Base profile (kept for future shared logic)
  ];

  my.features.hyprland.enable = true;
  my.features.nvidia.enable = true;
  my.features.sddm.enable = true;
  my.features.docker.enable = true;
  my.features.qemu.enable = true;
  my.features.polkit.enable = true;
  my.features.wifi.enable = false;
  my.features.bluetooth.enable = false;
  my.features.mobile-applets.enable = false;

  my.desktop = {
    # Check available options in modules/desktop.nix
    monitors = [
      "DP-1,2560x1440@165,0x0,1"
      "HDMI-A-1,1920x1080@60,-1080x-150,1,transform,1"
    ];
    workspaces = [
      "1,monitor:DP-1"
      "2,monitor:DP-1"
      "3,monitor:DP-1"
      "4,monitor:DP-1"
      "5,monitor:DP-1"
      "6,monitor:DP-1"
      "7,monitor:DP-1"
      "8,monitor:HDMI-A-1"
    ];
  };
}
