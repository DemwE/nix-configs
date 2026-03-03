{ ... }:
{
  # Enable weekly TRIM for SSDs
  services.fstrim.enable = false;

  # Memory pressure helpers
  zramSwap = {
    enable = false;
    algorithm = "zstd";
    memoryPercent = 25; # 25% RAM as zram
  };

  systemd.oomd.enable = true;

  # Auto-tune all tunables at boot (USB autosuspend, PCIe ASPM, NIC power save, etc.)
  powerManagement.powertop.enable = true;
}
