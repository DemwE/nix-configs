{ ... }:
{
  # Enable weekly TRIM for SSDs
  services.fstrim.enable = true;

  # Memory pressure helpers
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 35; # 35% RAM as zram
  };

  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
  };
}
