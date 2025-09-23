{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.qemu;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.qemu.enable = mkEnableOption "Enable QEMU virtualization stack (libvirtd, OVMF, virt-manager)";
  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ (pkgs.OVMF.override { secureBoot = true; tpmSupport = true; }).fd ];
        };
      };
    };
    environment.systemPackages = [ pkgs.qemu pkgs.virt-manager ];
  };
}
