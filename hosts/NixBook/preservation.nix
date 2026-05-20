{ lib, pkgs, ... }:
{
  # 1. Włączamy nowoczesne initrd oparte na systemd
  boot.initrd.systemd.enable = true;

  # Dorzucamy niezbędne narzędzia do obrazu initrd, żeby systemd miał je pod ręką
  boot.initrd.systemd.initrdBin = [
    pkgs.btrfs-progs
    pkgs.e2fsprogs
  ];

  # 2. Poprawna definicja usługi dla systemd w initrd
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume";
    wantedBy = [ "initrd.target" ];
    before = [ "sysroot.mount" ];
    after = [ "dev-disk-by\\x2duuid-4749bcc1\\x2d1605\\x2d4812\\x2d9ae3\\x2db3e733bb6dfa.device" ];

    unitConfig.DefaultDependencies = "no";

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # W systemd initrd komendy basha podaje się bezpośrednio w ExecStart
      ExecStart = pkgs.writeScript "btrfs-rollback" ''
        #!${pkgs.pkgsStatic.bash}/bin/bash
        mkdir -p /btrfs
        mount -t btrfs /dev/disk/by-uuid/4749bcc1-1605-4812-9ae3-b3e733bb6dfa /btrfs

        if [ -e /btrfs/@root ]; then
            if [ -e /btrfs/@root/var/empty ]; then
                chattr -i /btrfs/@root/var/empty
            fi

            timestamp=$(date +%Y-%m-%d_%H-%M-%S)
            echo "--> moving existing @root to /btrfs/old_roots/@root_$timestamp..."
            mkdir -p /btrfs/old_roots
            mv /btrfs/@root "/btrfs/old_roots/@root_$timestamp"
        fi

        echo "--> creating new @root subvolume..."
        btrfs subvolume create /btrfs/@root

        umount /btrfs
      '';
    };
  };

  preservation = {
    enable = true;

    preserveAt."/persist" = {
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/lib/bluetooth"
        "/var/lib/cups"
        "/var/lib/fprint"
        "/var/lib/AccountsService"
        "/var/lib/flatpak"
        "/var/lib/containers/storage"
        "/var/db/sudo"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
