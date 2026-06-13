{ ... }:
{
  my.boot.kernel = "lts";
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
}
