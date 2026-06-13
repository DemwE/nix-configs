{ lib, pkgs, config, ... }:
{
  # Enable systemd-based initrd and include required tools for BTRFS and filesystem setup
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.initrdBin = [
    pkgs.btrfs-progs
    pkgs.e2fsprogs
    pkgs.coreutils
  ];
  # Disable machine-id commit in initrd; preserve machine-id separately under /persist
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathExists = "/never/path";
  };

  # Rollback service for BTRFS root subvolume setup in initrd
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume";
    wantedBy = [ "initrd.target" ];
    before = [ "sysroot.mount" ];
    after = [ "dev-disk-by\\x2duuid-4749bcc1\\x2d1605\\x2d4812\\x2d9ae3\\x2db3e733bb6dfa.device" ];

    unitConfig.DefaultDependencies = "no";

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
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

      echo "--> checking for old @root subvolumes to clean up..."
      cd /btrfs/old_roots
      ls -d @root_* | sort | head -n -4 | while read -r old_root; do
          echo "--> removing old root subvolume: /btrfs/old_roots/$old_root"
          btrfs subvolume delete -R "/btrfs/old_roots/$old_root"
      done
      cd /

      umount /btrfs
    '';
  };

  preservation = {
    enable = true;

    preserveAt."/persist" = {
      commonMountOptions = [
        { name = "x-gvfs-hide"; }
        { name = "x-gdu.hide"; }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
      directories = [
        "/var/lib/nixos"
        "/var/lib/bluetooth"
        "/var/lib/cups"
        "/var/lib/fprint"
        "/var/lib/flatpak"
        "/var/lib/AccountsService"
        "/var/lib/containers/storage"
        "/var/lib/iwd"
      ]
      ++ lib.optionals config.my.services.tailscale.enable [
        "/var/lib/tailscale"
      ];
    };
  };
}
