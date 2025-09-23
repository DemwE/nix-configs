{ my, pkgs, lib, ... }:
let hypr = my.features.hyprland.enable; qemuEnabled = my.features.qemu.enable; in {
  home.packages =
    with pkgs;
    [
      fzf
      ripgrep
      brave
      catppuccin-cursors.mochaLavender
    ]
    ++ lib.optionals hypr [
      foot
      grim
      slurp
      swappy
      pavucontrol
      pamixer
      brightnessctl
      playerctl
      hyprpicker
      wl-clipboard
      wlogout
      qalculate-gtk
      nemo-with-extensions
      nemo-fileroller
      mpv
    ]
    ++ lib.optionals qemuEnabled [ dnsmasq ];
}
