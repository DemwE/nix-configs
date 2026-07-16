{ config, pkgs, ... }:

{
  virtualisation.incus = {
    enable = true;
    ui.enable = true;

    preseed = {
      networks = [
        {
          name = incusbr0;
          type = "bridge";
          config = {
            "ipv4.address" = "10.0.100.1/24"; "ipv4.nat" = "true";
          }
        }
      ];
      storage-pools = [
        {
          name = "default";
          driver = "btrfs";
          config = {
            source = "/var/lib/incus/storage-pools/default";
          }
        }
      ];
      # instances = [
      #   {
      #     name = "incus-test-container";
      #     source = {
      #       type = "image";
      #       mode = "pull";
      #       server = "https://images.linuxcontainers.org";
      #       protocol = "simplestreams";
      #       alias = "ubuntu/24.04";
      #     };
      #     config = {
      #       "boot.autostart" = "true";
      #     }
      #   }
      # ];
    }
  }
}